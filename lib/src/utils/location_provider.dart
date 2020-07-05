import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationProvider {
  static Future<LocationData> getLocation() async {

    var location = Location();

// Platform messages may fail, so we use a try/catch PlatformException.
    try {
     return location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        // Uncomment below code to request permission for the second time
//        location.requestPermission().then((granted) async {
//          if (granted) {
//            try {
//              locationData = await location.getLocation();
//            } on PlatformException catch (e) {}
//          }
//        });
      }
    }
    return null;
  }
}
