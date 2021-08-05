// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoritesStore on _FavoritesStoreBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_FavoritesStoreBase.hasError'))
          .value;
  Computed<bool>? _$firstLoadingComputed;

  @override
  bool get firstLoading =>
      (_$firstLoadingComputed ??= Computed<bool>(() => super.firstLoading,
              name: '_FavoritesStoreBase.firstLoading'))
          .value;
  Computed<int>? _$listCountComputed;

  @override
  int get listCount =>
      (_$listCountComputed ??= Computed<int>(() => super.listCount,
              name: '_FavoritesStoreBase.listCount'))
          .value;

  final _$skipAtom = Atom(name: '_FavoritesStoreBase.skip');

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

  final _$reachedEndAtom = Atom(name: '_FavoritesStoreBase.reachedEnd');

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

  final _$loadingAtom = Atom(name: '_FavoritesStoreBase.loading');

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

  final _$errorAtom = Atom(name: '_FavoritesStoreBase.error');

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

  final _$loadAsyncAction = AsyncAction('_FavoritesStoreBase.load');

  @override
  Future<void> load(FavoritesFilterViewModel filter) {
    return _$loadAsyncAction.run(() => super.load(filter));
  }

  final _$resetPageAsyncAction = AsyncAction('_FavoritesStoreBase.resetPage');

  @override
  Future<void> resetPage() {
    return _$resetPageAsyncAction.run(() => super.resetPage());
  }

  final _$createAsyncAction = AsyncAction('_FavoritesStoreBase.create');

  @override
  Future<FavoritesModel?> create(String productId) {
    return _$createAsyncAction.run(() => super.create(productId));
  }

  final _$deleteAsyncAction = AsyncAction('_FavoritesStoreBase.delete');

  @override
  Future<void> delete(String sId) {
    return _$deleteAsyncAction.run(() => super.delete(sId));
  }

  final _$_FavoritesStoreBaseActionController =
      ActionController(name: '_FavoritesStoreBase');

  @override
  void setLoading(bool _value) {
    final _$actionInfo = _$_FavoritesStoreBaseActionController.startAction(
        name: '_FavoritesStoreBase.setLoading');
    try {
      return super.setLoading(_value);
    } finally {
      _$_FavoritesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String _value) {
    final _$actionInfo = _$_FavoritesStoreBaseActionController.startAction(
        name: '_FavoritesStoreBase.setError');
    try {
      return super.setError(_value);
    } finally {
      _$_FavoritesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadNextPage() {
    final _$actionInfo = _$_FavoritesStoreBaseActionController.startAction(
        name: '_FavoritesStoreBase.loadNextPage');
    try {
      return super.loadNextPage();
    } finally {
      _$_FavoritesStoreBaseActionController.endAction(_$actionInfo);
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
