// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_list.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductsListStore on _ProductsListStoreBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_ProductsListStoreBase.hasError'))
          .value;
  Computed<int>? _$listCountComputed;

  @override
  int get listCount =>
      (_$listCountComputed ??= Computed<int>(() => super.listCount,
              name: '_ProductsListStoreBase.listCount'))
          .value;
  Computed<bool>? _$firstLoadingComputed;

  @override
  bool get firstLoading =>
      (_$firstLoadingComputed ??= Computed<bool>(() => super.firstLoading,
              name: '_ProductsListStoreBase.firstLoading'))
          .value;

  final _$searchAtom = Atom(name: '_ProductsListStoreBase.search');

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

  final _$skipAtom = Atom(name: '_ProductsListStoreBase.skip');

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

  final _$reachedEndAtom = Atom(name: '_ProductsListStoreBase.reachedEnd');

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

  final _$loadingAtom = Atom(name: '_ProductsListStoreBase.loading');

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

  final _$errorAtom = Atom(name: '_ProductsListStoreBase.error');

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

  final _$loadAsyncAction = AsyncAction('_ProductsListStoreBase.load');

  @override
  Future<void> load(ProductFilterViewModel filter) {
    return _$loadAsyncAction.run(() => super.load(filter));
  }

  final _$resetAsyncAction = AsyncAction('_ProductsListStoreBase.reset');

  @override
  Future<void> reset() {
    return _$resetAsyncAction.run(() => super.reset());
  }

  final _$deleteProductAsyncAction =
      AsyncAction('_ProductsListStoreBase.deleteProduct');

  @override
  Future<void> deleteProduct(String sId) {
    return _$deleteProductAsyncAction.run(() => super.deleteProduct(sId));
  }

  final _$getByIdAsyncAction = AsyncAction('_ProductsListStoreBase.getById');

  @override
  Future<void> getById(String sId) {
    return _$getByIdAsyncAction.run(() => super.getById(sId));
  }

  final _$_ProductsListStoreBaseActionController =
      ActionController(name: '_ProductsListStoreBase');

  @override
  void setLoading(bool _value) {
    final _$actionInfo = _$_ProductsListStoreBaseActionController.startAction(
        name: '_ProductsListStoreBase.setLoading');
    try {
      return super.setLoading(_value);
    } finally {
      _$_ProductsListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearch(String _value) {
    final _$actionInfo = _$_ProductsListStoreBaseActionController.startAction(
        name: '_ProductsListStoreBase.setSearch');
    try {
      return super.setSearch(_value);
    } finally {
      _$_ProductsListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadNextPage() {
    final _$actionInfo = _$_ProductsListStoreBaseActionController.startAction(
        name: '_ProductsListStoreBase.loadNextPage');
    try {
      return super.loadNextPage();
    } finally {
      _$_ProductsListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
search: ${search},
skip: ${skip},
reachedEnd: ${reachedEnd},
loading: ${loading},
error: ${error},
hasError: ${hasError},
listCount: ${listCount},
firstLoading: ${firstLoading}
    ''';
  }
}
