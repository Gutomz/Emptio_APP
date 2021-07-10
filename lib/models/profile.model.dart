import 'package:emptio/helpers/parsers.dart';
import 'package:emptio/models/profile_user.model.dart';

class ProfileModel {
  ProfileUserModel user;
  int followersCount;
  int followingCount;
  int postsCount;
  bool isMe;
  bool isFollowing;

  ProfileModel({
    required this.user,
    required this.followersCount,
    required this.followingCount,
    required this.postsCount,
    required this.isMe,
    required this.isFollowing,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final model = ProfileModel(
      user: JsonParser.parseToProfileUser(json['user'])!,
      followersCount: JsonParser.parseToInt(json['followersCount']),
      followingCount: JsonParser.parseToInt(json['followingCount']),
      postsCount: JsonParser.parseToInt(json['postsCount']),
      isMe: JsonParser.parseToBool(json['isMe']),
      isFollowing: JsonParser.parseToBool(json['isFollowing']),
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
