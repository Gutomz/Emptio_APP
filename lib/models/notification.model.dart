import 'package:emptio/helpers/parsers.dart';

class NotificationModel {
  final String title;
  final String body;
  bool viewed;
  final String createdAt;

  NotificationModel({
    required this.title,
    required this.body,
    required this.viewed,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final model = NotificationModel(
      title: JsonParser.parseToString(json['title']),
      body: JsonParser.parseToString(json['body']),
      viewed: JsonParser.parseToBool(json['viewed']),
      createdAt: JsonParser.parseToString(json['createdAt']),
    );

    return model;
  }

  factory NotificationModel.copy(NotificationModel copyFrom) {
    final model = NotificationModel(
      title: copyFrom.title,
      body: copyFrom.body,
      viewed: copyFrom.viewed,
      createdAt: copyFrom.createdAt,
    );

    return model;
  }

  void markAsViewed() {
    viewed = true;
  }
}
