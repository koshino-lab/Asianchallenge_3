from application import app
from application.DBcontroller import db, Quiz, CorrectAnswer, Users
from flask import request, jsonify
from sqlalchemy import func
from sqlalchemy.dialects.postgresql import insert
import random
import string
import os

try:
  from ultralytics import YOLO
  from PIL import Image
  import numpy as np
  USE_YOLO = True
except ImportError:
  app.logger.info("Image recognition library is not available. Some functions are limited.")
  USE_YOLO = False



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

    res = Quiz.query.filter_by(quizID=quizID).first()
    if not res:
      app.logger.debug(f"Quiz does not exist(quizID={quizID})")
      return jsonify({ "error": "Bad Request" }), 400

    return jsonify({ "quiz": res.problem, "hint": res.hint, "type": res.type })

  elif request.method == 'POST':
    # クイズの答え合わせ
    # データはformで取得
    if request.form is None:
      app.logger.debug(f"request.form does not exist")
      return jsonify({ "error": "Bad Request" }), 400

    userID = request.form.get("userID", None)
    if userID is None:
      app.logger.debug(f"userID is None({request.form})")
      return jsonify({ "error": "Bad Request" }), 400
    user = Users.query.get(userID)
    if not user:
      app.logger.debug(f"userID is not registered({request.form})")
      return jsonify({ "error": "Bad Request" }), 400

    quizID = request.form.get("quizID", None)
    if quizID is None:
      app.logger.debug(f"quizID is None{request.form}")
      return jsonify({ "error": "Bad Request" }), 400

    quizID = int(quizID)

    correct = CorrectAnswer.query.filter_by(quizID=quizID, userID=userID).first()
    if correct:
      app.logger.debug(f"Already cleared")
      return jsonify({ "error": "Bad Request" }), 400


    quiz = Quiz.query.filter_by(quizID=int(quizID)).first()
    if not quiz:
      app.logger.debug(f"Quiz does not exist(quizID={quizID})")
      return jsonify({ "error": "Bad Request" }), 400

    if quiz.type == 1:
      # 画像認識についての処理
      if not USE_YOLO:
        app.logger.info(f"No image recognition libraries have been imported.")
        return jsonify({ "error": "Bad Request" }), 400


      if 'file' not in request.files:
        app.logger.debug(f"file does not exist")
        return jsonify({ "error": "Bad Request" }), 400

      answer = request.files['file']
      if answer.filename == '':
        app.logger.debug(f"filename does not exist")
        return jsonify({ "error": "Bad Request" }), 400

      model_path = os.getenv('MODEL_DIR', './model/') + quiz.answer
      if not os.path.isfile(model_path):
        app.logger.error(f"model does not exist(path={model_path})")
        return jsonify({ "error": "Internal Server Error" }), 500

      model = YOLO(model_path)
      try:
        image = Image.open(answer.stream).convert('RGB')
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
      # 画像認識以外についての処理
      answer = request.form.get("answer", None)
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
  user_num = len(Users.__table__.columns)
  if user_num == 0:
    return jsonify({"correctAnswerRate": 0.0}), 200

  quiz_num = len(Quiz.__table__.columns)
  qres = db.session.query(CorrectAnswer.quizID, func.count()).group_by(CorrectAnswer.quizID).all()
  qres = { q[0]: q[1] for q in qres }
  qres = [ qres.get(i, 0) for i in range(quiz_num) ]
  quizID = request.args.get("quizID", None)
  if quizID is None:
    return jsonify([ {"correctAnswerRate": 100 * q / user_num} for q in qres ]), 200
  else:
    try:
      quizID = int(quizID)
    except ValueError:
      return jsonify({ "error": "Bad Request" }), 400
    if quizID >= quiz_num or quizID < 0:
      return jsonify({ "error": "Bad Request" }), 400
    return jsonify({"correctAnswerRate": 100 * qres[quizID] / user_num}), 200

@app.route('/XsGCKgHtlP/initdb')
def initdb():
  db.create_all()
  quizzes = [
    {'quizID': 1, 'problem': "1+1は？", 'answer': "2", "hint": "田じゃないよ", 'type': 0},
    {'quizID': 2, 'problem': "天照大神、月読命、素戔嗚尊、この三柱をまとめて何という？", 'answer': "三貴子", "hint": "日本語で「みはしらのうずのみこ」と読むよ", 'type': 0},
    {'quizID': 3, 'problem': "Asian Bridge's logo", 'answer': "asian_logo.pt", "hint": "Asian Bridgeのロゴを探そう！", 'type': 1},
    {'quizID': 4, 'problem': "サメだ！殴れ！", 'answer': "SPC", "hint": "サメ殴りセンター", 'type': 0},
  ]
  stmt = insert(Quiz).values(quizzes)

  update_dict = {
    'problem': stmt.excluded.problem,
    'answer': stmt.excluded.answer,
    'type': stmt.excluded.type,
    'hint': stmt.excluded.hint
  }
  stmt = stmt.on_conflict_do_update(
    index_elements=['quizID'],
    set_=update_dict
  )
  db.session.execute(stmt)
  db.session.commit()
  return jsonify({"status": "success"}), 200
