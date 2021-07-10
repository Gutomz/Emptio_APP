import 'dart:convert';

import 'package:emptio/helpers/parsers.dart';

class ProfileUserModel {
  String sId;
  String name;
  String email;
  String? photo;
  String description;
  String createdAt;
  String updatedAt;

  ProfileUserModel({
    required this.description,
    required this.photo,
    required this.sId,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
    final model = ProfileUserModel(
      sId: JsonParser.parseToString(json['_id']),
      name: JsonParser.parseToString(json['name']),
      email: JsonParser.parseToString(json['email']),
      photo: JsonParser.parseToImageUrl(json['photo']),
      description: JsonParser.parseToString(json['description']),
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
