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
      case NotificationType.pickupApproved:
        data = NotificationPickupApproved.fromJson(model['Model']);
        break;
      case NotificationType.pickupRejected:
        data = NotificationPickupRejected.fromJson(model['Model']);
        break;
      case NotificationType.pickupUpdateRejected:
        data = NotificationPickupUpdateReject.fromJson(model['Model']);
        break;
      case NotificationType.pickupUpdateApproved:
        data = NotificationPickupUpdateApproved.fromJson(model['Model']);
        break;
      case NotificationType.pickupIsReady:
        data = NotificationPickupIsReady.fromJson(model['Model']);
        break;
      case NotificationType.pickupResponseMessage:
        data = NotificationPickupResponseMessage.fromJson(model['Model']);
        break;
      case NotificationType.deliveryApproved:
        data = NotificationDeliveryApproved.fromJson(model['Model']);
        break;
      case NotificationType.deliveryRejected:
        data = NotificationDeliveryRejected.fromJson(model['Model']);
        break;
      case NotificationType.deliveryUpdateRejected:
        data = NotificationDeliveryUpdateReject.fromJson(model['Model']);
        break;
      case NotificationType.deliveryUpdateApproved:
        data = NotificationDeliveryUpdateApproved.fromJson(model['Model']);
        break;
      case NotificationType.deliveryResponseMessage:
        data = NotificationDeliveryResponseMessage.fromJson(model['Model']);
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

  static const String pickupApproved = "PickupApproved";
  static const String pickupRejected = "PickupRejected";
  static const String pickupUpdateRejected = "PickupUpdateRejected";
  static const String pickupUpdateApproved = "PickupUpdateApproved";
  static const String pickupIsReady = "PickupIsReady";
  static const String pickupResponseMessage = "PickupResponseMessage";

  static const String deliveryApproved = "DeliveryApproved";
  static const String deliveryRejected = "DeliveryRejected";
  static const String deliveryUpdateRejected = "DeliveryUpdateRejected";
  static const String deliveryUpdateApproved = "DeliveryUpdateApproved";
  static const String deliveryResponseMessage = "DeliveryResponseMessage";

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

///
/// Reservation
///
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

///
/// Pickup
///
abstract class NotificationPickup {
  int pickupId;
  int customerId;
  int restaurantId;
  String image;
  String pickupTime;
  String message;
}

class NotificationPickupUpdateApproved extends NotificationPickup {
  NotificationPickupUpdateApproved.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    pickupId = json['PickupId'];
    customerId = json['CustomerId'];
    restaurantId = json['RestaurantId'];
    image = json['Image'];
    pickupTime = json['PickupTime'];
    message = json['Message'];
  }
}

class NotificationPickupUpdateReject extends NotificationPickup {
  NotificationPickupUpdateReject.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    pickupId = json['PickupId'];
    customerId = json['CustomerId'];
    restaurantId = json['RestaurantId'];
    image = json['Image'];
    pickupTime = json['PickupTime'];
    message = json['Message'];
  }
}

class NotificationPickupApproved extends NotificationPickup {
  NotificationPickupApproved.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    pickupId = json['PickupId'];
    customerId = json['CustomerId'];
    restaurantId = json['RestaurantId'];
    image = json['Image'];
    pickupTime = json['PickupTime'];
    message = json['Message'];
  }
}

class NotificationPickupRejected extends NotificationPickup {
  NotificationPickupRejected.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    pickupId = json['PickupId'];
    customerId = json['CustomerId'];
    restaurantId = json['RestaurantId'];
    image = json['Image'];
    pickupTime = json['PickupTime'];
    message = json['Message'];
  }
}

class NotificationPickupIsReady extends NotificationPickup {
  NotificationPickupIsReady.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    pickupId = json['PickupId'];
    customerId = json['CustomerId'];
    restaurantId = json['RestaurantId'];
    image = json['Image'];
    message = json['Message'];
  }
}

class NotificationPickupResponseMessage extends NotificationPickup {
  NotificationPickupResponseMessage.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    pickupId = json['PickupId'];
    customerId = json['CustomerId'];
    restaurantId = json['RestaurantId'];
    image = json['Image'];
    message = json['Message'];
  }
}

///
/// Delivery
///
abstract class NotificationDelivery {
  int deliveryId;
  int customerId;
  int restaurantId;
  String image;
  String message;
}

class NotificationDeliveryUpdateApproved extends NotificationDelivery {
  NotificationDeliveryUpdateApproved.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    deliveryId = json['DeliveryId'];
    customerId = json['CustomerId'];
    restaurantId = json['RestaurantId'];
    image = json['Image'];
    message = json['Message'];
  }
}

class NotificationDeliveryUpdateReject extends NotificationDelivery {
  NotificationDeliveryUpdateReject.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    deliveryId = json['DeliveryId'];
    customerId = json['CustomerId'];
    restaurantId = json['RestaurantId'];
    image = json['Image'];
    message = json['Message'];
  }
}

class NotificationDeliveryApproved extends NotificationDelivery {
  NotificationDeliveryApproved.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    deliveryId = json['DeliveryId'];
    customerId = json['CustomerId'];
    restaurantId = json['RestaurantId'];
    image = json['Image'];
    message = json['Message'];
  }
}

class NotificationDeliveryRejected extends NotificationDelivery {
  NotificationDeliveryRejected.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    deliveryId = json['DeliveryId'];
    customerId = json['CustomerId'];
    restaurantId = json['RestaurantId'];
    image = json['Image'];
    message = json['Message'];
  }
}

class NotificationDeliveryResponseMessage extends NotificationDelivery {
  NotificationDeliveryResponseMessage.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    deliveryId = json['DeliveryId'];
    customerId = json['CustomerId'];
    restaurantId = json['RestaurantId'];
    image = json['Image'];
    message = json['Message'];
  }
}
