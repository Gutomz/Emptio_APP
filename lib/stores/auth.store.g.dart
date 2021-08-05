// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStoreBase, Store {
  Computed<bool>? _$isLoggedComputed;

  @override
  bool get isLogged => (_$isLoggedComputed ??=
          Computed<bool>(() => super.isLogged, name: '_AuthStoreBase.isLogged'))
      .value;
  Computed<bool>? _$offlineLoggedComputed;

  @override
  bool get offlineLogged =>
      (_$offlineLoggedComputed ??= Computed<bool>(() => super.offlineLogged,
              name: '_AuthStoreBase.offlineLogged'))
          .value;
  Computed<String>? _$loggedIdComputed;

  @override
  String get loggedId =>
      (_$loggedIdComputed ??= Computed<String>(() => super.loggedId,
              name: '_AuthStoreBase.loggedId'))
          .value;

  final _$authAtom = Atom(name: '_AuthStoreBase.auth');

  @override
  AuthModel? get auth {
    _$authAtom.reportRead();
    return super.auth;
  }

  @override
  set auth(AuthModel? value) {
    _$authAtom.reportWrite(value, super.auth, () {
      super.auth = value;
    });
  }

  final _$userAtom = Atom(name: '_AuthStoreBase.user');

  @override
  UserModel? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$loadingAtom = Atom(name: '_AuthStoreBase.loading');

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

  final _$isActiveAtom = Atom(name: '_AuthStoreBase.isActive');

  @override
  bool get isActive {
    _$isActiveAtom.reportRead();
    return super.isActive;
  }

  @override
  set isActive(bool value) {
    _$isActiveAtom.reportWrite(value, super.isActive, () {
      super.isActive = value;
    });
  }

  final _$keepLoggedOutAtom = Atom(name: '_AuthStoreBase.keepLoggedOut');

  @override
  bool get keepLoggedOut {
    _$keepLoggedOutAtom.reportRead();
    return super.keepLoggedOut;
  }

  @override
  set keepLoggedOut(bool value) {
    _$keepLoggedOutAtom.reportWrite(value, super.keepLoggedOut, () {
      super.keepLoggedOut = value;
    });
  }

  final _$offlineModeAtom = Atom(name: '_AuthStoreBase.offlineMode');

  @override
  bool get offlineMode {
    _$offlineModeAtom.reportRead();
    return super.offlineMode;
  }

  @override
  set offlineMode(bool value) {
    _$offlineModeAtom.reportWrite(value, super.offlineMode, () {
      super.offlineMode = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_AuthStoreBase.login');

  @override
  Future<dynamic> login(AuthModel authModel) {
    return _$loginAsyncAction.run(() => super.login(authModel));
  }

  final _$logoutAsyncAction = AsyncAction('_AuthStoreBase.logout');

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$initAuthenticatedAsyncAction =
      AsyncAction('_AuthStoreBase.initAuthenticated');

  @override
  Future<bool> initAuthenticated() {
    return _$initAuthenticatedAsyncAction.run(() => super.initAuthenticated());
  }

  final _$updateLoggedUserAsyncAction =
      AsyncAction('_AuthStoreBase.updateLoggedUser');

  @override
  Future<void> updateLoggedUser() {
    return _$updateLoggedUserAsyncAction.run(() => super.updateLoggedUser());
  }

  final _$setKeepLoggedOutAsyncAction =
      AsyncAction('_AuthStoreBase.setKeepLoggedOut');

  @override
  Future<void> setKeepLoggedOut() {
    return _$setKeepLoggedOutAsyncAction.run(() => super.setKeepLoggedOut());
  }

  final _$triggerOfflineModeAsyncAction =
      AsyncAction('_AuthStoreBase.triggerOfflineMode');

  @override
  Future<void> triggerOfflineMode(bool value) {
    return _$triggerOfflineModeAsyncAction
        .run(() => super.triggerOfflineMode(value));
  }

  final _$_AuthStoreBaseActionController =
      ActionController(name: '_AuthStoreBase');

  @override
  void clear() {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.clear');
    try {
      return super.clear();
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
auth: ${auth},
user: ${user},
loading: ${loading},
isActive: ${isActive},
keepLoggedOut: ${keepLoggedOut},
offlineMode: ${offlineMode},
isLogged: ${isLogged},
offlineLogged: ${offlineLogged},
loggedId: ${loggedId}
    ''';
  }
}
