import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:paprika/screens.dart';
import 'package:paprika/src/screens/offer_screen.dart';
import 'package:paprika/translations.dart';
import 'package:paprika/utils.dart';

class PaprikaApp extends StatefulWidget {
  static String defaultLanguage = "ar";

  @override
  _PaprikaAppState createState() => _PaprikaAppState();

  static void setLocale(BuildContext context, String lang) {
    _PaprikaAppState state =
        context.findAncestorStateOfType<_PaprikaAppState>();
    // ignore: invalid_use_of_protected_member
    state?.setState(() {
      state.locale = Locale(lang);
    });
    SharedPreference.saveLangToSharedPref(lang);
  }
}

class _PaprikaAppState extends State<PaprikaApp> {
  Locale locale;

  @override
  void initState() {
    super.initState();

    SharedPreference.loadLangFromSharedPref().then((lang) {
      setState(() {
        locale = Locale(lang ?? PaprikaApp.defaultLanguage);
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
        home: Builder(builder: (BuildContext context) {
          return SplashScreen();
        }));
  }

  Route handleRoute(RouteSettings settings) {
    if (settings.name == '/home') {
      return _buildRoute(
          settings,
          new HomeScreen(
              action: settings.arguments, initialIndex: settings.arguments));
    }
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
    if (settings.name == '/pickup') {
      return _buildRoute(
          settings, new PickupScreen(restaurantId: settings.arguments));
    }
    if (settings.name == '/delivery') {
      return _buildRoute(
          settings, new DeliveryScreen(restaurantId: settings.arguments));
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
