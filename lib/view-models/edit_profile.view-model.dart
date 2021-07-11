import 'package:emptio/core/app_api.dart';

class EditProfileViewModel {
  final String name;
  final String description;
  final String? photo;

  EditProfileViewModel({
    required this.name,
    required this.description,
    required this.photo,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['photo'] = AppApi.removeUrl(photo);
    return data;
  }
}
