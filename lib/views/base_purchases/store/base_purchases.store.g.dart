// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_purchases.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BasePurchasesStore on _BasePurchasesStoreBase, Store {
  Computed<int>? _$itemCountComputed;

  @override
  int get itemCount =>
      (_$itemCountComputed ??= Computed<int>(() => super.itemCount,
              name: '_BasePurchasesStoreBase.itemCount'))
          .value;
  Computed<bool>? _$firstLoadingComputed;

  @override
  bool get firstLoading =>
      (_$firstLoadingComputed ??= Computed<bool>(() => super.firstLoading,
              name: '_BasePurchasesStoreBase.firstLoading'))
          .value;

  final _$searchAtom = Atom(name: '_BasePurchasesStoreBase.search');

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

  final _$skipAtom = Atom(name: '_BasePurchasesStoreBase.skip');

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

  final _$loadingAtom = Atom(name: '_BasePurchasesStoreBase.loading');

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

  final _$errorAtom = Atom(name: '_BasePurchasesStoreBase.error');

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

  final _$limitReachedAtom = Atom(name: '_BasePurchasesStoreBase.limitReached');

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

  final _$loadPurchasesAsyncAction =
      AsyncAction('_BasePurchasesStoreBase.loadPurchases');

  @override
  Future<dynamic> loadPurchases(BasePurchasesFilterViewModel filter) {
    return _$loadPurchasesAsyncAction.run(() => super.loadPurchases(filter));
  }

  final _$createPurchaseAsyncAction =
      AsyncAction('_BasePurchasesStoreBase.createPurchase');

  @override
  Future<BasePurchaseModel?> createPurchase() {
    return _$createPurchaseAsyncAction.run(() => super.createPurchase());
  }

  final _$deletePurchaseAsyncAction =
      AsyncAction('_BasePurchasesStoreBase.deletePurchase');

  @override
  Future<void> deletePurchase(int index) {
    return _$deletePurchaseAsyncAction.run(() => super.deletePurchase(index));
  }

  final _$resetPageAsyncAction =
      AsyncAction('_BasePurchasesStoreBase.resetPage');

  @override
  Future<void> resetPage() {
    return _$resetPageAsyncAction.run(() => super.resetPage());
  }

  final _$_BasePurchasesStoreBaseActionController =
      ActionController(name: '_BasePurchasesStoreBase');

  @override
  void setSearch(String _value) {
    final _$actionInfo = _$_BasePurchasesStoreBaseActionController.startAction(
        name: '_BasePurchasesStoreBase.setSearch');
    try {
      return super.setSearch(_value);
    } finally {
      _$_BasePurchasesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool _value) {
    final _$actionInfo = _$_BasePurchasesStoreBaseActionController.startAction(
        name: '_BasePurchasesStoreBase.setLoading');
    try {
      return super.setLoading(_value);
    } finally {
      _$_BasePurchasesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String _value) {
    final _$actionInfo = _$_BasePurchasesStoreBaseActionController.startAction(
        name: '_BasePurchasesStoreBase.setError');
    try {
      return super.setError(_value);
    } finally {
      _$_BasePurchasesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeIndex(int index) {
    final _$actionInfo = _$_BasePurchasesStoreBaseActionController.startAction(
        name: '_BasePurchasesStoreBase.removeIndex');
    try {
      return super.removeIndex(index);
    } finally {
      _$_BasePurchasesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadNextPage() {
    final _$actionInfo = _$_BasePurchasesStoreBaseActionController.startAction(
        name: '_BasePurchasesStoreBase.loadNextPage');
    try {
      return super.loadNextPage();
    } finally {
      _$_BasePurchasesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
search: ${search},
skip: ${skip},
loading: ${loading},
error: ${error},
limitReached: ${limitReached},
itemCount: ${itemCount},
firstLoading: ${firstLoading}
    ''';
  }
}
