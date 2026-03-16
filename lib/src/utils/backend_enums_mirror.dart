import 'package:flutter/material.dart';
import 'package:swagger/api.dart';

import '../../translations.dart';
import '../../utils.dart';

class ApiHelper {
  static const int MyPaprikaTypeRestaurants = 5;
  static const int MyPaprikaTypeReservation = 1;
  static const int MyPaprikaTypeEvent = 3;
  static const int MyPaprikaTypeOffer = 2;
  static const int MyPaprikaTypeListOffers = 7;
  static const int MyPaprikaTypePublishedPoll = 8;
  static const int MyPaprikaTypeOpenPoll = 9;

  static const int reservationTypePending = 1;
  static const int reservationTypeRejected = 2;
  static const int reservationTypeCanceled = 3;
  static const int reservationTypeApproved = 4;

  static const int pickupTypePending = 1;
  static const int pickupTypeRejected = 2;
  static const int pickupTypeCanceled = 3;
  static const int pickupTypeApproved = 4;

  static const int deliveryTypePending = 1;
  static const int deliveryTypeRejected = 2;
  static const int deliveryTypeCanceled = 3;
  static const int deliveryTypeApproved = 4;

  static String toStringOccasionType(BuildContext context, int occasionType) {
    switch (occasionType) {
      case 1:
        return S.of(context).birthday;
        break;
      case 2:
        return S.of(context).marriage;
        break;
      case 3:
        return S.of(context).graduation;
        break;
      default:
        return S.of(context).otherOccasion;
    }
  }

  static String toStringNoiseLevel(BuildContext context, int noiseLevel) {
    for (EnumValue nameValue in ApiTypesHelper().types.noiseLevels) {
      if (noiseLevel == nameValue.value) return nameValue.name;
    }
    return S.of(context).undefined;
  }

  static String toStringMusicTypes(BuildContext context, int musicType) {
    switch (musicType) {
      case 1:
        return "Jazz";
        break;
      default:
        return "Jazz";
    }
  }

  static String toStringCuisineTypes(BuildContext context, int cuisineType) {
    switch (cuisineType) {
      case 1:
        return "Chinese";
        break;
      case 2:
        return "Italian";
        break;
      default:
        return "Italian";
    }
  }

  static String toStringAmenityTypes(BuildContext context, int amenityTypes) {
    switch (amenityTypes) {
      case 1:
        return "Swings";
        break;
      default:
        return "Swings";
    }
  }

  static String toStringAmbianceTypes(BuildContext context, int ambianceTypes) {
    switch (ambianceTypes) {
      case 1:
        return "Cozy";
        break;
      default:
        return "Cozy";
    }
  }

  static String toStringParkingTypes(BuildContext context, int parkingTypes) {
    switch (parkingTypes) {
      case 1:
        return "Garage";
        break;
      default:
        return "Garage";
    }
  }

  static String toStringRestaurantTypes(
      BuildContext context, int restaurantTypes) {
    switch (restaurantTypes) {
      case 1:
        return "PizzaHouse";
        break;
      case 2:
        return "Restaurant";
        break;
      case 4:
        return "Cafe";
        break;
      case 8:
        return "FastFood";
        break;
      default:
        return "";
    }
  }

  static String toStringDayOfWeek(BuildContext context, int dayOfTheWeek) {
    switch (dayOfTheWeek) {
      case 0:
        return S.of(context).sunday;
        break;
      case 1:
        return S.of(context).monday;
        break;
      case 2:
        return S.of(context).tuesday;
        break;
      case 3:
        return S.of(context).wednesday;
        break;
      case 4:
        return S.of(context).thursday;
        break;
      case 5:
        return S.of(context).friday;
        break;
      case 6:
        return S.of(context).saturday;
        break;
      default:
        return S.of(context).sunday;
    }
  }
}
