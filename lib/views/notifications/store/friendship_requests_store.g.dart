// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friendship_requests_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FriendshipRequestsStore on _FriendshipRequestsStoreBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_FriendshipRequestsStoreBase.hasError'))
          .value;

  final _$loadingAtom = Atom(name: '_FriendshipRequestsStoreBase.loading');

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

  final _$errorAtom = Atom(name: '_FriendshipRequestsStoreBase.error');

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

  final _$loadAsyncAction = AsyncAction('_FriendshipRequestsStoreBase.load');

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  final _$updateRequestAsyncAction =
      AsyncAction('_FriendshipRequestsStoreBase.updateRequest');

  @override
  Future<void> updateRequest(String requestId, bool accept) {
    return _$updateRequestAsyncAction
        .run(() => super.updateRequest(requestId, accept));
  }

  final _$_FriendshipRequestsStoreBaseActionController =
      ActionController(name: '_FriendshipRequestsStoreBase');

  @override
  void acceptRequest(String requestId) {
    final _$actionInfo = _$_FriendshipRequestsStoreBaseActionController
        .startAction(name: '_FriendshipRequestsStoreBase.acceptRequest');
    try {
      return super.acceptRequest(requestId);
    } finally {
      _$_FriendshipRequestsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void ignoreRequest(String requestId) {
    final _$actionInfo = _$_FriendshipRequestsStoreBaseActionController
        .startAction(name: '_FriendshipRequestsStoreBase.ignoreRequest');
    try {
      return super.ignoreRequest(requestId);
    } finally {
      _$_FriendshipRequestsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
error: ${error},
hasError: ${hasError}
    ''';
  }
}
