import 'package:emptio/helpers/parsers.dart';

class FriendshipStatusTypes {
  static const String none = 'none';
  static const String accepted = 'accepted';
  static const String declined = 'declined';
  static const String pending = 'pending';

  static List<String> list = [none, accepted, declined, pending];
}

class FriendshipUserModel {
  final String sId;
  final String name;
  final String email;
  final String? photo;

  FriendshipUserModel({
    required this.sId,
    required this.name,
    required this.email,
    this.photo,
  });

  factory FriendshipUserModel.fromJson(Map<String, dynamic> json) {
    final model = FriendshipUserModel(
      sId: JsonParser.parseToString(json['_id']),
      name: JsonParser.parseToString(json['name']),
      email: JsonParser.parseToString(json['email']),
      photo: JsonParser.parseToImageUrl(json['photo']),
    );

    return model;
  }
}

class FriendshipRequestModel {
  final String sId;
  final FriendshipUserModel user;
  final String status;
  final String createdAt;
  final String updatedAt;

  FriendshipRequestModel({
    required this.sId,
    required this.user,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FriendshipRequestModel.fromJson(Map<String, dynamic> json) {
    final model = FriendshipRequestModel(
      sId: JsonParser.parseToString(json['_id']),
      user: JsonParser.parseToFriendshipUser(json['user'])!,
      status: JsonParser.parseToString(json['status']),
      createdAt: JsonParser.parseToString(json['createdAt']),
      updatedAt: JsonParser.parseToString(json['updatedAt']),
    );

    return model;
  }
}
