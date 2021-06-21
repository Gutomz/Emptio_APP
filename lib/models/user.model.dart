import 'dart:convert';

import 'package:emptio/core/app_api.dart';
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
  String createdAt;
  String updatedAt;

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
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    var model = UserModel(
      sId: json['_id'],
      name: json['name'],
      email: json['email'],
      photo: json['photo'] != null && json['photo'] != ""
          ? AppApi.getUrl(json['photo'])
          : null,
      description: json['description'],
      location: LocationModel.fromJson(json['location']),
      configurations: UserConfigurationsModel.fromJson(json['configurations']),
      notificationCount: json['notificationCount'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['photo'] = this.photo;
    data['description'] = this.description;
    data['location'] = this.location.toJson();
    data['configurations'] = this.configurations.toJson();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['notificationCount'] = this.notificationCount;
    return data;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
