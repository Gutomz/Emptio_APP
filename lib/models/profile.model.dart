import 'package:emptio/helpers/parsers.dart';
import 'package:emptio/models/profile_user.model.dart';

class ProfileModel {
  ProfileUserModel user;
  int followersCount;
  int followingCount;
  int postsCount;
  bool isMe;
  bool isFollowing;
  String friendshipStatus;
  String? friendshipId;

  ProfileModel({
    required this.user,
    required this.followersCount,
    required this.followingCount,
    required this.postsCount,
    required this.isMe,
    required this.isFollowing,
    required this.friendshipStatus,
    this.friendshipId,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final model = ProfileModel(
      user: JsonParser.parseToProfileUser(json['user'])!,
      followersCount: JsonParser.parseToInt(json['followersCount']),
      followingCount: JsonParser.parseToInt(json['followingCount']),
      postsCount: JsonParser.parseToInt(json['postsCount']),
      isMe: JsonParser.parseToBool(json['isMe']),
      isFollowing: JsonParser.parseToBool(json['isFollowing']),
      friendshipStatus: JsonParser.parseToString(json['friendshipStatus']),
      friendshipId: JsonParser.parseToNullableString(json['friendshipId']),
    );

    return model;
  }

  factory ProfileModel.copy(ProfileModel copyFrom) {
    final model = ProfileModel(
      user: copyFrom.user,
      followersCount: copyFrom.followersCount,
      followingCount: copyFrom.followingCount,
      postsCount: copyFrom.postsCount,
      isMe: copyFrom.isMe,
      isFollowing: copyFrom.isFollowing,
      friendshipStatus: copyFrom.friendshipStatus,
      friendshipId: copyFrom.friendshipId,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user.toJson();
    data['followersCount'] = followersCount;
    data['followingCount'] = followingCount;
    data['postsCount'] = postsCount;
    return data;
  }
}
