import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import '../models/action_item.dart';
import '../providers/fortune_provider.dart';
import 'result_screen.dart';

class Step3Roulette extends StatefulWidget {
  const Step3Roulette({super.key});

  @override
  State<Step3Roulette> createState() => _Step3RouletteState();
}

class _Step3RouletteState extends State<Step3Roulette> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  bool _isSpinning = false;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _spinRoulette() {
    if (_isSpinning) return;

    setState(() {
      _isSpinning = true;
      _selectedIndex = math.Random().nextInt(ActionItem.actions.length);
    });

    // 選択されたアクションの角度を計算
    final targetRotations = 5; // 5回転
    final itemAngle = 2 * math.pi / ActionItem.actions.length;
    final targetAngle = targetRotations * 2 * math.pi + (_selectedIndex! * itemAngle);

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: targetAngle,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward(from: 0).then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          final provider = Provider.of<FortuneProvider>(context, listen: false);
          provider.selectAction(ActionItem.actions[_selectedIndex!]);
          
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const ResultScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeOut),
                    ),
                    child: child,
                  ),
                );
              },
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 3: ルーレット'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFFD700)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF0F0E17),
              const Color(0xFF1A1A2E),
              const Color(0xFF9D4EDD).withValues(alpha: 0.2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ヘッダー
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.casino,
                      size: 60,
                      color: Color(0xFFFFD700),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'ルーレットを回して\n今日のアクションを決めましょう',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // ルーレット
              Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // ルーレットホイール
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _rotationAnimation.value,
                            child: _buildRouletteWheel(),
                          );
                        },
                      ),
                      
                      // 中央のインジケーター
                      Positioned(
                        top: 0,
                        child: Container(
                          width: 30,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFD700),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFFD700).withValues(alpha: 0.6),
                                blurRadius: 15,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                      
                      // 中央のボタン
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF9D4EDD),
                              Color(0xFF6A0DAD),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF9D4EDD).withValues(alpha: 0.6),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _isSpinning ? null : _spinRoulette,
                            borderRadius: BorderRadius.circular(50),
                            child: Center(
                              child: _isSpinning
                                  ? const SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.play_arrow,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // スタートボタン説明
              if (!_isSpinning)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'タップしてルーレットを回す',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                      color: const Color(0xFFFFD700),
                    ),
                  ),
                ),
              
              // 進行状況インジケーター
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStepDot(true),
                    const SizedBox(width: 8),
                    _buildStepDot(true),
                    const SizedBox(width: 8),
                    _buildStepDot(true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepDot(bool isActive) {
    return Container(
      width: isActive ? 30 : 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFFD700) : Colors.white30,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _buildRouletteWheel() {
    return CustomPaint(
      size: const Size(300, 300),
      painter: _RoulettePainter(),
    );
  }
}

class _RoulettePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final itemCount = ActionItem.actions.length;
    final anglePerItem = 2 * math.pi / itemCount;

    // 各セグメントを描画
    for (int i = 0; i < itemCount; i++) {
      final startAngle = i * anglePerItem - math.pi / 2;
      final sweepAngle = anglePerItem;

      // グラデーションカラー
      final colors = [
        const Color(0xFF9D4EDD),
        const Color(0xFF6A0DAD),
        const Color(0xFF8B5CF6),
        const Color(0xFFAB47BC),
      ];
      final color = colors[i % colors.length];

      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      // セグメントを描画
      final rect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);

      // 境界線を描画
      final borderPaint = Paint()
        ..color = const Color(0xFFFFD700).withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawArc(rect, startAngle, sweepAngle, true, borderPaint);

      // 番号を描画
      final textAngle = startAngle + sweepAngle / 2;
      final textRadius = radius * 0.7;
      final textX = center.dx + textRadius * math.cos(textAngle);
      final textY = center.dy + textRadius * math.sin(textAngle);

      final textPainter = TextPainter(
        text: TextSpan(
          text: '${i + 1}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(textX - textPainter.width / 2, textY - textPainter.height / 2),
      );
    }

    // 外枠を描画
    final outerPaint = Paint()
      ..color = const Color(0xFFFFD700)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(center, radius, outerPaint);

    // 内側の円を描画
    final innerPaint = Paint()
      ..color = const Color(0xFF1A1A2E)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 50, innerPaint);

    final innerBorderPaint = Paint()
      ..color = const Color(0xFFFFD700)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(center, 50, innerBorderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
