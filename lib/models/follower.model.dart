import 'package:emptio/helpers/parsers.dart';

class FriendshipStatusTypes {
  static const String none = 'none';
  static const String accepted = 'accepted';
  static const String declined = 'declined';
  static const String pending = 'pending';

  static List<String> list = [none, accepted, declined, pending];
}

class FollowerUserModel {
  final String sId;
  final String name;
  final String email;
  final String? photo;

  FollowerUserModel({
    required this.sId,
    required this.name,
    required this.email,
    this.photo,
  });

  factory FollowerUserModel.fromJson(Map<String, dynamic> json) {
    final model = FollowerUserModel(
      sId: JsonParser.parseToString(json['_id']),
      name: JsonParser.parseToString(json['name']),
      email: JsonParser.parseToString(json['email']),
      photo: JsonParser.parseToImageUrl(json['photo']),
    );

    return model;
  }
}

class FollowerModel {
  final String sId;
  final FollowerUserModel user;
  final bool isFollowing;
  final String followingStatus;

  FollowerModel({
    required this.sId,
    required this.user,
    required this.isFollowing,
    required this.followingStatus,
  });

  factory FollowerModel.fromJson(Map<String, dynamic> json) {
    final model = FollowerModel(
      sId: JsonParser.parseToString(json['_id']),
      user: JsonParser.parseToFollowerUser(json['user'])!,
      isFollowing: JsonParser.parseToBool(json['isFollowing']),
      followingStatus: JsonParser.parseToString(json['followingStatus']),
    );

    return model;
  }
}
