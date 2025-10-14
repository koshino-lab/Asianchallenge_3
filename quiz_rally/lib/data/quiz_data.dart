class QuizData {
  final int id;
  final String question;
  final String hint;
  final int type;
  final String? imagePath;

  const QuizData({
    required this.id,
    required this.question,
    required this.hint,
    required this.type,
    this.imagePath,
  });
}

// 問題データの配列
const List<QuizData> quizDataList = [
  QuizData(
    id: 1,
    question: '助けを求めている露店がある。その露店の名前はなんだ',
    hint: 'モールス信号',
    type: 0, // テキスト回答
  ),
  QuizData(
    id: 2,
    question: '[画像を表示]',
    hint: '最近できた塔の4階',
    type: 0, // テキスト回答
    imagePath: 'assets/images/2_q.png',
  ),
  QuizData(
    id: 3,
    question:
        '学生玄関を入ったら右手の「階段」を上がって二階に行こう。階段を上がると上の方に『図書館◀︎50m』と言う案内が書かれている。案内に従って「左」に進もう。左手の教員室の扉を二つ越えて右にある渡り廊下を進もう。天井の二つの蛍光灯を通り過ぎれば図書館に着く。まっすぐ進んでパンフレットの中に紛れ込んだ宝箱の中に答えは記されている。※宝箱は持って行かないでね',
    hint: '',
    type: 0, // テキスト回答
  ),
  QuizData(
    id: 4,
    question: '[画像を表示]\n賞状は無視して！',
    hint: 'カップや楯に書いてある言葉に注目！',
    type: 0, // テキスト回答
    imagePath: 'assets/images/4_q.png',
  ),
  QuizData(
    id: 5,
    question: '[画像を表示]\n間違いを探せ',
    hint: '間違い探しの答えが最終の答えではない。また、C科塔ではない。',
    type: 0, // テキスト回答
    imagePath: 'assets/images/5_9.png',
  ),
  QuizData(
    id: 6,
    question: '[画像を表示]',
    hint: '写真に写っている文字と問題の文字を除くと…',
    type: 0, // テキスト回答
    imagePath: 'assets/images/6_q.png',
  ),
  QuizData(
    id: 7,
    question: '[画像を表示]',
    hint: '色のパターンを探してみよう！',
    type: 0, // テキスト回答
    imagePath: 'assets/images/7_q.png',
  ),
  QuizData(
    id: 8,
    question: '[画像を表示]\n6号館から1号館の方向に並べろ！',
    hint: '窓から見える',
    type: 0, // テキスト回答
    imagePath: 'assets/images/8_q.png',
  ),
  QuizData(
    id: 9,
    question: '誘導2の問題文',
    hint: '',
    type: 0, // テキスト回答
  ),
];

// IDから効率的にクイズデータを取得する関数
QuizData? getQuizDataById(int id) {
  try {
    return quizDataList.firstWhere((quiz) => quiz.id == id);
  } catch (e) {
    return null;
  }
}
