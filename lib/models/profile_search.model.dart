import 'package:emptio/helpers/parsers.dart';
import 'package:emptio/models/profile_user.model.dart';

class ProfileSearchModel {
  ProfileUserModel user;
  bool isFollowing;
  String friendshipStatus;
  String? friendshipId;

  ProfileSearchModel({
    required this.user,
    required this.isFollowing,
    required this.friendshipStatus,
    this.friendshipId,
  });

  factory ProfileSearchModel.fromJson(Map<String, dynamic> json) {
    final model = ProfileSearchModel(
      user: JsonParser.parseToProfileUser(json['user'])!,
      isFollowing: JsonParser.parseToBool(json['isFollowing']),
      friendshipStatus: JsonParser.parseToString(json['friendshipStatus']),
      friendshipId: JsonParser.parseToNullableString(json['friendshipId']),
    );

    return model;
  }

  factory ProfileSearchModel.copy(ProfileSearchModel model) {
    return ProfileSearchModel(
      user: model.user,
      isFollowing: model.isFollowing,
      friendshipStatus: model.friendshipStatus,
      friendshipId: model.friendshipId,
    );
  }
}
