import os
import json
from application.DBcontroller.DBcontroller import MysqlOperator

ope = MysqlOperator(os.getenv('DB_CONFIG_JSON', './db_config.json'))


