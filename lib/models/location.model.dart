import 'package:emptio/helpers/parsers.dart';
import 'package:location/location.dart';

class LocationModel {
  String? sId;
  double lat;
  double lng;

  LocationModel({this.sId, required this.lat, required this.lng});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    final model = LocationModel(
      sId: JsonParser.parseToString(json['_id']),
      lat: JsonParser.parseToDouble(json['lat']),
      lng: JsonParser.parseToDouble(json['lng']),
    );

    return model;
  }

  factory LocationModel.fromLocationData(LocationData locationData) {
    return LocationModel(
      lat: locationData.latitude ?? 0,
      lng: locationData.longitude ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }

  @override
  String toString() {
    return '$lat,$lng';
  }
}
