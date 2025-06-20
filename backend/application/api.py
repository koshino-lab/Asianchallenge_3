from application import app
from application.DBcontroller import ope
from ultralytics import YOLO
from flask import request, jsonify
import random
import string
import os

QUIZ_NUM = ope.query("SELECT COUNT(*) FROM quiz AS T")[0][0]


def createUserID():
  chars = string.ascii_letters + string.digits
  return ''.join(random.choices(chars, k=16))


@app.route("/api/quiz", methods=['GET', 'POST'])
def quiz():
  if request.method == 'GET':
    # クイズを取得
    quizID = request.args.get("quizID", None)
    if quizID is None:
      return jsonify({ "error": "Bad Request" }), 400

    res = ope.query("SELECT T.problem FROM quiz AS T WHERE T.quizID = %(quizID)s", args={'quizID': quizID}, prepared=True)
    if not res:
      return jsonify({ "error": "Bad Request" }), 400

    res = res[0][0]
    return jsonify({ "quiz": res })

  elif request.method == 'POST':
    # クイズの答え合わせ
    # データはformで取得
    if request.form is None:
      return jsonify({ "error": "Bad Request" }), 400

    quizID = request.form.get("quizID", None)
    if quizID is None:
      return jsonify({ "error": "Bad Request" }), 400

    quiz = ope.query("SELECT T.problem, T.answer, T.type FROM quiz AS T WHERE T.quizID = %(quizID)s", args={'quizID': int(quizID)}, prepared=True, dictionary=True)
    if not quiz:
      return jsonify({ "error": "Bad Request" }), 400

    quiz = quiz[0]
    
    if quiz['type'] == 1:
      # まだテストできていない
      if 'file' not in request.files:
        return jsonify({ "error": "Bad Request" }), 400

      answer = request.files['file']
      if answer.filename == '':
        return jsonify({ "error": "Bad Request" }), 400

      model_path = os.getenv('MODEL_DIR', './model/') + quiz['answer']
      if not os.path.isfile(model_path):
        return jsonify({ "error": "Internal Server Error" }), 500

      model = YOLO(model_path)
      try:
        image = Image.open(file.stream)
        img = np.asarray(image)
      except Exception as e:
        return jsonify({ "error": "Bad Request" }), 400

      res = model(img)[0]
      if len(res.boxes.cls) > 0:
        return jsonify({"status": "success"}), 200
      else:
        return jsonify({"status": "incorrect"}), 200

    elif quiz['type'] == 0:
      answer = request.form.get("answer", None)
      if answer is None:
        return jsonify({ "error": "Bad Request" }), 400

      # 大文字や全角への対応が必要になるかも
      if answer == quiz['answer']:
        return jsonify({"status": "success"}), 200
      else:
        return jsonify({"status": "incorrect"}), 200

  return jsonify({ "error": "Bad Request" }), 400

# UserIDを作成する
@app.route("/api/createID", methods=['GET'])
def create_id():
  while True:
    userID = createUserID()
    res = ope.query("SELECT * FROM correct_answer AS T WHERE T.userID = %(userID)s", args={'userID': userID}, prepared=True)
    if len(res) == 0:
      break
  return jsonify({ "userID": userID })

# 現在の進捗を取得する
@app.route("/api/progress", methods=['GET'])
def progress():
  userID = request.args.get("userID", None)
  if userID is None:
    return jsonify({ "error": "Bad Request" }), 400

  userID = int(userID)

  res = ope.query("SELECT T.quizID FROM correct_answer AS T WHERE T.userID = %(userID)s", args={'userID': userID}, prepared=True)
  return jsonify([x[0] for x in res]), 200

# 正答率を取得
# quizID is Noneの時、全て取得
@app.route("/api/correctAnswerRate", methods=['GET'])
def correctAnswerRate():
  res = ope.query("SELECT COUNT(*) FROM (SELECT T.userID FROM correct_answer AS T GROUP BY T.userID) AS T")
  if not res:
    return jsonify({"correctAnswerRate": 0.0}), 200

  car = res[0][0]
  qres = ope.query("SELECT T.quizID, COUNT(*) FROM correct_answer AS T GROUP BY T.quizID")
  print(car)
  print(qres)
  qres = { q[0]: q[1] for q in qres }
  print(qres)
  qres = [ qres.get(i, 0) for i in range(QUIZ_NUM) ]
  print(qres)
  quizID = request.args.get("quizID", None)
  if quizID is None:
    return jsonify([ {"correctAnswerRate": 100 * q / car} for q in qres ]), 200
  else:
    try:
      quizID = int(quizID)
    except ValueError:
      return jsonify({ "error": "Bad Request" }), 400
    if quizID >= QUIZ_NUM or quizID < 0:
      return jsonify({ "error": "Bad Request" }), 400
    return jsonify({"correctAnswerRate": 100 * qres[quizID] / car}), 200

