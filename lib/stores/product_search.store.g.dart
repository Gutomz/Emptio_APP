// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_search.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProductSearchStore on _ProductSearchStoreBase, Store {
  Computed<int>? _$itemCountComputed;

  @override
  int get itemCount =>
      (_$itemCountComputed ??= Computed<int>(() => super.itemCount,
              name: '_ProductSearchStoreBase.itemCount'))
          .value;
  Computed<bool>? _$firstLoadingComputed;

  @override
  bool get firstLoading =>
      (_$firstLoadingComputed ??= Computed<bool>(() => super.firstLoading,
              name: '_ProductSearchStoreBase.firstLoading'))
          .value;

  final _$queryAtom = Atom(name: '_ProductSearchStoreBase.query');

  @override
  String get query {
    _$queryAtom.reportRead();
    return super.query;
  }

  @override
  set query(String value) {
    _$queryAtom.reportWrite(value, super.query, () {
      super.query = value;
    });
  }

  final _$skipAtom = Atom(name: '_ProductSearchStoreBase.skip');

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

  final _$loadingAtom = Atom(name: '_ProductSearchStoreBase.loading');

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

  final _$errorAtom = Atom(name: '_ProductSearchStoreBase.error');

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

  final _$limitReachedAtom = Atom(name: '_ProductSearchStoreBase.limitReached');

  @override
  bool get limitReached {
    _$limitReachedAtom.reportRead();
    return super.limitReached;
  }

  @override
  set limitReached(bool value) {
    _$limitReachedAtom.reportWrite(value, super.limitReached, () {
      super.limitReached = value;
    });
  }

  final _$loadProductsAsyncAction =
      AsyncAction('_ProductSearchStoreBase.loadProducts');

  @override
  Future<void> loadProducts(ProductFilterViewModel filter) {
    return _$loadProductsAsyncAction.run(() => super.loadProducts(filter));
  }

  final _$_ProductSearchStoreBaseActionController =
      ActionController(name: '_ProductSearchStoreBase');

  @override
  void setLoading(bool _value) {
    final _$actionInfo = _$_ProductSearchStoreBaseActionController.startAction(
        name: '_ProductSearchStoreBase.setLoading');
    try {
      return super.setLoading(_value);
    } finally {
      _$_ProductSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String _value) {
    final _$actionInfo = _$_ProductSearchStoreBaseActionController.startAction(
        name: '_ProductSearchStoreBase.setError');
    try {
      return super.setError(_value);
    } finally {
      _$_ProductSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuery(String _value) {
    final _$actionInfo = _$_ProductSearchStoreBaseActionController.startAction(
        name: '_ProductSearchStoreBase.setQuery');
    try {
      return super.setQuery(_value);
    } finally {
      _$_ProductSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeProduct(String productId) {
    final _$actionInfo = _$_ProductSearchStoreBaseActionController.startAction(
        name: '_ProductSearchStoreBase.removeProduct');
    try {
      return super.removeProduct(productId);
    } finally {
      _$_ProductSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetPage(String _query) {
    final _$actionInfo = _$_ProductSearchStoreBaseActionController.startAction(
        name: '_ProductSearchStoreBase.resetPage');
    try {
      return super.resetPage(_query);
    } finally {
      _$_ProductSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadNextPage() {
    final _$actionInfo = _$_ProductSearchStoreBaseActionController.startAction(
        name: '_ProductSearchStoreBase.loadNextPage');
    try {
      return super.loadNextPage();
    } finally {
      _$_ProductSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
query: ${query},
skip: ${skip},
loading: ${loading},
error: ${error},
limitReached: ${limitReached},
itemCount: ${itemCount},
firstLoading: ${firstLoading}
    ''';
  }
}
