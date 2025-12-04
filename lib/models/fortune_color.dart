import 'package:flutter/material.dart';

/// 24色のカラーパレット
class FortuneColor {
  final String name;
  final Color color;
  final String description;

  const FortuneColor({
    required this.name,
    required this.color,
    required this.description,
  });

  static const List<FortuneColor> colors = [
    FortuneColor(name: '情熱の赤', color: Color(0xFFE63946), description: '情熱と活力のエネルギー'),
    FortuneColor(name: '太陽のオレンジ', color: Color(0xFFFF8C42), description: '陽気で創造的な力'),
    FortuneColor(name: '黄金の輝き', color: Color(0xFFFFD700), description: '豊かさと繁栄の象徴'),
    FortuneColor(name: '新緑の緑', color: Color(0xFF52B788), description: '成長と調和のエネルギー'),
    FortuneColor(name: '癒しの青', color: Color(0xFF457B9D), description: '平和と癒しの波動'),
    FortuneColor(name: '神秘の紫', color: Color(0xFF9D4EDD), description: '直感と精神性の色'),
    FortuneColor(name: 'ピンクの愛', color: Color(0xFFFF69B4), description: '愛と優しさの波長'),
    FortuneColor(name: '純白の光', color: Color(0xFFF8F9FA), description: '純粋さと新しい始まり'),
    FortuneColor(name: '深紅の力', color: Color(0xFF9D0208), description: '強い意志と決断力'),
    FortuneColor(name: 'コーラルの温もり', color: Color(0xFFFF6F61), description: '温かさと親しみやすさ'),
    FortuneColor(name: '若草の希望', color: Color(0xFF90EE90), description: '希望と若さのエネルギー'),
    FortuneColor(name: 'ターコイズの冒険', color: Color(0xFF40E0D0), description: '冒険心と自由の精神'),
    FortuneColor(name: '海の深青', color: Color(0xFF1D3557), description: '深い知恵と落ち着き'),
    FortuneColor(name: 'ラベンダーの優雅', color: Color(0xFFE6E6FA), description: '優雅さと気品'),
    FortuneColor(name: 'マゼンタの魅力', color: Color(0xFFFF00FF), description: '個性と魅力の表現'),
    FortuneColor(name: '琥珀の輝き', color: Color(0xFFFFBF00), description: '温かさと保護のエネルギー'),
    FortuneColor(name: 'ミントの爽やか', color: Color(0xFF98FF98), description: '爽やかさとリフレッシュ'),
    FortuneColor(name: 'スカイブルー', color: Color(0xFF87CEEB), description: '自由と可能性の広がり'),
    FortuneColor(name: 'ローズゴールド', color: Color(0xFFB76E79), description: '優雅さと幸運'),
    FortuneColor(name: 'インディゴの瞑想', color: Color(0xFF4B0082), description: '深い瞑想と洞察'),
    FortuneColor(name: 'ピーチの喜び', color: Color(0xFFFFDAB9), description: '喜びと幸せの感情'),
    FortuneColor(name: 'エメラルドの繁栄', color: Color(0xFF50C878), description: '繁栄と豊かな成長'),
    FortuneColor(name: 'サンセットオレンジ', color: Color(0xFFFF4500), description: '情熱的な変化'),
    FortuneColor(name: 'シルバーの調和', color: Color(0xFFC0C0C0), description: 'バランスと調和'),
  ];
}
