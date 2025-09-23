import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserService {
  // 一時的にハードコード（デバッグ用）
  final _baseUrl = dotenv.env['BASE_URL'] ?? 'http://fest-q-myalb-6ocj4wjlhaso-1476798795.ap-northeast-1.elb.amazonaws.com';
  final String getQuizPath = '/api/quiz';

  Future<String> createUserId() async {
    print('🔍 UserService - BASE_URL: $_baseUrl');

    if (_baseUrl == null || _baseUrl.isEmpty) {
      throw Exception('BASE_URL is not configured');
    }

    final uri = Uri.parse('$_baseUrl/api/createID');
    print('🔍 UserService - Creating user ID at: $uri');

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
