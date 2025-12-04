import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/fortune_provider.dart';
import '../services/image_generator.dart';
import '../services/web_download_stub.dart'
    if (dart.library.html) '../services/web_download_web.dart';
import 'home_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _isGeneratingImage = false;
  Uint8List? _generatedImageBytes;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FortuneProvider>(context);
    final color = provider.selectedColor!;
    final star = provider.selectedStar!;
    final action = provider.selectedAction!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('診断結果'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Color(0xFFFFD700)),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            },
          ),
        ],
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                // タイトル
                Text(
                  'あなたの今日の開運アクション',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 30),
                
                // 結果カード（16:9のプレビュー）
                _buildResultCard(color, star, action),
                const SizedBox(height: 30),
                
                // 詳細情報
                _buildDetailCard(
                  context,
                  'あなたの色',
                  color.name,
                  color.description,
                  Icons.palette,
                  color.color,
                ),
                const SizedBox(height: 16),
                
                _buildDetailCard(
                  context,
                  'あなたの通変星',
                  '${star.name}（${star.reading}）',
                  star.description,
                  Icons.auto_awesome,
                  const Color(0xFFFFD700),
                ),
                const SizedBox(height: 16),
                
                _buildDetailCard(
                  context,
                  '今日のアクション',
                  action.text,
                  action.category,
                  Icons.check_circle,
                  const Color(0xFF9D4EDD),
                ),
                const SizedBox(height: 40),
                
                // アクションボタン
                _buildActionButtons(context, provider),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(color, star, action) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          color: color.color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.color.withValues(alpha: 0.5),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 上段：通変星
              Expanded(
                flex: 2,
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.auto_awesome,
                          size: 50,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          star.name,
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 8,
                            shadows: [
                              Shadow(
                                color: Colors.black45,
                                offset: Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              // 区切り線
              Container(
                height: 2,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.0),
                      Colors.white,
                      Colors.white.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
              
              // 下段：アクション
              Expanded(
                flex: 2,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      action.text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.4,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            offset: Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(
    BuildContext context,
    String title,
    String mainText,
    String subText,
    IconData icon,
    Color accentColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E).withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.4),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.2),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: accentColor,
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  mainText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subText,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, FortuneProvider provider) {
    return Column(
      children: [
        // 画像生成＆ダウンロードボタン
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _isGeneratingImage
                ? null
                : () => _generateAndDownloadImage(context, provider),
            icon: _isGeneratingImage
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.download),
            label: Text(
              _isGeneratingImage ? '画像生成中...' : '画像をダウンロード',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        const SizedBox(height: 12),
        
        // SNSシェアボタン
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _generatedImageBytes != null
                ? () => _shareImage()
                : null,
            icon: const Icon(Icons.share),
            label: const Text(
              'SNSでシェア',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFFFD700),
              side: const BorderSide(color: Color(0xFFFFD700), width: 2),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        const SizedBox(height: 12),
        
        // もう一度診断ボタン
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            },
            child: const Text(
              'もう一度診断する',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _generateAndDownloadImage(BuildContext context, FortuneProvider provider) async {
    setState(() {
      _isGeneratingImage = true;
    });

    try {
      final imageBytes = await ImageGenerator.generateResultImage(
        color: provider.selectedColor!,
        star: provider.selectedStar!,
        action: provider.selectedAction!,
      );

      if (mounted) {
        setState(() {
          _generatedImageBytes = imageBytes;
          _isGeneratingImage = false;
        });

        // Web用のダウンロード処理
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final fileName = 'fortune_result_$timestamp.png';
        downloadImageWeb(imageBytes, fileName);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('画像をダウンロードしました！'),
            backgroundColor: Color(0xFF52B788),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isGeneratingImage = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('エラーが発生しました: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _shareImage() async {
    if (_generatedImageBytes != null) {
      try {
        // 一時的にメモリ上の画像をXFileとして共有
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final fileName = 'fortune_result_$timestamp.png';
        
        await Share.shareXFiles(
          [XFile.fromData(_generatedImageBytes!, mimeType: 'image/png', name: fileName)],
          text: '四柱推命開運カラー診断の結果をシェア！ #開運診断 #四柱推命',
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('シェアに失敗しました: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
