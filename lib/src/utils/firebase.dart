import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:paprika/src/models/notification.dart';
import 'package:swagger/api.dart';

import '../../utils.dart';

class Firebase {
  static final Firebase _firebase = Firebase._internal();

  static var reservationOpenCallback;
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  factory Firebase() {
    return _firebase;
  }

  VoidCallback onMessageCallback;

  Firebase._internal();

  BuildContext buildContext;

  void init(BuildContext context, {VoidCallback onMessageCallback}) {
    this.onMessageCallback = onMessageCallback;
    buildContext = context;
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

    var android =
        new AndroidInitializationSettings('drawable/ic_stat_ic_notification');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android: android, iOS: ios);
    _flutterLocalNotificationsPlugin.initialize(platform,
        onSelectNotification: _onNotificationDialogClick);

    // for iOS only
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
        onLaunch: _firebaseOnLaunch,
        onMessage: _firebaseOnMessage,
        onResume: _firebaseOnResume);

    _firebaseMessaging.getToken().then((token) {
      _registerToken(token);
    });
    _firebaseMessaging.onTokenRefresh.listen(_registerToken);
  }

  Future<dynamic> _firebaseOnLaunch(message) {
//    print("Firebase model msg: " + message.toString());
    processMessage(message);
    return Future.value();
  }

  Future<dynamic> _firebaseOnMessage(message) {
    if (onMessageCallback != null) {
      onMessageCallback();
    }
    return _defaultOnMessageCallback(message);
  }

  Future<dynamic> _firebaseOnResume(message) {
//    print("Firebase model msg: " + message.toString());
    processMessage(message);
    return Future.value();
  }

  void _registerToken(String token) {
    ApiClient client = PapricaApiClient();
    NotificationsApi api = NotificationsApi(client);
    api
        .apiServicesAppNotificationsRegisterFirebaseNotificationsPost(
            token: token)
        .then((_) {})
        .catchError((error) {});
  }

  void processMessage(model) {
//    print("FireBase model msg: " + model.toString());
    var data = json.decode(model["data"]["Model"]);
//    print("data: " + data.toString());
    int type;
    try {
      type = int.parse(model["data"]["NotificationName"]);
    } catch (e) {
      return;
    }
    switch (type) {
      case NotificationType.reservationApprovedInt:
      case NotificationType.reservationRejectedInt:
      case NotificationType.reservationUpdateRejectedInt:
      case NotificationType.reservationUpdateApprovedInt:
        if (reservationOpenCallback is Function &&
            reservationOpenCallback != null) {
          reservationOpenCallback();
        }
        break;
      case NotificationType.newRestaurantAddedInt:
        int restId = data["RestaurantId"];
        if (restId != null && restId > 0) {
          Navigator.pushNamed(buildContext, '/restaurant', arguments: restId);
        }
        break;
      case NotificationType.newEventAddedInt:
        int eventId = data["EventId"];
        if (eventId != null && eventId > 0) {
          Navigator.pushNamed(buildContext, '/event', arguments: eventId);
        }
        break;
      case NotificationType.newOfferAddedInt:
        int offerId = data["OfferId"];
        if (offerId != null && offerId > 0) {
          Navigator.pushNamed(buildContext, '/offer', arguments: offerId);
        }
        break;
    }
  }

  void addReservationCallback(callback) {
    reservationOpenCallback = callback;
  }

  _defaultOnMessageCallback(Map<String, dynamic> msg) async {
    final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
        new FlutterLocalNotificationsPlugin();

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
      await _flutterLocalNotificationsPlugin.show(
          0, title, body, platformChannelSpecifics);
    }
  }

  Future<dynamic> _onNotificationDialogClick(String message) {
    processMessage(message);
    return Future<dynamic>.value();
  }
}
