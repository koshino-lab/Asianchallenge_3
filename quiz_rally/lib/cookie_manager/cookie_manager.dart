import 'package:web/web.dart';
import 'dart:convert';

class CookieManager {
  static const String _cookieName = 'my_app_data';

  static void saveData(Map<String, dynamic> data) {
    final jsonData = jsonEncode(data);
    window.document.cookie =
        '$_cookieName=${Uri.encodeComponent(jsonData)}; path=/;';
    print('Data saved to cookie: $jsonData');
  }

  static Map<String, dynamic>? loadData() {
    final cookies = window.document.cookie?.split(';');
    if (cookies == null) {
      return null;
    }

    for (final cookie in cookies) {
      final parts = cookie.trim().split('=');
      if (parts.length == 2 && parts[0] == _cookieName) {
        try {
          final decodedData = Uri.decodeComponent(parts[1]);
          print('Data loaded from cookie: $decodedData');
          return jsonDecode(decodedData) as Map<String, dynamic>;
        } catch (e) {
          print('Error decoding cookie data: $e');
          return null;
        }
      }
    }
    return null;
  }
}
