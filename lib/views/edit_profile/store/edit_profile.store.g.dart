// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_profile.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditProfileStore on _EditProfileStoreBase, Store {
  Computed<int>? _$descriptionRemainingCharLengthComputed;

  @override
  int get descriptionRemainingCharLength =>
      (_$descriptionRemainingCharLengthComputed ??= Computed<int>(
              () => super.descriptionRemainingCharLength,
              name: '_EditProfileStoreBase.descriptionRemainingCharLength'))
          .value;
  Computed<bool>? _$photoChangedComputed;

  @override
  bool get photoChanged =>
      (_$photoChangedComputed ??= Computed<bool>(() => super.photoChanged,
              name: '_EditProfileStoreBase.photoChanged'))
          .value;
  Computed<bool>? _$hasChangesComputed;

  @override
  bool get hasChanges =>
      (_$hasChangesComputed ??= Computed<bool>(() => super.hasChanges,
              name: '_EditProfileStoreBase.hasChanges'))
          .value;

  final _$userAtom = Atom(name: '_EditProfileStoreBase.user');

  @override
  ProfileUserModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(ProfileUserModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$photoAtom = Atom(name: '_EditProfileStoreBase.photo');

  @override
  File? get photo {
    _$photoAtom.reportRead();
    return super.photo;
  }

  @override
  set photo(File? value) {
    _$photoAtom.reportWrite(value, super.photo, () {
      super.photo = value;
    });
  }

  final _$removePhotoAtom = Atom(name: '_EditProfileStoreBase.removePhoto');

  @override
  bool get removePhoto {
    _$removePhotoAtom.reportRead();
    return super.removePhoto;
  }

  @override
  set removePhoto(bool value) {
    _$removePhotoAtom.reportWrite(value, super.removePhoto, () {
      super.removePhoto = value;
    });
  }

  final _$nameAtom = Atom(name: '_EditProfileStoreBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$emailAtom = Atom(name: '_EditProfileStoreBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$descriptionAtom = Atom(name: '_EditProfileStoreBase.description');

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$maxDescriptionLengthAtom =
      Atom(name: '_EditProfileStoreBase.maxDescriptionLength');

  @override
  int get maxDescriptionLength {
    _$maxDescriptionLengthAtom.reportRead();
    return super.maxDescriptionLength;
  }

  @override
  set maxDescriptionLength(int value) {
    _$maxDescriptionLengthAtom.reportWrite(value, super.maxDescriptionLength,
        () {
      super.maxDescriptionLength = value;
    });
  }

  final _$loadingAtom = Atom(name: '_EditProfileStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$errorAtom = Atom(name: '_EditProfileStoreBase.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$saveProfileAsyncAction =
      AsyncAction('_EditProfileStoreBase.saveProfile');

  @override
  Future<void> saveProfile() {
    return _$saveProfileAsyncAction.run(() => super.saveProfile());
  }

  final _$_EditProfileStoreBaseActionController =
      ActionController(name: '_EditProfileStoreBase');

  @override
  void setPhoto(File? _value) {
    final _$actionInfo = _$_EditProfileStoreBaseActionController.startAction(
        name: '_EditProfileStoreBase.setPhoto');
    try {
      return super.setPhoto(_value);
    } finally {
      _$_EditProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String _value) {
    final _$actionInfo = _$_EditProfileStoreBaseActionController.startAction(
        name: '_EditProfileStoreBase.setName');
    try {
      return super.setName(_value);
    } finally {
      _$_EditProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String _value) {
    final _$actionInfo = _$_EditProfileStoreBaseActionController.startAction(
        name: '_EditProfileStoreBase.setEmail');
    try {
      return super.setEmail(_value);
    } finally {
      _$_EditProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDescription(String _value) {
    final _$actionInfo = _$_EditProfileStoreBaseActionController.startAction(
        name: '_EditProfileStoreBase.setDescription');
    try {
      return super.setDescription(_value);
    } finally {
      _$_EditProfileStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
photo: ${photo},
removePhoto: ${removePhoto},
name: ${name},
email: ${email},
description: ${description},
maxDescriptionLength: ${maxDescriptionLength},
loading: ${loading},
error: ${error},
descriptionRemainingCharLength: ${descriptionRemainingCharLength},
photoChanged: ${photoChanged},
hasChanges: ${hasChanges}
    ''';
  }
}
