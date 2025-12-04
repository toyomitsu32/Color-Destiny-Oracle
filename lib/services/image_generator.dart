import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../models/fortune_color.dart';
import '../models/star_card.dart';
import '../models/action_item.dart';

class ImageGenerator {
  static Future<Uint8List> generateResultImage({
    required FortuneColor color,
    required StarCard star,
    required ActionItem action,
  }) async {
    // 16:9のキャンバスを作成
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    const width = 1920.0;
    const height = 1080.0;
    
    // 背景色を塗りつぶす
    final backgroundPaint = Paint()..color = color.color;
    canvas.drawRect(
      const Rect.fromLTWH(0, 0, width, height),
      backgroundPaint,
    );
    
    // 上段：通変星
    _drawTopSection(canvas, star, width, height);
    
    // 区切り線
    _drawDivider(canvas, width, height);
    
    // 下段：アクション
    _drawBottomSection(canvas, action, width, height);
    
    // 装飾を追加
    _drawDecorations(canvas, width, height);
    
    // 画像に変換
    final picture = recorder.endRecording();
    final img = await picture.toImage(width.toInt(), height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final buffer = byteData!.buffer.asUint8List();
    
    return buffer;
  }
  
  static void downloadImage(Uint8List imageBytes, String fileName) {
    // Web環境では何もしない（result_screen.dartで直接処理）
  }
  
  static void _drawTopSection(Canvas canvas, StarCard star, double width, double height) {
    // 星アイコン
    final starIconPainter = TextPainter(
      text: const TextSpan(
        text: '✨',
        style: TextStyle(
          fontSize: 80,
          color: Colors.white,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    starIconPainter.layout();
    starIconPainter.paint(
      canvas,
      Offset((width - starIconPainter.width) / 2, height * 0.15),
    );
    
    // 通変星の名前
    final starNamePainter = TextPainter(
      text: TextSpan(
        text: star.name,
        style: const TextStyle(
          fontSize: 120,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 16,
          shadows: [
            Shadow(
              color: Colors.black45,
              offset: Offset(4, 4),
              blurRadius: 8,
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    starNamePainter.layout();
    starNamePainter.paint(
      canvas,
      Offset((width - starNamePainter.width) / 2, height * 0.28),
    );
  }
  
  static void _drawDivider(Canvas canvas, double width, double height) {
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(width * 0.2, height * 0.5),
        Offset(width * 0.8, height * 0.5),
        [
          Colors.white.withValues(alpha: 0.0),
          Colors.white,
          Colors.white.withValues(alpha: 0.0),
        ],
      )
      ..strokeWidth = 3;
    
    canvas.drawLine(
      Offset(width * 0.2, height * 0.5),
      Offset(width * 0.8, height * 0.5),
      paint,
    );
  }
  
  static void _drawBottomSection(Canvas canvas, ActionItem action, double width, double height) {
    // アクションテキスト（複数行対応）
    final actionPainter = TextPainter(
      text: TextSpan(
        text: action.text,
        style: const TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          height: 1.5,
          shadows: [
            Shadow(
              color: Colors.black45,
              offset: Offset(3, 3),
              blurRadius: 6,
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      maxLines: 3,
    );
    actionPainter.layout(maxWidth: width * 0.8);
    actionPainter.paint(
      canvas,
      Offset(
        (width - actionPainter.width) / 2,
        height * 0.6 + (height * 0.3 - actionPainter.height) / 2,
      ),
    );
  }
  
  static void _drawDecorations(Canvas canvas, double width, double height) {
    // 四隅に小さな星を描画
    final decorPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    
    final positions = [
      Offset(width * 0.1, height * 0.1),
      Offset(width * 0.9, height * 0.1),
      Offset(width * 0.1, height * 0.9),
      Offset(width * 0.9, height * 0.9),
    ];
    
    for (final pos in positions) {
      _drawStar(canvas, decorPaint, pos, 20);
    }
  }
  
  static void _drawStar(Canvas canvas, Paint paint, Offset center, double size) {
    final path = Path();
    for (int i = 0; i < 5; i++) {
      final angle = (i * 4 * 3.14159 / 5) - 3.14159 / 2;
      final x = center.dx + size * math.cos(angle);
      final y = center.dy + size * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }
}
