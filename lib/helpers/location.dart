import 'package:emptio/models/location.model.dart';
import 'package:location/location.dart';

Future<LocationModel> requestLocation() async {
  final location = Location();

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

  final locationData = await location.getLocation();

  return Future.value(LocationModel.fromLocationData(locationData));
}
