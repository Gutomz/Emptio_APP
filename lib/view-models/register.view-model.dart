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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['photo'] = this.photo;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['location'] = this.location;
    return data;
  }
}
