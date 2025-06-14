import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

abstract class Styles {
  static const int _primaryValue = 0xFF7EAFFF3;
  static const MaterialColor primarySwatch = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(_primaryValue),
      100: Color(_primaryValue),
      200: Color(_primaryValue),
      300: Color(_primaryValue),
      400: Color(_primaryValue),
      500: Color(_primaryValue),
      600: Color(_primaryValue),
      700: Color(_primaryValue),
      800: Color(_primaryValue),
      900: Color(_primaryValue),
    },
  );

// #c7de60
// #f1f7d9 second
  static const Color contentsColor = Colors.white;
  static const Color primaryColor = Color.fromARGB(255, 255, 251, 227);
  static const Color primaryColor700 = Color.fromARGB(255, 252, 250, 236);
  static const Color accentColor = Color.fromARGB(255, 135, 144, 220);
  static const Color myButtonColor = Color.fromARGB(255, 253, 234, 234);

  static const Color pageBackground = Color.fromARGB(255, 255, 251, 227);
  static const Color appBarTitleColor = contentsColor;
  static const Color appBarBackgroundColor = Color.fromARGB(255, 178, 220, 135);
  static const Color commonTextColor = Color(0xFF939292);
  static const Color secondaryTextColor = Color.fromARGB(255, 255, 255, 255);

  static const Color cardShadowColor = Color.fromARGB(78, 0, 0, 0);
  static const Color clickSplashColor = Color.fromARGB(8, 0, 0, 0);

  static const Color correctColor = Color(0xFFFF8474);
  static const Color wrongColor = Color(0xFF689ABF);

  static AppBarTheme appBarTheme = const AppBarTheme(
    centerTitle: true,
    foregroundColor: Styles.appBarTitleColor,
    backgroundColor: Color.fromARGB(255, 135, 169, 220),
    iconTheme: IconThemeData(
      color: Styles.appBarTitleColor,
    ),
  );
}
