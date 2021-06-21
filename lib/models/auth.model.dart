class AuthModel {
  String token;
  String refreshToken;

  AuthModel({required this.token, required this.refreshToken});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    var model = AuthModel(
      token: json['token'],
      refreshToken: json['refreshToken'],
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}
