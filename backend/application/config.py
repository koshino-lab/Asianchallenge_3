from datetime import timedelta
from dotenv import load_dotenv
load_dotenv()
import os

class DefaultConfig:
  DEBUG = False
  TESTING = False
  PERMANENT_SESSION_LIFETIME = timedelta(days=2)
  SECRET_KEY = os.getenv('SECRET_KEY', "AAAAA")
  SQLALCHEMY_DATABASE_URI = os.getenv("DATABASE_URL", "postgresql://flaskuser:password@localhost:5432/quiz_rally")


class DevelopmentConfig(DefaultConfig):
  DEBUG = True
  TESTING = True


class TestingConfig(DefaultConfig):
  DEBUG = False
  TESTING = True

