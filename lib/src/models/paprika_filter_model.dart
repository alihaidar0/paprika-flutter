import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';
import 'package:paprika/generated/i18n.dart';
import 'package:paprika/src/utils/api_types_helper.dart';
import 'package:swagger/api.dart';

class PaprikaFilterModel {
  bool isFeatured;
  LocationData locationData;
  String hasOutdoorValue;
  String smokeValue;
  String alcoholValue;
  String twentyFourValue;

  List<String> placesSelections = [];
  List<String> cuisinesSelections = [];
  List<String> amenitiesSelections = [];
  List<String> ambianceSelections = [];
  List<String> musicTypesSelections = [];
  List<String> parkingTypesSelections = [];

  PaprikaFilterModel(
      {this.isFeatured,
      this.locationData,
      this.hasOutdoorValue,
      this.smokeValue,
      this.alcoholValue,
      this.twentyFourValue,
      this.placesSelections,
      this.cuisinesSelections,
      this.amenitiesSelections,
      this.ambianceSelections,
      this.musicTypesSelections,
      this.parkingTypesSelections});

  PaprikaFilterModel.apiToFilterModelAdapter(
      ApiFilterModel filter, BuildContext context) {
    if (filter == null)
      PaprikaFilterModel();
    else {
      isFeatured = filter.isFeatured;
      hasOutdoorValue =
          (filter.hasOutdoor ?? false) ? S.of(context).outdoor : null;
      smokeValue =
          (filter.isSmokeFree ?? false) ? S.of(context).smokeFree : null;
      alcoholValue =
          (filter.isAlcoholFree ?? false) ? S.of(context).alcoholFree : null;
      twentyFourValue =
          (filter.is24Hour ?? false) ? S.of(context).twentyFourSeven : null;
      placesSelections = ApiTypesHelper()
          .getTypeNamesListByValue(filter.restaurantTypes ?? 0, Type.places);
      cuisinesSelections = ApiTypesHelper()
          .getTypeNamesListByValue(filter.cuisineTypes ?? 0, Type.cuisines);
      amenitiesSelections = ApiTypesHelper()
          .getTypeNamesListByValue(filter.amenityTypes ?? 0, Type.amenities);
      ambianceSelections = ApiTypesHelper()
          .getTypeNamesListByValue(filter.ambianceType ?? 0, Type.ambiance);
      musicTypesSelections = ApiTypesHelper()
          .getTypeNamesListByValue(filter.musicType ?? 0, Type.music);
      parkingTypesSelections = ApiTypesHelper()
          .getTypeNamesListByValue(filter.parkingType ?? 0, Type.parking);
    }
  }

  PaprikaFilterModel.deepCopy(PaprikaFilterModel filter) {
    if (filter == null)
      PaprikaFilterModel();
    else {
      isFeatured = filter.isFeatured;
      locationData = filter.locationData;
      hasOutdoorValue = filter.hasOutdoorValue;
      smokeValue = filter.smokeValue;
      alcoholValue = filter.alcoholValue;
      twentyFourValue = filter.twentyFourValue;
      placesSelections = []..addAll(filter.placesSelections ?? []);
      cuisinesSelections = []..addAll(filter.cuisinesSelections ?? []);
      amenitiesSelections = []..addAll(filter.amenitiesSelections ?? []);
      ambianceSelections = []..addAll(filter.ambianceSelections ?? []);
      musicTypesSelections = []..addAll(filter.musicTypesSelections ?? []);
      parkingTypesSelections = []..addAll(filter.parkingTypesSelections ?? []);
    }
  }

  get longitude => null;

  get latitude => null;

  @override
  String toString() {
    String stringValue =
        "{\n isFeatured: $isFeatured, locationData: $locationData, Outdoor: $outdoor; Smoke: $smokeFree; Alcohol: $alcoholFree; 24/7: $twentyFourHour;";
    stringValue += "\n  Places: ";
    if (placesSelections != null && placesSelections.length > 0) {
      stringValue += placesSelections.reduce((result, place) {
        return result + " , " + place;
      });
    } else {
      stringValue += "0";
    }
    stringValue += " \n Cuisines: ";
    if (cuisinesSelections != null && cuisinesSelections.length > 0) {
      stringValue += cuisinesSelections.reduce((result, place) {
        return result + " , " + place;
      });
    } else {
      stringValue += "0";
    }
    stringValue += " \n Ameneties: ";
    if (amenitiesSelections != null && amenitiesSelections.length > 0) {
      stringValue += amenitiesSelections.reduce((result, place) {
        return result + " , " + place;
      });
    } else {
      stringValue += "0";
    }
    stringValue += " \n Ambiance: ";
    if (ambianceSelections != null && ambianceSelections.length > 0) {
      stringValue += ambianceSelections.reduce((result, place) {
        return result + " , " + place;
      });
    } else {
      stringValue += "0";
    }
    stringValue += "\n  Music: ";
    if (musicTypesSelections != null && musicTypesSelections.length > 0) {
      stringValue += musicTypesSelections.reduce((result, place) {
        return result + " , " + place;
      });
    } else {
      stringValue += "0";
    }
    stringValue += " \n Parking: ";
    if (parkingTypesSelections != null && parkingTypesSelections.length > 0) {
      stringValue += parkingTypesSelections.reduce((result, place) {
        return result + " , " + place;
      });
    } else {
      stringValue += "0";
    }
    return stringValue + "\n}";
  }

  @override
  bool operator ==(other) {
    Function eq = const ListEquality().equals;
    return other is PaprikaFilterModel &&
        isFeatured == other.isFeatured &&
        locationData?.latitude == other.locationData?.latitude &&
        locationData?.latitude == other.locationData?.longitude &&
        hasOutdoorValue == other.hasOutdoorValue &&
        smokeValue == other.smokeValue &&
        alcoholValue == other.alcoholValue &&
        twentyFourValue == other.twentyFourValue &&
        eq(placesSelections, other.placesSelections) &&
        eq(cuisinesSelections, other.cuisinesSelections) &&
        eq(amenitiesSelections, other.amenitiesSelections) &&
        eq(ambianceSelections, other.ambianceSelections) &&
        eq(musicTypesSelections, other.musicTypesSelections) &&
        eq(parkingTypesSelections, other.parkingTypesSelections);
  }

  @override
  int get hashCode {
    return hasOutdoorValue.hashCode +
        isFeatured.hashCode +
        locationData.hashCode +
        smokeValue.hashCode +
        alcoholValue.hashCode +
        twentyFourValue.hashCode +
        placesSelections.hashCode +
        cuisinesSelections.hashCode +
        amenitiesSelections.hashCode +
        ambianceSelections.hashCode +
        musicTypesSelections.hashCode +
        parkingTypesSelections.hashCode +
        Random().nextInt(1000);
  }

  bool get isFilterNotEmpty {
    return !isFilterEmpty;
  }

  int get length {
    int length = placesSelections.length +
        cuisinesSelections.length +
        ambianceSelections.length +
        amenitiesSelections.length +
        musicTypesSelections.length +
        parkingTypesSelections.length;
    if (isFeatured != null) length++;
    if (locationData != null) length++;
    if (smokeValue != null && smokeValue.isNotEmpty) length++;
    if (alcoholValue != null && alcoholValue.isNotEmpty) length++;
    if (hasOutdoorValue != null && hasOutdoorValue.isNotEmpty) length++;
    if (twentyFourValue != null && twentyFourValue.isNotEmpty) length++;
    return length;
  }

  bool get isFilterEmpty {
    return (isFeatured == null) &&
        (locationData == null) &&
        (smokeValue == null || smokeValue.isEmpty) &&
        (alcoholValue == null || alcoholValue.isEmpty) &&
        (twentyFourValue == null || twentyFourValue.isEmpty) &&
        (hasOutdoorValue == null || hasOutdoorValue.isEmpty) &&
        (placesSelections == null || placesSelections.length == 0) &&
        (cuisinesSelections == null || cuisinesSelections.length == 0) &&
        (amenitiesSelections == null || amenitiesSelections.length == 0) &&
        (ambianceSelections == null || ambianceSelections.length == 0) &&
        (musicTypesSelections == null || musicTypesSelections.length == 0) &&
        (parkingTypesSelections == null || parkingTypesSelections.length == 0);
  }

  bool get smokeFree {
    return smokeValue == null ? null : smokeValue.isNotEmpty;
  }

  bool get twentyFourHour {
    return twentyFourValue == null ? null : twentyFourValue.isNotEmpty;
  }

  bool get alcoholFree {
    return alcoholValue == null ? null : alcoholValue.isNotEmpty;
  }

  bool get outdoor {
    return hasOutdoorValue == null ? null : hasOutdoorValue.isNotEmpty;
  }
}
