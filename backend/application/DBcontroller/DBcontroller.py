from application.DBcontroller import db
from datetime import datetime

class Users(db.Model):
  __tablename__ = 'users'

  userID = db.Column(db.String(16), nullable=False, primary_key=True)
  time = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)

class Quiz(db.Model):
  __tablename__ = 'quiz'

  quizID = db.Column(db.SmallInteger, primary_key=True)
  problem = db.Column(db.String(512), nullable=False)
  answer = db.Column(db.String(64), nullable=False)
  type = db.Column(db.SmallInteger, nullable=False)  # TinyInt 相当

  def __repr__(self):
    return f"<Quiz {self.quizID}: {self.problem[:30]}>"

class CorrectAnswer(db.Model):
  __tablename__ = 'correct_answer'

  userID = db.Column(db.String(16), db.ForeignKey('users.userID', onupdate="CASCADE"), nullable=False, primary_key=True)
  quizID = db.Column(db.SmallInteger, db.ForeignKey('quiz.quizID', onupdate="CASCADE"), nullable=False, primary_key=True)
  time = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)

  def __repr__(self):
    return f"<CorrectAnswer user={self.userID}, quiz={self.quizID}>"

