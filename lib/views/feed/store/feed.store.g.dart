// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedStore on _FeedStoreBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??=
          Computed<bool>(() => super.hasError, name: '_FeedStoreBase.hasError'))
      .value;
  Computed<bool>? _$firstLoadingComputed;

  @override
  bool get firstLoading =>
      (_$firstLoadingComputed ??= Computed<bool>(() => super.firstLoading,
              name: '_FeedStoreBase.firstLoading'))
          .value;
  Computed<int>? _$listCountComputed;

  @override
  int get listCount =>
      (_$listCountComputed ??= Computed<int>(() => super.listCount,
              name: '_FeedStoreBase.listCount'))
          .value;

  final _$skipAtom = Atom(name: '_FeedStoreBase.skip');

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

  final _$reachedEndAtom = Atom(name: '_FeedStoreBase.reachedEnd');

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

  final _$loadingAtom = Atom(name: '_FeedStoreBase.loading');

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

  final _$errorAtom = Atom(name: '_FeedStoreBase.error');

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

  final _$loadFeedAsyncAction = AsyncAction('_FeedStoreBase.loadFeed');

  @override
  Future<void> loadFeed(GetFeedFilterViewModel filter) {
    return _$loadFeedAsyncAction.run(() => super.loadFeed(filter));
  }

  final _$resetPageAsyncAction = AsyncAction('_FeedStoreBase.resetPage');

  @override
  Future<void> resetPage() {
    return _$resetPageAsyncAction.run(() => super.resetPage());
  }

  final _$deleteAsyncAction = AsyncAction('_FeedStoreBase.delete');

  @override
  Future<void> delete(String sId) {
    return _$deleteAsyncAction.run(() => super.delete(sId));
  }

  final _$_FeedStoreBaseActionController =
      ActionController(name: '_FeedStoreBase');

  @override
  void setLoading(bool _value) {
    final _$actionInfo = _$_FeedStoreBaseActionController.startAction(
        name: '_FeedStoreBase.setLoading');
    try {
      return super.setLoading(_value);
    } finally {
      _$_FeedStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String _value) {
    final _$actionInfo = _$_FeedStoreBaseActionController.startAction(
        name: '_FeedStoreBase.setError');
    try {
      return super.setError(_value);
    } finally {
      _$_FeedStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadNextPage() {
    final _$actionInfo = _$_FeedStoreBaseActionController.startAction(
        name: '_FeedStoreBase.loadNextPage');
    try {
      return super.loadNextPage();
    } finally {
      _$_FeedStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
skip: ${skip},
reachedEnd: ${reachedEnd},
loading: ${loading},
error: ${error},
hasError: ${hasError},
firstLoading: ${firstLoading},
listCount: ${listCount}
    ''';
  }
}
