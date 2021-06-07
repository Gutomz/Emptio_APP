// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redefine_password.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RedefinePasswordStore on _RedefinePasswordStoreBase, Store {
  Computed<bool>? _$codeValidComputed;

  @override
  bool get codeValid =>
      (_$codeValidComputed ??= Computed<bool>(() => super.codeValid,
              name: '_RedefinePasswordStoreBase.codeValid'))
          .value;
  Computed<bool>? _$passwordValidComputed;

  @override
  bool get passwordValid =>
      (_$passwordValidComputed ??= Computed<bool>(() => super.passwordValid,
              name: '_RedefinePasswordStoreBase.passwordValid'))
          .value;
  Computed<String?>? _$passwordErrorComputed;

  @override
  String? get passwordError =>
      (_$passwordErrorComputed ??= Computed<String?>(() => super.passwordError,
              name: '_RedefinePasswordStoreBase.passwordError'))
          .value;
  Computed<bool>? _$confirmPasswordValidComputed;

  @override
  bool get confirmPasswordValid => (_$confirmPasswordValidComputed ??=
          Computed<bool>(() => super.confirmPasswordValid,
              name: '_RedefinePasswordStoreBase.confirmPasswordValid'))
      .value;
  Computed<String?>? _$confirmPasswordErrorComputed;

  @override
  String? get confirmPasswordError => (_$confirmPasswordErrorComputed ??=
          Computed<String?>(() => super.confirmPasswordError,
              name: '_RedefinePasswordStoreBase.confirmPasswordError'))
      .value;
  Computed<bool>? _$redefinePasswordValidComputed;

  @override
  bool get redefinePasswordValid => (_$redefinePasswordValidComputed ??=
          Computed<bool>(() => super.redefinePasswordValid,
              name: '_RedefinePasswordStoreBase.redefinePasswordValid'))
      .value;

  final _$codeAtom = Atom(name: '_RedefinePasswordStoreBase.code');

  @override
  String? get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(String? value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  final _$passwordAtom = Atom(name: '_RedefinePasswordStoreBase.password');

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

  final _$confirmPasswordAtom =
      Atom(name: '_RedefinePasswordStoreBase.confirmPassword');

  @override
  String? get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String? value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  final _$passwordVisibleAtom =
      Atom(name: '_RedefinePasswordStoreBase.passwordVisible');

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
      Atom(name: '_RedefinePasswordStoreBase.confirmPasswordVisible');

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

  final _$loadingAtom = Atom(name: '_RedefinePasswordStoreBase.loading');

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

  final _$loggedAtom = Atom(name: '_RedefinePasswordStoreBase.logged');

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

  final _$errorAtom = Atom(name: '_RedefinePasswordStoreBase.error');

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

  final _$redefinePasswordAsyncAction =
      AsyncAction('_RedefinePasswordStoreBase.redefinePassword');

  @override
  Future<void> redefinePassword(String email) {
    return _$redefinePasswordAsyncAction
        .run(() => super.redefinePassword(email));
  }

  final _$_RedefinePasswordStoreBaseActionController =
      ActionController(name: '_RedefinePasswordStoreBase');

  @override
  void setCode(String _value) {
    final _$actionInfo = _$_RedefinePasswordStoreBaseActionController
        .startAction(name: '_RedefinePasswordStoreBase.setCode');
    try {
      return super.setCode(_value);
    } finally {
      _$_RedefinePasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String _value) {
    final _$actionInfo = _$_RedefinePasswordStoreBaseActionController
        .startAction(name: '_RedefinePasswordStoreBase.setPassword');
    try {
      return super.setPassword(_value);
    } finally {
      _$_RedefinePasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String _value) {
    final _$actionInfo = _$_RedefinePasswordStoreBaseActionController
        .startAction(name: '_RedefinePasswordStoreBase.setConfirmPassword');
    try {
      return super.setConfirmPassword(_value);
    } finally {
      _$_RedefinePasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void togglePasswordVisible() {
    final _$actionInfo = _$_RedefinePasswordStoreBaseActionController
        .startAction(name: '_RedefinePasswordStoreBase.togglePasswordVisible');
    try {
      return super.togglePasswordVisible();
    } finally {
      _$_RedefinePasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleConfirmPasswordVisible() {
    final _$actionInfo =
        _$_RedefinePasswordStoreBaseActionController.startAction(
            name: '_RedefinePasswordStoreBase.toggleConfirmPasswordVisible');
    try {
      return super.toggleConfirmPasswordVisible();
    } finally {
      _$_RedefinePasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
code: ${code},
password: ${password},
confirmPassword: ${confirmPassword},
passwordVisible: ${passwordVisible},
confirmPasswordVisible: ${confirmPasswordVisible},
loading: ${loading},
logged: ${logged},
error: ${error},
codeValid: ${codeValid},
passwordValid: ${passwordValid},
passwordError: ${passwordError},
confirmPasswordValid: ${confirmPasswordValid},
confirmPasswordError: ${confirmPasswordError},
redefinePasswordValid: ${redefinePasswordValid}
    ''';
  }
}
