import 'dart:convert';

import 'package:emptio/helpers/parsers.dart';
import 'package:emptio/models/location.model.dart';
import 'package:emptio/models/user_configurations.model.dart';

class UserModel {
  String sId;
  String name;
  String email;
  String? photo;
  String description;
  LocationModel location;
  UserConfigurationsModel configurations;
  int notificationCount;
  int requestsCount;
  String createdAt;
  String updatedAt;

  int get alertsCount => notificationCount + requestsCount;

  UserModel({
    required this.description,
    required this.photo,
    required this.sId,
    required this.name,
    required this.email,
    required this.location,
    required this.configurations,
    required this.createdAt,
    required this.updatedAt,
    required this.notificationCount,
    required this.requestsCount,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final model = UserModel(
      sId: JsonParser.parseToString(json['_id']),
      name: JsonParser.parseToString(json['name']),
      email: JsonParser.parseToString(json['email']),
      photo: JsonParser.parseToImageUrl(json['photo']),
      description: JsonParser.parseToString(json['description']),
      location: JsonParser.parseToLocation(json['location'])!,
      configurations:
          JsonParser.parseToUserConfiguration(json['configurations'])!,
      notificationCount: JsonParser.parseToInt(json['notificationCount']),
      requestsCount: JsonParser.parseToInt(json['requestsCount']),
      createdAt: JsonParser.parseToString(json['createdAt']),
      updatedAt: JsonParser.parseToString(json['updatedAt']),
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['photo'] = photo;
    data['description'] = description;
    data['location'] = location.toJson();
    data['configurations'] = configurations.toJson();
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['notificationCount'] = notificationCount;
    data['requestsCount'] = notificationCount;
    return data;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
