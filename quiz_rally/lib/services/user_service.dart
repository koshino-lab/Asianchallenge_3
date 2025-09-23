import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserService {
  final _baseUrl = "https://asianchallenge-3.onrender.com";
  // final _baseUrl = dotenv.env['BASE_URL'];
  final String getQuizPath = '/api/quiz';

  Future<String> createUserId() async {
    final uri = Uri.parse('$_baseUrl/api/createID');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['userID'];
    } else {
      throw Exception(
        'Failed to create userID with status code: ${response.statusCode}',
      );
    }
  }

  Future<List<int>> getProgress(String userId) async {
    final uri = Uri.parse(
      '$_baseUrl/api/progress',
    ).replace(queryParameters: {'userID': userId});

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return List<int>.from(body['progress']);
    } else if (response.statusCode == 400) {
      final errorBody = jsonDecode(response.body);
      throw Exception('Failed to get progress: ${errorBody['error']}');
    } else {
      throw Exception(
        'Failed to get progress with status code: ${response.statusCode}',
      );
    }
  }
}
