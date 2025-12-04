/// 31種類の前向きなアクション
class ActionItem {
  final String text;
  final String category;

  const ActionItem({
    required this.text,
    required this.category,
  });

  static const List<ActionItem> actions = [
    ActionItem(text: '3分だけ瞑想する', category: 'マインドフルネス'),
    ActionItem(text: '深呼吸を ゆっくり5回 する', category: 'マインドフルネス'),
    ActionItem(text: '今日「よかったこと」を 1つだけ書き出す', category: 'マインドフルネス'),
    ActionItem(text: '自分に 優しい言葉をひとつかける', category: 'マインドフルネス'),
    ActionItem(text: '1分だけ 目を閉じて頭を休める', category: 'マインドフルネス'),
    ActionItem(text: '読書を 1ページ だけ読む', category: '学び'),
    ActionItem(text: '興味ある分野を Googleで30秒 検索', category: '学び'),
    ActionItem(text: '英単語を 1つ 覚える', category: '学び'),
    ActionItem(text: '新しいアプリ・ツールを 1分だけ触ってみる', category: '学び'),
    ActionItem(text: 'TODOを 3つだけ書き出す', category: '整理'),
    ActionItem(text: '机の上を 10cmだけ 片付ける', category: '整理'),
    ActionItem(text: 'パソコンの不要ファイルを 1つ削除', category: '整理'),
    ActionItem(text: 'メールを 1通だけ 返信／整理', category: '整理'),
    ActionItem(text: '未来の自分に 一言メモを書く', category: '整理'),
    ActionItem(text: '財布やバッグから 不要レシートを1枚捨てる', category: '整理'),
    ActionItem(text: 'その場で 軽く肩を10回まわす', category: '健康'),
    ActionItem(text: 'ストレッチを 1ポーズだけ', category: '健康'),
    ActionItem(text: '水を コップ1杯 飲む', category: '健康'),
    ActionItem(text: 'その場で 10秒だけ足踏み', category: '健康'),
    ActionItem(text: '姿勢を 10秒だけまっすぐ整える', category: '健康'),
    ActionItem(text: '好きな音楽を 1曲流す', category: '環境'),
    ActionItem(text: '外の空気を 30秒吸う', category: '環境'),
    ActionItem(text: '観葉植物に 水を少しあげる', category: '環境'),
    ActionItem(text: '窓を開けて 部屋の空気を入れ替える', category: '環境'),
    ActionItem(text: 'ほっとする飲み物を 一杯いれる', category: '環境'),
    ActionItem(text: 'お礼メッセージを 一言だけ 送る', category: 'コミュニケーション'),
    ActionItem(text: '誰かの良いところを 心の中で1つ思い出す', category: 'コミュニケーション'),
    ActionItem(text: '家族・同僚に "おはよう／ありがとう" と声をかける', category: 'コミュニケーション'),
    ActionItem(text: '誰かに 笑顔で挨拶する', category: 'コミュニケーション'),
    ActionItem(text: 'SNSで ポジティブな投稿を1つ読む', category: 'コミュニケーション'),
    ActionItem(text: '今日できそうな 小さなゴールを1つ決める', category: '目標設定'),
  ];
}
