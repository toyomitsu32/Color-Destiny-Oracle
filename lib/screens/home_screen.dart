import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/fortune_provider.dart';
import 'step1_color_selection.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0F0E17),
              const Color(0xFF1A1A2E),
              const Color(0xFF9D4EDD).withValues(alpha: 0.3),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // タイトル
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF9D4EDD).withValues(alpha: 0.3),
                          const Color(0xFFFFD700).withValues(alpha: 0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF9D4EDD).withValues(alpha: 0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          '四柱推命',
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 28,
                            letterSpacing: 8,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '開運カラー診断',
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 36,
                            letterSpacing: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // 星のアイコン
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFFFD700).withValues(alpha: 0.4),
                          const Color(0xFF9D4EDD).withValues(alpha: 0.2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      size: 80,
                      color: Color(0xFFFFD700),
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // 説明テキスト
                  Text(
                    '3つのステップで\nあなたの今日の開運アクションを診断',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 18,
                      height: 1.6,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 50),
                  
                  // 開始ボタン
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<FortuneProvider>(context, listen: false).reset();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Step1ColorSelection(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '診断を始める',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.arrow_forward, size: 24),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                  
                  // ステップインジケーター
                  _buildStepIndicators(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicators(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFF9D4EDD).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStepItem(context, '1', 'カラー選択', Icons.palette),
          _buildStepDivider(),
          _buildStepItem(context, '2', '通変星', Icons.style),
          _buildStepDivider(),
          _buildStepItem(context, '3', 'ルーレット', Icons.casino),
        ],
      ),
    );
  }

  Widget _buildStepItem(BuildContext context, String number, String label, IconData icon) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                const Color(0xFF9D4EDD).withValues(alpha: 0.6),
                const Color(0xFFFFD700).withValues(alpha: 0.4),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF9D4EDD).withValues(alpha: 0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFFFD700),
          ),
        ),
      ],
    );
  }

  Widget _buildStepDivider() {
    return Container(
      width: 30,
      height: 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF9D4EDD).withValues(alpha: 0.5),
            const Color(0xFFFFD700).withValues(alpha: 0.3),
          ],
        ),
      ),
    );
  }
}
