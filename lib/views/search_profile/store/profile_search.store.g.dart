// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_search.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileSearchStore on _ProfileSearchStoreBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_ProfileSearchStoreBase.hasError'))
          .value;
  Computed<int>? _$itemsCountComputed;

  @override
  int get itemsCount =>
      (_$itemsCountComputed ??= Computed<int>(() => super.itemsCount,
              name: '_ProfileSearchStoreBase.itemsCount'))
          .value;
  Computed<bool>? _$isFirstLoadingComputed;

  @override
  bool get isFirstLoading =>
      (_$isFirstLoadingComputed ??= Computed<bool>(() => super.isFirstLoading,
              name: '_ProfileSearchStoreBase.isFirstLoading'))
          .value;

  final _$searchAtom = Atom(name: '_ProfileSearchStoreBase.search');

  @override
  String get search {
    _$searchAtom.reportRead();
    return super.search;
  }

  @override
  set search(String value) {
    _$searchAtom.reportWrite(value, super.search, () {
      super.search = value;
    });
  }

  final _$skipAtom = Atom(name: '_ProfileSearchStoreBase.skip');

  @override
  int get skip {
    _$skipAtom.reportRead();
    return super.skip;
  }

  @override
  set skip(int value) {
    _$skipAtom.reportWrite(value, super.skip, () {
      super.skip = value;
    });
  }

  final _$reachedEndAtom = Atom(name: '_ProfileSearchStoreBase.reachedEnd');

  @override
  bool get reachedEnd {
    _$reachedEndAtom.reportRead();
    return super.reachedEnd;
  }

  @override
  set reachedEnd(bool value) {
    _$reachedEndAtom.reportWrite(value, super.reachedEnd, () {
      super.reachedEnd = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ProfileSearchStoreBase.loading');

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

  final _$requestLoadingAtom =
      Atom(name: '_ProfileSearchStoreBase.requestLoading');

  @override
  bool get requestLoading {
    _$requestLoadingAtom.reportRead();
    return super.requestLoading;
  }

  @override
  set requestLoading(bool value) {
    _$requestLoadingAtom.reportWrite(value, super.requestLoading, () {
      super.requestLoading = value;
    });
  }

  final _$errorAtom = Atom(name: '_ProfileSearchStoreBase.error');

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

  final _$loadAsyncAction = AsyncAction('_ProfileSearchStoreBase.load');

  @override
  Future<void> load(ProfileSearchFilterViewModel filter) {
    return _$loadAsyncAction.run(() => super.load(filter));
  }

  final _$resetAsyncAction = AsyncAction('_ProfileSearchStoreBase.reset');

  @override
  Future<void> reset() {
    return _$resetAsyncAction.run(() => super.reset());
  }

  final _$requestAsyncAction = AsyncAction('_ProfileSearchStoreBase.request');

  @override
  Future<void> request(String friendId) {
    return _$requestAsyncAction.run(() => super.request(friendId));
  }

  final _$removeRequestAsyncAction =
      AsyncAction('_ProfileSearchStoreBase.removeRequest');

  @override
  Future<void> removeRequest(String sId, String requestId) {
    return _$removeRequestAsyncAction
        .run(() => super.removeRequest(sId, requestId));
  }

  final _$_ProfileSearchStoreBaseActionController =
      ActionController(name: '_ProfileSearchStoreBase');

  @override
  void setSearch(String _value) {
    final _$actionInfo = _$_ProfileSearchStoreBaseActionController.startAction(
        name: '_ProfileSearchStoreBase.setSearch');
    try {
      return super.setSearch(_value);
    } finally {
      _$_ProfileSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool _value) {
    final _$actionInfo = _$_ProfileSearchStoreBaseActionController.startAction(
        name: '_ProfileSearchStoreBase.setLoading');
    try {
      return super.setLoading(_value);
    } finally {
      _$_ProfileSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String _value) {
    final _$actionInfo = _$_ProfileSearchStoreBaseActionController.startAction(
        name: '_ProfileSearchStoreBase.setError');
    try {
      return super.setError(_value);
    } finally {
      _$_ProfileSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadNextPage() {
    final _$actionInfo = _$_ProfileSearchStoreBaseActionController.startAction(
        name: '_ProfileSearchStoreBase.loadNextPage');
    try {
      return super.loadNextPage();
    } finally {
      _$_ProfileSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
search: ${search},
skip: ${skip},
reachedEnd: ${reachedEnd},
loading: ${loading},
requestLoading: ${requestLoading},
error: ${error},
hasError: ${hasError},
itemsCount: ${itemsCount},
isFirstLoading: ${isFirstLoading}
    ''';
  }
}
