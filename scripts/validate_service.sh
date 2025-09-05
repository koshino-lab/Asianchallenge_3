#!/bin/bash
# サービスが正常に動作しているか確認するスクリプト

echo "Validating Flask service..."

# Flaskアプリケーションのステータスを確認
if systemctl is-active --quiet flask-app; then
    echo "Flask service is running."
else
    echo "Flask service is not running!" >&2
    exit 1
fi

# ローカルでFlaskアプリケーションにアクセスできるか確認
if curl -f -s http://localhost:5000/ > /dev/null; then
    echo "Flask application is responding on port 5000."
else
    echo "Flask application is not responding!" >&2
    exit 1
fi

# nginxが正常に動作しているか確認
if systemctl is-active --quiet nginx; then
    echo "Nginx service is running."
else
    echo "Nginx service is not running!" >&2
    exit 1
fi

echo "All services validated successfully!"