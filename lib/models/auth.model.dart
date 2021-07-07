import 'package:emptio/helpers/parsers.dart';

class AuthModel {
  String token;
  String refreshToken;

  AuthModel({required this.token, required this.refreshToken});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final model = AuthModel(
      token: JsonParser.parseToString(json['token']),
      refreshToken: JsonParser.parseToString(json['refreshToken']),
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    return data;
  }
}
