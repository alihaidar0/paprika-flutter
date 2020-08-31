import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:paprica/screens.dart';
import 'package:paprica/src/screens/offer_screen.dart';
import 'package:paprica/translations.dart';
import 'package:paprica/utils.dart';

class PapricaApp extends StatefulWidget {
  static String defaultLanguage = "ar";

  // This widget is the root of your application.
  @override
  _PapricaAppState createState() => _PapricaAppState();

  static void setLocale(BuildContext context, String lang) {
    _PapricaAppState state =
        context.ancestorStateOfType(TypeMatcher<_PapricaAppState>());
    state?.setState(() {
      state.locale = Locale(lang);
    });
    SharedPreference.saveLangToSharedPref(lang);
  }
}

class _PapricaAppState extends State<PapricaApp> {
  Locale locale;
  @override
  void initState() {
    super.initState();

    SharedPreference.loadLangFromSharedPref().then((lang) {
      setState(() {
        locale = Locale(lang ?? PapricaApp.defaultLanguage);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: handleRoute,
        routes: <String, WidgetBuilder>{
          '/splash': (BuildContext context) => new SplashScreen(),
          '/home': (BuildContext context) => new HomeScreen(),
          '/signUp': (BuildContext context) => new SignUpScreen(),
          '/logIn': (BuildContext context) => new LogInScreen(),
          '/forgotPassword': (BuildContext context) =>
              new ForgotPasswordScreen(),
        },
        locale: this.locale,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
            cursorColor: Colors.grey,
            textSelectionColor: Colors.grey,
            textSelectionHandleColor: Colors.grey,
            primaryColor: Color(0xFFAA0025),
            accentColor: Color(0xFFAA0025),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
            colorScheme: ColorScheme.light(
              primary: Color(
                  0xFFAA0025), // -------> This will be your FlatButton's text color
              secondary: Color(0xFFAA0025),
            ),
            fontFamily: 'hacen-tunisia',
            textTheme: TextTheme(body1: TextStyle(fontSize: 14))),
        home: Builder(builder: (BuildContext context) {
          return SplashScreen();
        }));
  }

  Route handleRoute(RouteSettings settings) {
    if (settings.name == '/event') {
      return _buildRoute(
          settings, new EventScreen(eventId: settings.arguments));
    }
    if (settings.name == '/offer') {
      return _buildRoute(
          settings, new OfferScreen(offerId: settings.arguments));
    }
    if (settings.name == '/restaurant') {
      return _buildRoute(
          settings, new RestaurantHome(restaurantId: settings.arguments));
    }
    if (settings.name == '/meal') {
      return _buildRoute(
          settings, new RestaurantHome(mealShare: settings.arguments));
    }
    if (settings.name == '/login') {
      return _buildRoute(
          settings, new LogInScreen(asAService: settings.arguments));
    }
    if (settings.name == '/signup') {
      return _buildRoute(
          settings, new SignUpScreen(asAService: settings.arguments));
    }

    return null;
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }
}
