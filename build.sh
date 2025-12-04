#!/bin/bash
set -e

echo "🚀 Starting Flutter Web build for Cloudflare Pages..."

# Flutter SDKをインストール
if [ ! -d "$HOME/flutter" ]; then
    echo "📦 Installing Flutter SDK..."
    bash ./install_flutter.sh
fi

# Flutter SDKのパスを設定
export PATH="$HOME/flutter/bin:$PATH"

# Flutterのバージョンを確認
flutter --version

# 依存関係をインストール
echo "📦 Installing dependencies..."
flutter pub get

# Webビルドを実行
echo "🏗️ Building Flutter web app..."
flutter build web --release

echo "✅ Build completed successfully!"
echo "📂 Output directory: build/web"
