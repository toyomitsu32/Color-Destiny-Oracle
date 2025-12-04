#!/bin/bash
set -e

echo "🚀 Starting Flutter Web build for Cloudflare Pages..."

# Flutter SDKのパスを設定（Cloudflare Pagesの環境による）
export PATH="$PATH:/opt/buildhome/.flutter/bin"

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
