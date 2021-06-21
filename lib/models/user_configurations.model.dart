class UserConfigurationsModel {
  bool canNotify;
  String pushToken;

  UserConfigurationsModel({required this.canNotify, required this.pushToken});

  factory UserConfigurationsModel.fromJson(Map<String, dynamic> json) {
    var model = UserConfigurationsModel(
      canNotify: json['canNotify'],
      pushToken: json['pushToken'],
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canNotify'] = this.canNotify;
    data['pushToken'] = this.pushToken;
    return data;
  }
}
