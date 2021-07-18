// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followers_list.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FollowersListStore on _FollowersListStoreBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_FollowersListStoreBase.hasError'))
          .value;

  final _$userIdAtom = Atom(name: '_FollowersListStoreBase.userId');

  @override
  String? get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(String? value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  final _$followersAtom = Atom(name: '_FollowersListStoreBase.followers');

  @override
  bool get followers {
    _$followersAtom.reportRead();
    return super.followers;
  }

  @override
  set followers(bool value) {
    _$followersAtom.reportWrite(value, super.followers, () {
      super.followers = value;
    });
  }

  final _$loadingAtom = Atom(name: '_FollowersListStoreBase.loading');

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

  final _$errorAtom = Atom(name: '_FollowersListStoreBase.error');

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

  final _$requestAsyncAction = AsyncAction('_FollowersListStoreBase.request');

  @override
  Future<void> request(String friendId) {
    return _$requestAsyncAction.run(() => super.request(friendId));
  }

  final _$removeRequestAsyncAction =
      AsyncAction('_FollowersListStoreBase.removeRequest');

  @override
  Future<void> removeRequest(String sId, String requestId) {
    return _$removeRequestAsyncAction
        .run(() => super.removeRequest(sId, requestId));
  }

  final _$loadAsyncAction = AsyncAction('_FollowersListStoreBase.load');

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  final _$removeAsyncAction = AsyncAction('_FollowersListStoreBase.remove');

  @override
  Future<void> remove(String sId) {
    return _$removeAsyncAction.run(() => super.remove(sId));
  }

  final _$_FollowersListStoreBaseActionController =
      ActionController(name: '_FollowersListStoreBase');

  @override
  void setUserId(String? _value) {
    final _$actionInfo = _$_FollowersListStoreBaseActionController.startAction(
        name: '_FollowersListStoreBase.setUserId');
    try {
      return super.setUserId(_value);
    } finally {
      _$_FollowersListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFollowers(bool _value) {
    final _$actionInfo = _$_FollowersListStoreBaseActionController.startAction(
        name: '_FollowersListStoreBase.setFollowers');
    try {
      return super.setFollowers(_value);
    } finally {
      _$_FollowersListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userId: ${userId},
followers: ${followers},
loading: ${loading},
error: ${error},
hasError: ${hasError}
    ''';
  }
}
