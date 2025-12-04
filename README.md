# 四柱推命開運カラー診断 (Fortune Colors)

[![Cloudflare Pages](https://img.shields.io/badge/Deploy-Cloudflare%20Pages-orange)](https://color-destiny-oracle.pages.dev)

## 概要

四柱推命とカラーをもとにした診断アプリケーション。3つのステップで前向きなアクションを提案します。

## 機能

### 3ステップ診断
- **Step 1**: 24色のカラーパレットから直感で1色を選択
- **Step 2**: 10枚の星デザインカードから1枚選択（通変星）
- **Step 3**: ルーレットで31種類のアクションからランダム選択

### 主な機能
- ✨ 24色の美しいカラーパレット
- ⭐ 10種類の四柱推命通変星（比肩、劫財、食神、傷官、偏財、正財、偏官、正官、偏印、印綬）
- 🎯 31種類の前向きなアクション
- 🖼️ 16:9の結果画像生成
- 📥 画像ダウンロード機能（Web対応）
- 📤 SNSシェア機能
- 🎨 神秘的な紫×金のデザインテーマ
- ⚡ スムーズなアニメーション

## デプロイ

### Cloudflare Pages
このプロジェクトはビルド済みのWebファイルを含んでいます。

**設定:**
```
Build command: (空欄)
Build output directory: build/web
```

### ローカル開発
```bash
flutter pub get
flutter run -d chrome
```

### ビルド
```bash
flutter build web --release
```

## 技術スタック

- **Flutter**: 3.35.4
- **Dart**: 3.9.2
- **プラットフォーム**: Web, Android
- **状態管理**: Provider
- **パッケージ**:
  - provider: 6.1.5+1
  - share_plus: 10.1.2
  - http: 1.5.0
  - path_provider: 2.1.5

## ライセンス

Copyright © 2024

## デモ

🌐 [Live Demo](https://color-destiny-oracle.pages.dev)
