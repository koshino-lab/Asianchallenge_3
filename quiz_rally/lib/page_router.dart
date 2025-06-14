import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quiz_rally/config/error_page/error.dart';
import 'package:quiz_rally/config/problem_page/problem_page.dart';
import 'package:quiz_rally/config/styles.dart';
import 'package:quiz_rally/config/success_page/success_page.dart';
import 'package:quiz_rally/config/top_page/top_page.dart';
import 'package:quiz_rally/help_page/help_page.dart';

class QuizRally extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      builder: EasyLoading.init(),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => TopPage(),
        '/problem': (BuildContext context) => ProblemPage(),
        '/success': (BuildContext context) => SuccessPage(),
        '/error': (BuildContext context) => ErrorPage(),
        '/help': (BuildContext context) => HelpPage(),
      },
      title: '高専の森',
      theme: ThemeData(
        primarySwatch: Styles.primarySwatch,
        primaryColor: Styles.primaryColor,
        brightness: Brightness.light,
        appBarTheme: Styles.appBarTheme,
        scaffoldBackgroundColor: Styles.pageBackground,
        // textTheme: GoogleFonts.mPlusRounded1cTextTheme(
        //   Styles.textTheme,
        // ),
      ),
    );
  }
}
