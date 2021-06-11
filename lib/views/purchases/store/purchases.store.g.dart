// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchases.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PurchasesStore on _PurchasesStoreBase, Store {
  final _$statusAtom = Atom(name: '_PurchasesStoreBase.status');

  @override
  String get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(String value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$searchAtom = Atom(name: '_PurchasesStoreBase.search');

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

  final _$pageAtom = Atom(name: '_PurchasesStoreBase.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$loadingAtom = Atom(name: '_PurchasesStoreBase.loading');

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

  final _$errorAtom = Atom(name: '_PurchasesStoreBase.error');

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

  final _$loadPurchasesAsyncAction =
      AsyncAction('_PurchasesStoreBase.loadPurchases');

  @override
  Future<dynamic> loadPurchases() {
    return _$loadPurchasesAsyncAction.run(() => super.loadPurchases());
  }

  final _$_PurchasesStoreBaseActionController =
      ActionController(name: '_PurchasesStoreBase');

  @override
  void setStatus(String _value) {
    final _$actionInfo = _$_PurchasesStoreBaseActionController.startAction(
        name: '_PurchasesStoreBase.setStatus');
    try {
      return super.setStatus(_value);
    } finally {
      _$_PurchasesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearch(String _value) {
    final _$actionInfo = _$_PurchasesStoreBaseActionController.startAction(
        name: '_PurchasesStoreBase.setSearch');
    try {
      return super.setSearch(_value);
    } finally {
      _$_PurchasesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadNextPage() {
    final _$actionInfo = _$_PurchasesStoreBaseActionController.startAction(
        name: '_PurchasesStoreBase.loadNextPage');
    try {
      return super.loadNextPage();
    } finally {
      _$_PurchasesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetPage() {
    final _$actionInfo = _$_PurchasesStoreBaseActionController.startAction(
        name: '_PurchasesStoreBase.resetPage');
    try {
      return super.resetPage();
    } finally {
      _$_PurchasesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status},
search: ${search},
page: ${page},
loading: ${loading},
error: ${error}
    ''';
  }
}
