import 'dart:convert';

import 'package:emptio/core/app_api.dart';
import 'package:emptio/models/location.model.dart';
import 'package:emptio/models/user_configurations.model.dart';

class UserModel {
  late String sId;
  late String name;
  late String email;
  String? photo;
  late String description;
  late LocationModel location;
  late UserConfigurationsModel configurations;
  late int notificationCount;
  late String createdAt;
  late String updatedAt;

  UserModel(
      {required this.description,
      required this.photo,
      required this.sId,
      required this.name,
      required this.email,
      required this.location,
      required this.createdAt,
      required this.updatedAt,
      required this.notificationCount});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    photo = json['photo'] != null && json['photo'] != ""
        ? AppApi.getUrl(json['photo'])
        : null;
    description = json['description'];
    location = LocationModel.fromJson(json['location']);
    configurations = UserConfigurationsModel.fromJson(json['configurations']);
    notificationCount = json['notificationCount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
