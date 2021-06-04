// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStoreBase, Store {
  Computed<bool>? _$emailValidComputed;

  @override
  bool get emailValid =>
      (_$emailValidComputed ??= Computed<bool>(() => super.emailValid,
              name: '_LoginStoreBase.emailValid'))
          .value;
  Computed<String?>? _$emailErrorComputed;

  @override
  String? get emailError =>
      (_$emailErrorComputed ??= Computed<String?>(() => super.emailError,
              name: '_LoginStoreBase.emailError'))
          .value;
  Computed<bool>? _$passwordValidComputed;

  @override
  bool get passwordValid =>
      (_$passwordValidComputed ??= Computed<bool>(() => super.passwordValid,
              name: '_LoginStoreBase.passwordValid'))
          .value;
  Computed<String?>? _$passwordErrorComputed;

  @override
  String? get passwordError =>
      (_$passwordErrorComputed ??= Computed<String?>(() => super.passwordError,
              name: '_LoginStoreBase.passwordError'))
          .value;
  Computed<bool>? _$loginValidComputed;

  @override
  bool get loginValid =>
      (_$loginValidComputed ??= Computed<bool>(() => super.loginValid,
              name: '_LoginStoreBase.loginValid'))
          .value;

  final _$emailAtom = Atom(name: '_LoginStoreBase.email');

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_LoginStoreBase.password');

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$visibleAtom = Atom(name: '_LoginStoreBase.visible');

  @override
  bool get visible {
    _$visibleAtom.reportRead();
    return super.visible;
  }

  @override
  set visible(bool value) {
    _$visibleAtom.reportWrite(value, super.visible, () {
      super.visible = value;
    });
  }

  final _$_LoginStoreBaseActionController =
      ActionController(name: '_LoginStoreBase');

  @override
  void setEmail(String _value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setEmail');
    try {
      return super.setEmail(_value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String _value) {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.setPassword');
    try {
      return super.setPassword(_value);
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleVisible() {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.toggleVisible');
    try {
      return super.toggleVisible();
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void login() {
    final _$actionInfo = _$_LoginStoreBaseActionController.startAction(
        name: '_LoginStoreBase.login');
    try {
      return super.login();
    } finally {
      _$_LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
visible: ${visible},
emailValid: ${emailValid},
emailError: ${emailError},
passwordValid: ${passwordValid},
passwordError: ${passwordError},
loginValid: ${loginValid}
    ''';
  }
}
