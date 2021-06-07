class RedefinePasswordViewModel {
  String email;
  String code;
  String password;

  RedefinePasswordViewModel({
    required this.email,
    required this.code,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['code'] = this.code;
    data['password'] = this.password;
    return data;
  }
}
