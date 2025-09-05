#!/bin/bash
# アプリケーションを停止するスクリプト

echo "Stopping Flask application..."
systemctl stop flask-app || true

echo "Flask application stopped."