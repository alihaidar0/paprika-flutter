import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:package_info/package_info.dart';
import 'package:paprica/translations.dart';
import 'package:paprica/utils.dart';
import 'package:swagger/api.dart';

import '../../app.dart';
import '../../widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool locked =
      false; // used to prevent build function from calling _checkInitialConfig more that once
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  String version;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Removes Fullscreen effect
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fullscreen
    SystemChrome.setEnabledSystemUIOverlays([]);
    if (!locked) {
      locked = true;
//      _configureFirebase();

      SharedPreference.loadDefaultLangFromSharedPref().then((lang) {
        if (lang == null) {
          PapricaApiClient().setLang(PapricaApp.defaultLanguage);
          _init(context);
        } else {
          _init(context);
        }
      });
    }
    return Material(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Image(
                  height: 180,
                  image: AssetImage("assets/images/paprika_white.png")),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 18.0,
                    width: 18.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      backgroundColor: Colors.transparent,
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).connecting,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                      FutureBuilder(
                        future: PackageInfo.fromPlatform(),
                        builder: (BuildContext context,
                            AsyncSnapshot<PackageInfo> snapshot) {
                          if (snapshot.hasData)
                            return Text(
                              'V ${snapshot.data.version}',
                              style: TextStyle(
                                  height: 0.8,
                                  color: Colors.white,
                                  fontSize: 12.0),
                            );
                          return Container();
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              )
            ],
          ),
        ],
      ),
    );
  }

  /// [isAuthorized] comes from the server and indicates whether the user has
  /// supplied a valid token in the InitialConfiguration Request
  /// If [tokenSideCheck] is true, a side check on the token would be performed in case the Initial request failed
  void _checkUserStatus(BuildContext context, bool isAuthorized,
      [bool tokenSideCheck = false]) async {
    // In case the Initial request failed
    if (tokenSideCheck) {
      _performTokenSideCheck(context);
      return;
    }
    Navigator.pushNamedAndRemoveUntil(
        context, '/home', ModalRoute.withName('/splash'));
  }

  /// Use this method to check if the shared preference has valid token
  void _performTokenSideCheck(BuildContext context) async {
    String token = await SharedPreference.loadTokenFromSharedPref();
    if (token == null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/logIn', ModalRoute.withName('/splash'));
    } else {
      PapricaApiClient().setToken(token);
      CustomerReservationApi reservationApi =
          CustomerReservationApi(PapricaApiClient());
      reservationApi.apiServicesAppCustomerReservationGetAllGet().then((_) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', ModalRoute.withName('/splash'));
      }).catchError((err) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/logIn', ModalRoute.withName('/splash'));
      });
    }
  }

  void _init(BuildContext context) {
    SharedPreference.loadLangFromSharedPref().then((lang) {
      PapricaApiClient().setLang(lang);

      ApiTypesHelper().init(context).then((initializationData) {
        if (initializationData != null) {
          _checkUserStatus(context, initializationData.isAuthorized);
          ApiTypesHelper()
              .setPhoneNumber(initializationData.customerInfo?.phoneNumber);
          ApiTypesHelper().setIsPhoneNumberConfirmed(
              initializationData.customerInfo?.isPhoneNumberConfirmed);
        }
      }).catchError((err) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return PapricaErrorDialog(
                title: S.of(context).error,
                content: S.of(context).errorUnknownWannaTryAgain,
                extraButton: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                  child: Text(S.of(context).close,
                      style: TextStyle(color: Colors.grey)),
                ),
                actionHandler: () {
                  Navigator.of(context).pop();
                  _init(context);
                },
              );
            });
      });
    });
  }

  _configureFirebase() async {
    print('test 1');
    var android =
        new AndroidInitializationSettings('drawable/ic_stat_ic_notification');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android: android, iOS: ios);
    await flutterLocalNotificationsPlugin.initialize(platform);

    firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> msg) {
          _showNotification(msg);
          return;
        },
        onResume: (Map<String, dynamic> msg) {
          _showNotification(msg);
          return;
        },
        onLaunch: (Map<String, dynamic> msg) {
          _showNotification(msg);
          return;
        },
        onBackgroundMessage: null);
    print('test 2');

    await firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));

    print('test 3');
  }

  _showNotification(Map<String, dynamic> msg) async {
    if (msg != null && msg.containsKey('notification')) {
      var notification = Map<String, dynamic>.from(msg['notification']);
      var title =
          notification.containsKey('title') ? notification['title'] : '';
      var body = notification.containsKey('body') ? notification['body'] : '';

      var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
          'channel id', 'channel name', 'channel description',
          playSound: false,
          importance: Importance.max,
          priority: Priority.high);
      var iOSPlatformChannelSpecifics =
          new IOSNotificationDetails(presentSound: false);
      var platformChannelSpecifics = new NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
          0, title, body, platformChannelSpecifics);
    }
  }
}
