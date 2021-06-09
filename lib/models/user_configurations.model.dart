class UserConfigurationsModel {
  late bool canNotify;
  late String pushToken;

  UserConfigurationsModel({required this.canNotify, required this.pushToken});

  UserConfigurationsModel.fromJson(Map<String, dynamic> json) {
    canNotify = json['canNotify'];
    pushToken = json['pushToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canNotify'] = this.canNotify;
    data['pushToken'] = this.pushToken;
    return data;
  }
}
