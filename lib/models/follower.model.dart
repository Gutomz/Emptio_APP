import 'package:emptio/helpers/parsers.dart';
import 'package:emptio/models/friendship_request.model.dart';

class FollowerModel {
  final String sId;
  final FriendshipUserModel user;
  final bool isFollowing;
  final String followingStatus;
  final String? followingRequestId;

  FollowerModel({
    required this.sId,
    required this.user,
    required this.isFollowing,
    required this.followingStatus,
    this.followingRequestId,
  });

  factory FollowerModel.fromJson(Map<String, dynamic> json) {
    final model = FollowerModel(
      sId: JsonParser.parseToString(json['_id']),
      user: JsonParser.parseToFriendshipUser(json['user'])!,
      isFollowing: JsonParser.parseToBool(json['isFollowing']),
      followingStatus: JsonParser.parseToString(json['followingStatus']),
      followingRequestId:
          JsonParser.parseToNullableString(json['followingRequestId']),
    );

    return model;
  }
}
