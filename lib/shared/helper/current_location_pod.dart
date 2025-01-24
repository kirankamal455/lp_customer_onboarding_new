import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:geolocator/geolocator.dart';

enum LocationError {
  serviceDisabled,
  permissionDenied,
  permissionDeniedForever,
}

final currentLocationPod =
    FutureProvider.autoDispose<Result<Position, Exception>>(
  (ref) async {
    final result = await getCurrentLocation();
    return result;
  },
  name: 'currentLocationPod',
);

Future<Result<Position, Exception>> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;
  Exception? e;
  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    e = const LocationServiceDisabledException();
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      e = const PermissionDeniedException('Location Permission denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    e = const PermissionDeniedException('Location Permission denied forever');
  }
  if (e != null) {
    return Error(e);
  } else {
    return Success(
        await Geolocator.getCurrentPosition(forceAndroidLocationManager: true));
  }
}
