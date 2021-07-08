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
  Computed<bool>? _$forgotPasswordValidComputed;

  @override
  bool get forgotPasswordValid => (_$forgotPasswordValidComputed ??=
          Computed<bool>(() => super.forgotPasswordValid,
              name: '_LoginStoreBase.forgotPasswordValid'))
      .value;
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_LoginStoreBase.loading'))
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

  final _$loginLoadingAtom = Atom(name: '_LoginStoreBase.loginLoading');

  @override
  bool get loginLoading {
    _$loginLoadingAtom.reportRead();
    return super.loginLoading;
  }

  @override
  set loginLoading(bool value) {
    _$loginLoadingAtom.reportWrite(value, super.loginLoading, () {
      super.loginLoading = value;
    });
  }

  final _$forgotPasswordLoadingAtom =
      Atom(name: '_LoginStoreBase.forgotPasswordLoading');

  @override
  bool get forgotPasswordLoading {
    _$forgotPasswordLoadingAtom.reportRead();
    return super.forgotPasswordLoading;
  }

  @override
  set forgotPasswordLoading(bool value) {
    _$forgotPasswordLoadingAtom.reportWrite(value, super.forgotPasswordLoading,
        () {
      super.forgotPasswordLoading = value;
    });
  }

  final _$errorAtom = Atom(name: '_LoginStoreBase.error');

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

  final _$loggedAtom = Atom(name: '_LoginStoreBase.logged');

  @override
  bool get logged {
    _$loggedAtom.reportRead();
    return super.logged;
  }

  @override
  set logged(bool value) {
    _$loggedAtom.reportWrite(value, super.logged, () {
      super.logged = value;
    });
  }

  final _$emailSentAtom = Atom(name: '_LoginStoreBase.emailSent');

  @override
  bool get emailSent {
    _$emailSentAtom.reportRead();
    return super.emailSent;
  }

  @override
  set emailSent(bool value) {
    _$emailSentAtom.reportWrite(value, super.emailSent, () {
      super.emailSent = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_LoginStoreBase.login');

  @override
  Future<void> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  final _$forgotPasswordAsyncAction =
      AsyncAction('_LoginStoreBase.forgotPassword');

  @override
  Future<void> forgotPassword() {
    return _$forgotPasswordAsyncAction.run(() => super.forgotPassword());
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
  String toString() {
    return '''
email: ${email},
password: ${password},
visible: ${visible},
loginLoading: ${loginLoading},
forgotPasswordLoading: ${forgotPasswordLoading},
error: ${error},
logged: ${logged},
emailSent: ${emailSent},
emailValid: ${emailValid},
emailError: ${emailError},
passwordValid: ${passwordValid},
passwordError: ${passwordError},
loginValid: ${loginValid},
forgotPasswordValid: ${forgotPasswordValid},
loading: ${loading}
    ''';
  }
}
