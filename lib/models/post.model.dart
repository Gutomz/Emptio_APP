import 'package:emptio/helpers/parsers.dart';
import 'package:emptio/models/post_data.model.dart';
import 'package:emptio/models/profile_user.model.dart';

class PostModel {
  String sId;
  ProfileUserModel user;
  String description;
  PostDataModel data;
  List<String> likes;
  List<String> dislikes;
  String createdAt;
  String updatedAt;

  PostModel({
    required this.sId,
    required this.user,
    required this.description,
    required this.data,
    required this.likes,
    required this.dislikes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final model = PostModel(
      sId: JsonParser.parseToString(json["_id"]),
      user: JsonParser.parseToProfileUser(json["owner"])!,
      description: JsonParser.parseToString(json["description"]),
      data: JsonParser.parseToPostData(json["data"])!,
      likes: JsonParser.parseToStringList(json["likes"]),
      dislikes: JsonParser.parseToStringList(json["dislikes"]),
      createdAt: JsonParser.parseToString(json["createdAt"]),
      updatedAt: JsonParser.parseToString(json["updatedAt"]),
    );

    return model;
  }
}
