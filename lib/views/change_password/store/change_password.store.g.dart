// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChangePasswordStore on _ChangePasswordStoreBase, Store {
  Computed<bool>? _$actualPasswordValidComputed;

  @override
  bool get actualPasswordValid => (_$actualPasswordValidComputed ??=
          Computed<bool>(() => super.actualPasswordValid,
              name: '_ChangePasswordStoreBase.actualPasswordValid'))
      .value;
  Computed<String?>? _$actualPasswordErrorComputed;

  @override
  String? get actualPasswordError => (_$actualPasswordErrorComputed ??=
          Computed<String?>(() => super.actualPasswordError,
              name: '_ChangePasswordStoreBase.actualPasswordError'))
      .value;
  Computed<bool>? _$newPasswordValidComputed;

  @override
  bool get newPasswordValid => (_$newPasswordValidComputed ??= Computed<bool>(
          () => super.newPasswordValid,
          name: '_ChangePasswordStoreBase.newPasswordValid'))
      .value;
  Computed<String?>? _$newPasswordErrorComputed;

  @override
  String? get newPasswordError => (_$newPasswordErrorComputed ??=
          Computed<String?>(() => super.newPasswordError,
              name: '_ChangePasswordStoreBase.newPasswordError'))
      .value;
  Computed<bool>? _$confirmNewPasswordValidComputed;

  @override
  bool get confirmNewPasswordValid => (_$confirmNewPasswordValidComputed ??=
          Computed<bool>(() => super.confirmNewPasswordValid,
              name: '_ChangePasswordStoreBase.confirmNewPasswordValid'))
      .value;
  Computed<String?>? _$confirmNewPasswordErrorComputed;

  @override
  String? get confirmNewPasswordError => (_$confirmNewPasswordErrorComputed ??=
          Computed<String?>(() => super.confirmNewPasswordError,
              name: '_ChangePasswordStoreBase.confirmNewPasswordError'))
      .value;
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_ChangePasswordStoreBase.hasError'))
          .value;
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_ChangePasswordStoreBase.isFormValid'))
          .value;

  final _$actualPasswordAtom =
      Atom(name: '_ChangePasswordStoreBase.actualPassword');

  @override
  String? get actualPassword {
    _$actualPasswordAtom.reportRead();
    return super.actualPassword;
  }

  @override
  set actualPassword(String? value) {
    _$actualPasswordAtom.reportWrite(value, super.actualPassword, () {
      super.actualPassword = value;
    });
  }

  final _$newPasswordAtom = Atom(name: '_ChangePasswordStoreBase.newPassword');

  @override
  String? get newPassword {
    _$newPasswordAtom.reportRead();
    return super.newPassword;
  }

  @override
  set newPassword(String? value) {
    _$newPasswordAtom.reportWrite(value, super.newPassword, () {
      super.newPassword = value;
    });
  }

  final _$confirmNewPasswordAtom =
      Atom(name: '_ChangePasswordStoreBase.confirmNewPassword');

  @override
  String? get confirmNewPassword {
    _$confirmNewPasswordAtom.reportRead();
    return super.confirmNewPassword;
  }

  @override
  set confirmNewPassword(String? value) {
    _$confirmNewPasswordAtom.reportWrite(value, super.confirmNewPassword, () {
      super.confirmNewPassword = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ChangePasswordStoreBase.loading');

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

  final _$errorAtom = Atom(name: '_ChangePasswordStoreBase.error');

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

  final _$changePasswordAsyncAction =
      AsyncAction('_ChangePasswordStoreBase.changePassword');

  @override
  Future<bool> changePassword() {
    return _$changePasswordAsyncAction.run(() => super.changePassword());
  }

  final _$_ChangePasswordStoreBaseActionController =
      ActionController(name: '_ChangePasswordStoreBase');

  @override
  void setActualPassword(String _value) {
    final _$actionInfo = _$_ChangePasswordStoreBaseActionController.startAction(
        name: '_ChangePasswordStoreBase.setActualPassword');
    try {
      return super.setActualPassword(_value);
    } finally {
      _$_ChangePasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewPassword(String _value) {
    final _$actionInfo = _$_ChangePasswordStoreBaseActionController.startAction(
        name: '_ChangePasswordStoreBase.setNewPassword');
    try {
      return super.setNewPassword(_value);
    } finally {
      _$_ChangePasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmNewPassword(String _value) {
    final _$actionInfo = _$_ChangePasswordStoreBaseActionController.startAction(
        name: '_ChangePasswordStoreBase.setConfirmNewPassword');
    try {
      return super.setConfirmNewPassword(_value);
    } finally {
      _$_ChangePasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
actualPassword: ${actualPassword},
newPassword: ${newPassword},
confirmNewPassword: ${confirmNewPassword},
loading: ${loading},
error: ${error},
actualPasswordValid: ${actualPasswordValid},
actualPasswordError: ${actualPasswordError},
newPasswordValid: ${newPasswordValid},
newPasswordError: ${newPasswordError},
confirmNewPasswordValid: ${confirmNewPasswordValid},
confirmNewPasswordError: ${confirmNewPasswordError},
hasError: ${hasError},
isFormValid: ${isFormValid}
    ''';
  }
}
