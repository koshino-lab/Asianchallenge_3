#!/bin/bash
# アプリケーションを起動するスクリプト

echo "Starting Flask application..."

# サービスファイルを再読み込み
systemctl daemon-reload

# Flaskアプリケーションを起動
systemctl start flask-app
systemctl enable flask-app

# nginxを再起動（設定が変更されている可能性があるため）
systemctl restart nginx

echo "Flask application started."