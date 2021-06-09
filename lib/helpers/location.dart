import 'package:location/location.dart';

Future requestLocation() async {
  Location location = Location();

  var serviceEnabled = await location.serviceEnabled();

  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();

    if (!serviceEnabled) {
      return Future.error("location_service");
    }
  }

  var permissionGranted = await location.hasPermission();

  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return Future.error('location_permission');
    }
  }

  return Future.value(true);
}
