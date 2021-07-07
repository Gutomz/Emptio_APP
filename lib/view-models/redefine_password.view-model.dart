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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['code'] = code;
    data['password'] = password;
    return data;
  }
}
