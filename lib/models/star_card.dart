/// 通変星（四柱推命）
class StarCard {
  final String name;
  final String reading;
  final String description;
  final String meaning;
  final String advice;

  const StarCard({
    required this.name,
    required this.reading,
    required this.description,
    required this.meaning,
    required this.advice,
  });

  static const List<StarCard> cards = [
    StarCard(
      name: '比肩',
      reading: 'ひけん',
      description: '自立心と競争心',
      meaning: '自分の力で道を切り開く強さを持つ星。独立心が旺盛で、競争を好みます。',
      advice: '自分を信じて、堂々と前進しましょう。協調性も忘れずに。',
    ),
    StarCard(
      name: '劫財',
      reading: 'ごうざい',
      description: '行動力とチャレンジ精神',
      meaning: '積極的に挑戦する勇気を持つ星。リスクを恐れず、新しいことに挑戦します。',
      advice: '思い切って行動する時です。ただし、計画性も大切にしましょう。',
    ),
    StarCard(
      name: '食神',
      reading: 'しょくじん',
      description: '楽観性と創造性',
      meaning: '明るく楽観的な性格を表す星。創造的で、人を楽しませる才能があります。',
      advice: '楽しむことを大切に。あなたの笑顔が周りを明るくします。',
    ),
    StarCard(
      name: '傷官',
      reading: 'しょうかん',
      description: '感性と表現力',
      meaning: '鋭い感性と表現力を持つ星。芸術的才能や独創性に恵まれています。',
      advice: '感性を大切に、自由に表現しましょう。批判的になりすぎないように。',
    ),
    StarCard(
      name: '偏財',
      reading: 'へんざい',
      description: '社交性と柔軟性',
      meaning: '人との交流を大切にする星。柔軟で、多くの人と良好な関係を築けます。',
      advice: '人脈を大切に。新しい出会いがチャンスをもたらします。',
    ),
    StarCard(
      name: '正財',
      reading: 'せいざい',
      description: '堅実さと責任感',
      meaning: '真面目で堅実な性格を表す星。責任感が強く、信頼される存在です。',
      advice: '地道な努力が実を結びます。焦らず、着実に進みましょう。',
    ),
    StarCard(
      name: '偏官',
      reading: 'へんかん',
      description: '行動力とリーダーシップ',
      meaning: '強いリーダーシップを持つ星。困難な状況でも果敢に立ち向かいます。',
      advice: '勇気を持って前進を。ただし、周りへの配慮も忘れずに。',
    ),
    StarCard(
      name: '正官',
      reading: 'せいかん',
      description: '誠実さと正義感',
      meaning: '誠実で正義感の強い星。規律を重んじ、責任を全うします。',
      advice: '正しい道を歩み続けましょう。あなたの誠実さが評価されます。',
    ),
    StarCard(
      name: '偏印',
      reading: 'へんいん',
      description: '直感力と独創性',
      meaning: '鋭い直感と独特の発想を持つ星。常識にとらわれない自由な思考ができます。',
      advice: '直感を信じて。あなたの独創的なアイデアが光ります。',
    ),
    StarCard(
      name: '印綬',
      reading: 'いんじゅ',
      description: '知性と学習能力',
      meaning: '知的で学習意欲の高い星。深い思考力と理解力を持っています。',
      advice: '学び続けることで成長します。知識を活かして周りを助けましょう。',
    ),
  ];
}
