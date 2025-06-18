import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_rally/ui/pages/map_page/map_page.dart';
import 'package:quiz_rally/config/styles.dart';
import 'package:quiz_rally/page_router.dart';

Future<void> main() async {
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
