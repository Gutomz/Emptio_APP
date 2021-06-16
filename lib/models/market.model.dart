import 'package:emptio/core/app_api.dart';
import 'package:emptio/models/location.model.dart';

class MarketModel {
  late String sId;
  late String placeId;
  late String name;
  LocationModel? location;
  String? address;
  String? image;
  String? website;
  String? phone;
  late List<String> openingHours;
  late String updatedAt;
  late String createdAt;

  MarketModel({
    required this.sId,
    required this.placeId,
    required this.name,
    this.location,
    this.address,
    this.image,
    this.website,
    this.phone,
    required this.openingHours,
    required this.updatedAt,
    required this.createdAt,
  });

  MarketModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    placeId = json['place_id'];
    name = json['name'];
    location = LocationModel.fromJson(json['location']);
    address = json['address'];
    image = json['image'] != null && json['image'].isNotEmpty
        ? AppApi.getUrl(json['image'])
        : null;
    website = json['website'];
    phone = json['phone'];
    openingHours = json['openingHours'].cast<String>();
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['place_id'] = this.placeId;
    data['name'] = this.name;
    data['location'] = this.location?.toJson();
    data['address'] = this.address;
    data['image'] = this.image;
    data['website'] = this.website;
    data['phone'] = this.phone;
    data['openingHours'] = this.openingHours;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
