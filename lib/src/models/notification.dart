import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:swagger/api.dart';

class ApiNotification {
  String title;
  String body;

  ApiNotification.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    title = json['title'];
    body = json['body'];
  }
}

class NotificationModel {
  Color color;
  String imageUrl;
  String title;
  String body;
  String description;

//  DateTime descriptionDate;
  DateTime date;

//  String time;

  int state;
  String notificationName;
  dynamic data;

//  int type;

  ApiNotification notification;

  NotificationModel(
      {this.color,
      this.imageUrl,
      this.title,
      this.body,
      this.description,
      this.date});

  NotificationModel.fromNotificationDto(NotificationInfoDto infoDto) {
    date = infoDto.creationTime;
    notificationName = infoDto.notificationName;
    state = infoDto.state;
    var model;
    try {
      model = json.decode(infoDto.data);
    } catch (err) {
      return;
    }
    if (model == null) return;
    notification = ApiNotification.fromJson(model["Model"]);
    title = model['Title'];
    body = model['Body'];
//    type = model['Model']["NotificationType"];
    switch (notificationName) {
      case NotificationType.reservationApproved:
        data = NotificationReservationApproved.fromJson(model['Model']);
        break;
      case NotificationType.reservationRejected:
        data = NotificationReservationRejected.fromJson(model['Model']);
        break;
      case NotificationType.reservationUpdateRejected:
        data = NotificationReservationUpdateReject.fromJson(model['Model']);
        break;
      case NotificationType.reservationUpdateApproved:
        data = NotificationReservationUpdateApproved.fromJson(model['Model']);
        break;
      case NotificationType.newRestaurantAdded:
        data = NotificationRestaurantAdded.fromJson(model['Model']);
        break;
      case NotificationType.newEventAdded:
        data = NotificationEventAdded.fromJson(model['Model']);
        break;
      case NotificationType.newOfferAdded:
        data = NotificationOfferAdded.fromJson(model['Model']);
        break;
    }
  }
}

class NotificationType {
  //  Customer Scope
  static const String reservationApproved = "ReservationApproved";
  static const String reservationRejected = "ReservationRejected";
  static const String reservationUpdateRejected = "ReservationUpdateRejected";
  static const String reservationUpdateApproved = "ReservationUpdateApproved";
  static const String newRestaurantAdded = "NewRestaurantAdded";
  static const String newEventAdded = "NewEventAdded";
  static const String newOfferAdded = "NewOfferAdded";

  static const int reservationApprovedInt = 1;
  static const int reservationRejectedInt = 2;
  static const int reservationUpdateRejectedInt = 6;
  static const int reservationUpdateApprovedInt = 7;
  static const int newRestaurantAddedInt = 9;
  static const int newEventAddedInt = 10;
  static const int newOfferAddedInt = 11;
}

class NotificationEventAdded {
  int eventId;
  int restaurantId;
  String name;
  String image;
  String message;

  NotificationEventAdded.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    eventId = json['EventId'];
    restaurantId = json['RestaurantId'];
    name = json['Name'];
    image = json['Image'];
    message = json['Message'];
  }
}

class NotificationOfferAdded {
  int offerId;
  int restaurantId;
  String image;
  String message;

  NotificationOfferAdded.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    offerId = json['OfferId'];
    restaurantId = json['RestaurantId'];
    image = json['Image'];
    message = json['Message'];
  }
}

class NotificationRestaurantAdded {
  int restaurantId;
  String name;
  String image;
  String message;

  NotificationRestaurantAdded.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    restaurantId = json['RestaurantId'];
    name = json['Name'];
    image = json['Image'];
    message = json['Message'];
  }
}

abstract class NotificationReservation {
  int reservationId;
  int customerId;
  int restaurantId;
  String image;
  String reservationTime;
  String message;
}

class NotificationReservationUpdateApproved extends NotificationReservation {
  NotificationReservationUpdateApproved.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    reservationId = json['ReservationId'];
    customerId = json['CustomerId'];
    restaurantId = json['RestaurantId'];
    image = json['Image'];
    reservationTime = json['ReservationTime'];
    message = json['Message'];
  }
}

class NotificationReservationUpdateReject extends NotificationReservation {
  NotificationReservationUpdateReject.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    reservationId = json['ReservationId'];
    customerId = json['CustomerId'];
    restaurantId = json['RestaurantId'];
    image = json['Image'];
    reservationTime = json['ReservationTime'];
    message = json['Message'];
  }
}

class NotificationReservationApproved extends NotificationReservation {
  NotificationReservationApproved.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    reservationId = json['ReservationId'];
    customerId = json['CustomerId'];
    restaurantId = json['RestaurantId'];
    image = json['Image'];
    reservationTime = json['ReservationTime'];
    message = json['Message'];
  }
}

class NotificationReservationRejected extends NotificationReservation {
  NotificationReservationRejected.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    reservationId = json['ReservationId'];
    customerId = json['CustomerId'];
    restaurantId = json['RestaurantId'];
    image = json['Image'];
    reservationTime = json['ReservationTime'];
    message = json['Message'];
  }
}
