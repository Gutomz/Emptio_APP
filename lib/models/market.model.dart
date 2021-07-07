import 'package:emptio/helpers/parsers.dart';
import 'package:emptio/models/location.model.dart';

class MarketModel {
  String sId;
  String placeId;
  String name;
  LocationModel? location;
  String? address;
  String? image;
  String? website;
  String? phone;
  List<String> openingHours;
  String updatedAt;
  String createdAt;

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

  factory MarketModel.fromJson(Map<String, dynamic> json) {
    final model = MarketModel(
      sId: JsonParser.parseToString(json['_id']),
      placeId: JsonParser.parseToString(json['place_id']),
      name: JsonParser.parseToString(json['name']),
      location: JsonParser.parseToLocation(json['location']),
      address: JsonParser.parseToNullableString(json['address']),
      image: JsonParser.parseToImageUrl(json['image']),
      website: JsonParser.parseToNullableString(json['website']),
      phone: JsonParser.parseToNullableString(json['phone']),
      openingHours: JsonParser.parseToStringList(json['openingHours']),
      updatedAt: JsonParser.parseToString(json['updatedAt']),
      createdAt: JsonParser.parseToString(json['createdAt']),
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['place_id'] = placeId;
    data['name'] = name;
    data['location'] = location?.toJson();
    data['address'] = address;
    data['image'] = image;
    data['website'] = website;
    data['phone'] = phone;
    data['openingHours'] = openingHours;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
}
