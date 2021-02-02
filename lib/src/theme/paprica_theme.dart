import 'package:flutter/material.dart';

final ThemeData papricaThemeData = new ThemeData(
    cursorColor: Colors.grey,
    textSelectionColor: Colors.grey,
    textSelectionHandleColor: Colors.grey,
    primaryColor: Colors.orange, // Color(0xFFB02524),
    accentColor: Colors.orange, //Color(0xFFB02524),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.grey,
      textTheme: ButtonTextTheme.primary,
      colorScheme: ColorScheme(
        secondary: Color(0xFFB02524),
      ),
    ));

class CompanyColors {
  CompanyColors._(); // this basically makes it so you can instantiate this class

  static const _blackPrimaryValue = 0xFFB02524;

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
