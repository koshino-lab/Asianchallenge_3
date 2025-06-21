import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_rally/models/quiz.dart';

class QuizService {
  final String _baseUrl = 'http://127.0.0.1:5000';

  Future<Quiz> getQuiz(String quizId) async {
    final uri = Uri.parse(
      '$_baseUrl/api/quiz',
    ).replace(queryParameters: {'quizID': quizId});

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // レスポンスが成功した場合、JSONをパースしてQuizオブジェクトを返す
      return Quiz.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      // 400エラーの場合、エラーメッセージをパースして例外をスローする
      final errorBody = jsonDecode(response.body);
      throw Exception('Failed to load quiz: ${errorBody['error']}');
    } else {
      // その他のエラーの場合、ステータスコードを含めて例外をスローする
      throw Exception(
        'Failed to load quiz with status code: ${response.statusCode}',
      );
    }
  }
}
