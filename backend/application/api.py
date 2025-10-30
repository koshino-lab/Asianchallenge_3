from application import app
from application.DBcontroller import db, Quiz, CorrectAnswer, Users
# from ultralytics import YOLO
from flask import request, jsonify
from sqlalchemy import func
from sqlalchemy.dialects.postgresql import insert
from PIL import Image
import numpy as np
import random
import string
import os
import base64
import json
from io import BytesIO

# テストです！！！！！！

def createUserID():
  chars = string.ascii_letters + string.digits
  return ''.join(random.choices(chars, k=16))


@app.route("/api/quiz", methods=['GET', 'POST'])
def quiz():
  
  if request.method == 'GET':
    # クイズを取得
    quizID = request.args.get("quizID", None)
    if quizID is None:
      app.logger.debug("quizID is None")
      return jsonify({ "error": "Bad Request" }), 400
    try:
      quizID = int(quizID)
    except ValueError:
      app.logger.debug(f"Invalid quizID: {quizID}")
      return jsonify({"error": "Invalid quizID"}), 400

    res = Quiz.query.filter_by(quizID=quizID).first()
    if not res:
      app.logger.debug(f"Quiz does not exist(quizID={quizID})")
      return jsonify({ "error": "Bad Request" }), 400

    return jsonify({ "quiz": res.problem, "hint": res.hint, "type": res.type })

  elif request.method == 'POST':
    # クイズの答え合わせ
    # データはformで取得
    if request.is_json and 'quizID' in request.json:
      data = request.json
    elif request.form and 'quizID' in request.form:
      data = request.form
    else:
      try:
        data = request.data.decode('utf-8')
        data = json.loads(data)
      except:
        app.logger.debug(f"request.form or request.json does not exist and request.data is not None({request.data})")
        return jsonify({ "error": "Bad Request" }), 400

    userID = data.get("userID", None)
    if userID is None:
      app.logger.debug(f"userID is None({data})")
      return jsonify({ "error": "Bad Request" }), 400
    user = Users.query.get(userID)
    if not user:
      app.logger.debug(f"userID is not registered({data})")
      return jsonify({ "error": "Bad Request" }), 400

    quizID = data.get("quizID", None)
    if quizID is None:
      app.logger.debug(f"quizID is None({data})")
      return jsonify({ "error": "Bad Request" }), 400

    try:
      quizID = int(quizID)
    except ValueError:
      app.logger.debug(f"Invalid quizID: {quizID}")
      return jsonify({"error": "Invalid quizID"}), 400
    correct = CorrectAnswer.query.filter_by(quizID=quizID, userID=userID).first()
    if correct:
      app.logger.debug(f"Already cleared")
      return jsonify({ "error": "Bad Request" }), 400

    quiz = Quiz.query.filter_by(quizID=quizID).first()
    if not quiz:
      app.logger.debug(f"Quiz does not exist(quizID={quizID})")
      return jsonify({ "error": "Bad Request" }), 400

    answer = data.get("answer", None)
    if quiz.type == 1:
      if answer is None:
        if 'file' in request.files:
          answer = request.files['file']
          if answer.filename == '':
            app.logger.debug(f"filename does not exist")
            return jsonify({ "error": "Bad Request" }), 400
          answer = answer.stream
        else:
          app.logger.debug(f"file does not exist")
          return jsonify({ "error": "Bad Request" }), 400
      else:
        try:
          answer = base64.b64decode(answer)
          answer = BytesIO(answer)
        except (binascii.Error, ValueError) as e:
          app.logger.error(f"base64 decode error: {e}")
          return jsonify({"error": "Bad Request"}), 400

      model_path = os.getenv('MODEL_DIR', './model/') + quiz.answer
      if not os.path.isfile(model_path):
        app.logger.error(f"model does not exist(path={model_path})")
        return jsonify({ "error": "Internal Server Error" }), 500

#      model = YOLO(model_path)
      try:
        image = Image.open(answer).convert('RGB')
        img = np.asarray(image).copy()
        img[..., [0, 2]] = img[..., [2, 0]]
      except Exception as e:
        app.logger.error(f"file is not image: {e}")
        return jsonify({ "error": "Bad Request" }), 400

      res = model(img)[0]
      if len(res.boxes.cls) > 0:
        db.session.add(CorrectAnswer(quizID=quizID, userID=userID))
        db.session.commit()
        return jsonify({"status": "success"}), 200
      else:
        return jsonify({"status": "incorrect"}), 200

    elif quiz.type == 0:
      if answer is None:
        app.logger.debug(f"answer does not exist({request.form})")
        return jsonify({ "error": "Bad Request" }), 400

      # 大文字や全角への対応が必要になるかも
      if answer == quiz.answer:
        db.session.add(CorrectAnswer(quizID=quizID, userID=userID))
        db.session.commit()
        return jsonify({"status": "success"}), 200
      else:
        return jsonify({"status": "incorrect"}), 200

  return jsonify({ "error": "Bad Request" }), 400

# UserIDを作成する
@app.route("/api/createID", methods=['GET'])
def create_id():
  while True:
    userID = createUserID()
    user = Users.query.get(userID)
    if user is None:
      break

  user = Users(userID=userID)
  db.session.add(user)
  db.session.commit()
  return jsonify({ "userID": userID })

# 現在の進捗を取得する
@app.route("/api/progress", methods=['GET'])
def progress():
  userID = request.args.get("userID", None)
  if userID is None:
    return jsonify({ "error": "Bad Request" }), 400

  userID = int(userID)

  res = CorrectAnswer.query.filter_by(userID=userID).all()
  return jsonify([x.quizID for x in res]), 200

# 正答率を取得
# quizID is Noneの時、全て取得
@app.route("/api/correctAnswerRate", methods=['GET'])
def correctAnswerRate():
  user_num = Users.query.count()
  quiz_num = Quiz.query.count()
  if user_num == 0:
    if request.args.get("quizID", None) is None:
      return jsonify([{"correctAnswerRate": 0.0} for i in range(quiz_num)]), 200
    else:
      return jsonify({"correctAnswerRate": 0.0}), 200

  qres = db.session.query(CorrectAnswer.quizID, func.count()).group_by(CorrectAnswer.quizID).all()
  qres = { q[0]: q[1] for q in qres }
  qres = [ qres.get(i, 0) for i in range(quiz_num) ]
  quizID = request.args.get("quizID", None)
  if quizID is None:
    return jsonify([ {"correctAnswerRate": 100 * q / user_num} for q in qres ]), 200
  else:
    try:
      quizID = int(quizID)
      q = qres[quizID]
    except Exception as e:
      app.logger.debug(f"quizID Error: {e}")
      return jsonify({ "error": "Bad Request" }), 400
    if q is None:
      return jsonify({ "error": "Bad Request" }), 400
    return jsonify({"correctAnswerRate": 100 * q / user_num}), 200

@app.route('/XsGCKgHtlP/initdb')
def initdb():
  app.logger.info(f"DATABASE_URL: {os.getenv('DATABASE_URL')}")
  app.logger.info(f"FRONTEND_URL: {os.getenv('FRONTEND_URL')}")
  db.create_all()
  quizzes = [
    {'quizID': 1, 'problem': "助けを求めている露店がある。その露店の名前はなんだ(半角小文字英数字)", 'answer': "中華まつもっちゃん", 'hint': "モールス信号", 'type': 0},
    {'quizID': 2, 'problem': "画像を表示", 'answer': "イノシシ", 'hint': "最近できた塔の4階", 'type': 0},
    {'quizID': 3, 'problem': "学生玄関を入ったら右手の「階段」を上がって二階に行こう。\n階段を上がると上の方に『図書館◀︎50m』と言う案内が書かれている。案内に従って「左」に進もう。\n左手の教員室の扉を二つ越えて右にある渡り廊下を進もう。\n天井の二つの蛍光灯を通り過ぎれば図書館に着く。\nまっすぐ進んでパンフレットの中に紛れ込んだ宝箱の中に答えは記されている。\n※宝箱は持って行かないでね", 'answer': "ラーコモ", 'hint': "", 'type': 0},
    {'quizID': 4, 'problem': "画像と、「賞状は無視して！」と表示", 'answer': "第35回全国高等専門学校プログラミングコンテスト", 'hint': "カップや楯に書いてある言葉に注目！", 'type': 0},
    {'quizID': 5, 'problem': "画像と、「間違いを探せ」と表示", 'answer': "テクノパレット", 'hint': "間違い探しの答えが最終の答えではない。また、C科塔ではない。", 'type': 0},
    {'quizID': 6, 'problem': "画像を表示", 'answer': "建築", 'hint': "写真に写っている文字と問題の文字を除くと…", 'type': 0},
    {'quizID': 7, 'problem': "太陽が見ている食べ物は何？", 'answer': "アイス", 'hint': "看板を探してみよう！", 'type': 0},
    {'quizID': 8, 'problem': "画像を表示、「6号館から1号館の方向に並べろ！」", 'answer': "はつでん", 'hint': "窓から見える", 'type': 0},
    {'quizID': 9, 'problem': "写真ブースの中に宝箱がある！探せ", 'answer': "60th", 'hint': "", 'type': 0}
]
  stmt = insert(Quiz).values(quizzes)

  update_dict = {
    'problem': stmt.excluded.problem,
    'answer': stmt.excluded.answer,
    'type': stmt.excluded.type
  }
  stmt = stmt.on_conflict_do_update(
    index_elements=['quizID'],
    set_=update_dict
  )
  db.session.execute(stmt)
  db.session.commit()
  return jsonify({"status": "success"}), 200
