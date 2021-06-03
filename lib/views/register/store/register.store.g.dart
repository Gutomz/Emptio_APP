// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegisterStore on _RegisterStoreBase, Store {
  Computed<bool>? _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_RegisterStoreBase.nameValid'))
          .value;
  Computed<bool>? _$emailValidComputed;

  @override
  bool get emailValid =>
      (_$emailValidComputed ??= Computed<bool>(() => super.emailValid,
              name: '_RegisterStoreBase.emailValid'))
          .value;
  Computed<bool>? _$passwordValidComputed;

  @override
  bool get passwordValid =>
      (_$passwordValidComputed ??= Computed<bool>(() => super.passwordValid,
              name: '_RegisterStoreBase.passwordValid'))
          .value;
  Computed<bool>? _$confirmPasswordValidComputed;

  @override
  bool get confirmPasswordValid => (_$confirmPasswordValidComputed ??=
          Computed<bool>(() => super.confirmPasswordValid,
              name: '_RegisterStoreBase.confirmPasswordValid'))
      .value;
  Computed<bool>? _$registerValidComputed;

  @override
  bool get registerValid =>
      (_$registerValidComputed ??= Computed<bool>(() => super.registerValid,
              name: '_RegisterStoreBase.registerValid'))
          .value;

  final _$photoAtom = Atom(name: '_RegisterStoreBase.photo');

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

  final _$nameAtom = Atom(name: '_RegisterStoreBase.name');

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

  final _$emailAtom = Atom(name: '_RegisterStoreBase.email');

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

  final _$passwordAtom = Atom(name: '_RegisterStoreBase.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$confirmPasswordAtom =
      Atom(name: '_RegisterStoreBase.confirmPassword');

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  final _$passwordVisibleAtom =
      Atom(name: '_RegisterStoreBase.passwordVisible');

  @override
  bool get passwordVisible {
    _$passwordVisibleAtom.reportRead();
    return super.passwordVisible;
  }

  @override
  set passwordVisible(bool value) {
    _$passwordVisibleAtom.reportWrite(value, super.passwordVisible, () {
      super.passwordVisible = value;
    });
  }

  final _$confirmPasswordVisibleAtom =
      Atom(name: '_RegisterStoreBase.confirmPasswordVisible');

  @override
  bool get confirmPasswordVisible {
    _$confirmPasswordVisibleAtom.reportRead();
    return super.confirmPasswordVisible;
  }

  @override
  set confirmPasswordVisible(bool value) {
    _$confirmPasswordVisibleAtom
        .reportWrite(value, super.confirmPasswordVisible, () {
      super.confirmPasswordVisible = value;
    });
  }

  final _$_RegisterStoreBaseActionController =
      ActionController(name: '_RegisterStoreBase');

  @override
  void setPhoto(File? _value) {
    final _$actionInfo = _$_RegisterStoreBaseActionController.startAction(
        name: '_RegisterStoreBase.setPhoto');
    try {
      return super.setPhoto(_value);
    } finally {
      _$_RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String _value) {
    final _$actionInfo = _$_RegisterStoreBaseActionController.startAction(
        name: '_RegisterStoreBase.setName');
    try {
      return super.setName(_value);
    } finally {
      _$_RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String _value) {
    final _$actionInfo = _$_RegisterStoreBaseActionController.startAction(
        name: '_RegisterStoreBase.setEmail');
    try {
      return super.setEmail(_value);
    } finally {
      _$_RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String _value) {
    final _$actionInfo = _$_RegisterStoreBaseActionController.startAction(
        name: '_RegisterStoreBase.setPassword');
    try {
      return super.setPassword(_value);
    } finally {
      _$_RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String _value) {
    final _$actionInfo = _$_RegisterStoreBaseActionController.startAction(
        name: '_RegisterStoreBase.setConfirmPassword');
    try {
      return super.setConfirmPassword(_value);
    } finally {
      _$_RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void togglePasswordVisible() {
    final _$actionInfo = _$_RegisterStoreBaseActionController.startAction(
        name: '_RegisterStoreBase.togglePasswordVisible');
    try {
      return super.togglePasswordVisible();
    } finally {
      _$_RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleConfirmPasswordVisible() {
    final _$actionInfo = _$_RegisterStoreBaseActionController.startAction(
        name: '_RegisterStoreBase.toggleConfirmPasswordVisible');
    try {
      return super.toggleConfirmPasswordVisible();
    } finally {
      _$_RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
photo: ${photo},
name: ${name},
email: ${email},
password: ${password},
confirmPassword: ${confirmPassword},
passwordVisible: ${passwordVisible},
confirmPasswordVisible: ${confirmPasswordVisible},
nameValid: ${nameValid},
emailValid: ${emailValid},
passwordValid: ${passwordValid},
confirmPasswordValid: ${confirmPasswordValid},
registerValid: ${registerValid}
    ''';
  }
}
