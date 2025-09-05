#!/bin/bash
# 依存関係をインストールするスクリプト

echo "Installing dependencies..."

cd /opt/app/backend

# 仮想環境をアクティベート
source venv/bin/activate

# pipを最新版に更新
pip install --upgrade pip

# 依存関係をインストール
pip install -r requirements.txt

echo "Dependencies installed successfully."