import 'package:emptio/helpers/parsers.dart';

class UserConfigurationsModel {
  bool canNotify;
  String pushToken;

  UserConfigurationsModel({required this.canNotify, required this.pushToken});

  factory UserConfigurationsModel.fromJson(Map<String, dynamic> json) {
    final model = UserConfigurationsModel(
      canNotify: JsonParser.parseToBool(json['canNotify']),
      pushToken: JsonParser.parseToString(json['pushToken']),
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['canNotify'] = canNotify;
    data['pushToken'] = pushToken;
    return data;
  }
}
