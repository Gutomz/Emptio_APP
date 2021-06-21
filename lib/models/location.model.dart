class LocationModel {
  String? sId;
  double lat;
  double lng;

  LocationModel({this.sId, required this.lat, required this.lng});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    var model = LocationModel(
      sId: json['_id'],
      lat: json['lat'],
      lng: json['lng'],
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
