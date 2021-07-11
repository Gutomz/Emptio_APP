import 'dart:io';

import 'package:emptio/models/profile_user.model.dart';
import 'package:emptio/repositories/user.repository.dart';
import 'package:emptio/view-models/edit_profile.view-model.dart';
import 'package:mobx/mobx.dart';
import 'package:emptio/helpers/extensions.dart';
part 'edit_profile.store.g.dart';

class EditProfileStore = _EditProfileStoreBase with _$EditProfileStore;

abstract class _EditProfileStoreBase with Store {
  _EditProfileStoreBase({required this.user})
      : name = user.name,
        email = user.email,
        description = user.description;

  @observable
  ProfileUserModel user;

  @observable
  File? photo;

  @observable
  bool removePhoto = false;

  @observable
  String name;

  @observable
  String email;

  @observable
  String description;

  @observable
  int maxDescriptionLength = 250;

  @observable
  bool loading = false;

  @observable
  String error = "";

  @action
  void setPhoto(File? _value) {
    photo = _value;
    removePhoto = _value == null;
  }

  @action
  void setName(String _value) => name = _value;

  @action
  void setEmail(String _value) => email = _value;

  @action
  void setDescription(String _value) => description = _value;

  @action
  Future<void> saveProfile() async {
    loading = true;

    try {
      final model = EditProfileViewModel(
        name: name,
        description: description,
        photo: photoChanged
            ? (photo == null ? null : photo!.parseToBase64())
            : user.photo,
      );

      final profile = await UserRepository().editProfile(model);
      user = profile;
      photo = null;
      removePhoto = false;
      error = "";
    } on String catch (_error) {
      error = _error;
    } finally {
      loading = false;
    }
  }

  @computed
  int get descriptionRemainingCharLength =>
      maxDescriptionLength - description.length;

  @computed
  bool get photoChanged =>
      (user.photo != null && removePhoto) ||
      (user.photo != null && photo != null) ||
      (user.photo == null && photo != null);

  @computed
  bool get hasChanges =>
      photoChanged ||
      name != user.name ||
      email != user.email ||
      description != user.description;
}
