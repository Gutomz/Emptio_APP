class ChangePasswordViewModel {
  final String actualPassword;
  final String newPassword;

  ChangePasswordViewModel({
    required this.actualPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['actualPassword'] = actualPassword;
    data['newPassword'] = newPassword;
    return data;
  }
}
