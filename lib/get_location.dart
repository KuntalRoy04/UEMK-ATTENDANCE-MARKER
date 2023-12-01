import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

Future<Position?> getCurrentLocation() async {
  var status = await Permission.location.status;
  if (status.isGranted) {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print(position.latitude);
      print(position.longitude);
      return position;
    } catch (e) {
      if (kDebugMode) {
        print("Error getting location: $e");
      }
      return null;
    }
  } else {
    await Permission.location.request();
    return null;
  }
}

