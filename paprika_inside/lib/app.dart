import 'package:flutter/material.dart';
import 'package:paprika_inside/screens.dart';

class PaprikaInsideApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          cursorColor: Colors.grey,
          textSelectionColor: Colors.grey,
          textSelectionHandleColor: Colors.grey,
          primaryColor: Color(0xFFCE4C42),
          accentColor: Color(0xFFCE4C42),
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
          colorScheme: ColorScheme.light(
            primary: Color(0xFFCE4C42),
            // -------> This will be your FlatButton's text color
            secondary: Color(0xFFCE4C42),
          ),
          fontFamily: 'hacen-tunisia',
          textTheme: TextTheme(bodyText1: TextStyle(fontSize: 14))),
      home: InsideHomeScreen(),
    );
  }
}