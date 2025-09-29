1. 以下のコマンドを実行して必要なライブラリのインストール。

```bash
python -m venv venv
source venv/bin/activate
(source venv/bin/activate.fish)

pip install -r requirements.txt
```

1. PostgreSQLを起動し、main.pyを実行

```bash
brew services start postgresql
source venv/bin/activate
python main.py
```