#!/bin/bash
set -e

echo "📦 Installing Flutter SDK..."

# Flutterのバージョン
FLUTTER_VERSION="3.35.4"
FLUTTER_CHANNEL="stable"

# Flutter SDKのインストールディレクトリ
FLUTTER_HOME="$HOME/flutter"

# 既にインストールされているかチェック
if [ -d "$FLUTTER_HOME" ]; then
    echo "✅ Flutter already installed"
    export PATH="$FLUTTER_HOME/bin:$PATH"
    flutter --version
    exit 0
fi

# Flutter SDKをダウンロード
echo "⬇️ Downloading Flutter SDK..."
cd $HOME
git clone https://github.com/flutter/flutter.git -b $FLUTTER_CHANNEL --depth 1

# PATHに追加
export PATH="$FLUTTER_HOME/bin:$PATH"

# Flutterの設定
echo "⚙️ Configuring Flutter..."
flutter config --no-analytics
flutter config --enable-web

# 依存関係をダウンロード
echo "📥 Downloading Flutter dependencies..."
flutter precache --web

# バージョン確認
echo "✅ Flutter installed successfully!"
flutter --version
