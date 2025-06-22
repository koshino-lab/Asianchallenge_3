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

  Future<String> checkAnswer(int quizId, String answer, String userId) async {
    final uri = Uri.parse('$_baseUrl/api/quiz');

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'quizID': quizId,
        'answer': answer,
        'userID': userId,
      }),
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['status'];
    } else if (response.statusCode == 400) {
      final errorBody = jsonDecode(response.body);
      throw Exception('❌ Failed to check quiz: ${errorBody['error']}');
    } else {
      throw Exception(
        '❌ Failed to check quiz with status code: ${response.statusCode}',
      );
    }
  }

  Future<double> getCorrectAnswerRate(int quizId) async {
    final uri = Uri.parse(
      '$_baseUrl/api/correctAnswerRate',
    ).replace(queryParameters: {'quizID': quizId.toString()});

    final response = await http.get(uri);
    print('✅ header: ${response.headers}, body: ${response.body}');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return (body['correctAnswerRate'] as num).toDouble();
    } else if (response.statusCode == 400) {
      final errorBody = jsonDecode(response.body);
      throw Exception(
        'Failed to get correct answer rate: ${errorBody['error']}',
      );
    } else {
      throw Exception(
        'Failed to get correct answer rate with status code: ${response.statusCode}',
      );
    }
  }
}
