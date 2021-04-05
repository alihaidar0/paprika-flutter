import 'package:flutter/material.dart';

final ThemeData paprikaInsideThemeData = new ThemeData(
    cursorColor: Colors.grey,
    textSelectionColor: Colors.grey,
    textSelectionHandleColor: Colors.grey,
    primaryColor: Colors.orange,
    accentColor: Colors.orange,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.grey,
      textTheme: ButtonTextTheme.primary,
      colorScheme: ColorScheme(
        secondary: Color(0xFFCE4C42),
        error: null,
        onPrimary: null,
        background: null,
        brightness: null,
        surface: null,
        onSecondary: null,
        onSurface: null,
        primaryVariant: null,
        onError: null,
        onBackground: null,
        primary: null,
        secondaryVariant: null,
      ),
    ));

class CompanyColors {
  CompanyColors._(); // this basically makes it so you can instantiate this class

  static const _blackPrimaryValue = 0xFFCE4C42;

  static const MaterialColor Red = const MaterialColor(
    _blackPrimaryValue,
    const <int, Color>{
      //TODO: replace with material red
//      50:  const Color(0xFFe0e0e0),
//      100: const Color(0xFFb3b3b3),
//      200: const Color(0xFF808080),
//      300: const Color(0xFF4d4d4d),
//      400: const Color(0xFF262626),
//      500: const Color(_blackPrimaryValue),
//      600: const Color(0xFF000000),
//      700: const Color(0xFF000000),
//      800: const Color(0xFF000000),
//      900: const Color(0xFF000000),
    },
  );
}
