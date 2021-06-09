class LocationModel {
  String? sId;
  late double lat;
  late double lng;

  LocationModel({this.sId, required this.lat, required this.lng});

  LocationModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}