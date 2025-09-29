import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/ui/pages/map_page/map_page.dart';
import 'package:quiz_rally/config/styles.dart';
import 'package:quiz_rally/page_router.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');

  // Debug: Print BASE_URL to console
  var baseUrl = dotenv.env['BASE_URL'];
  // print('🔍 BASE_URL loaded from .env: $baseUrl');
  
  try {
  if (baseUrl == null || baseUrl.isEmpty) {
    baseUrl = const String.fromEnvironment('BASE_URL');
    print('WARNING: BASE_URL is null or empty!');
    // print("baseUrl from fronEnvironment $baseUrl");

  } else if (!baseUrl.startsWith('http://') &&
             !baseUrl.startsWith('https://')) {
    print('⚠️ WARNING: BASE_URL does not start with http:// or https://');
  }
} catch (e, stackTrace) {
  print('❌ ERROR while checking BASE_URL: $e');
  print(stackTrace);
}


  print("dotenv.env['BASE_URL']${dotenv.env['BASE_URL']}"); //web deploy時は読み込まれない

  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: QuizRally()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Styles.primaryColor),
      ),
      home: MapPage(),
    );
  }
}
