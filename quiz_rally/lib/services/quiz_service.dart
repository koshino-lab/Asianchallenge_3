import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quiz_rally/models/quiz.dart';

class QuizService {
  // 一時的にハードコード（デバッグ用）
  final _baseUrl = 'http://127.0.0.1:3000';

  Future<Quiz> getQuiz(String quizId) async {
    print('🔍 QuizService - BASE_URL: $_baseUrl');
    print('🔍 QuizService - Requesting quiz ID: $quizId');

    if (_baseUrl == null || _baseUrl.isEmpty) {
      throw Exception('BASE_URL is not configured');
    }

    final uri = Uri.parse(
      '$_baseUrl/api/quiz',
    ).replace(queryParameters: {'quizID': quizId});

    print('🔍 QuizService - Full URL: $uri');

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

  Future<String> checkAnswer(
    int quizId,
    String userId, {
    String? answer,
    http.MultipartFile? file,
  }) async {
    final uri = Uri.parse('$_baseUrl/api/quiz');
    var request = http.MultipartRequest('POST', uri);
    request.fields['quizID'] = quizId.toString();
    request.fields['userID'] = userId;

    if (answer != null) {
      request.fields['answer'] = answer;
    }

    if (file != null) {
      request.files.add(file);
    }

    print('Request URL: ${request.url}');
    print('Request Headers: ${request.headers}');
    print('Request Fields: ${request.fields}');
    print('Request Files: ${request.files}');

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      print('Response body: $responseBody');
      final body = jsonDecode(responseBody);
      return body['status'];
    } else if (response.statusCode == 400) {
      final responseBody = await response.stream.bytesToString();
      final errorBody = jsonDecode(responseBody);
      throw Exception('❌ Failed to check quiz: ${errorBody['error']}');
    } else {
      throw Exception(
        '❌ Failed to check quiz with status code: ${response.statusCode}',
      );
    }
  }

  Future<dynamic> getCorrectAnswerRates({int? quizId}) async {
    final uri = Uri.parse('$_baseUrl/api/correctAnswerRate').replace(
      queryParameters: quizId != null ? {'quizID': quizId.toString()} : {},
    );

    final response = await http.get(uri);
    print('✅ header: ${response.headers}, body: ${response.body}');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (quizId != null) {
        return (body['correctAnswerRate'] as num).toDouble();
      } else {
        return (body['correctAnswerRate'] as List)
            .map((e) => (e as num).toDouble())
            .toList();
      }
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
