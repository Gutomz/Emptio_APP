class RegisterViewModel {
  String? photo;
  String name;
  String email;
  String password;
  String location;

  RegisterViewModel(
      {this.photo,
      required this.name,
      required this.email,
      required this.password,
      required this.location});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['photo'] = photo;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['location'] = location;
    return data;
  }
}
