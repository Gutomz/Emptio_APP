// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchases.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PurchasesStore on _PurchasesStoreBase, Store {
  Computed<int>? _$itemCountComputed;

  @override
  int get itemCount =>
      (_$itemCountComputed ??= Computed<int>(() => super.itemCount,
              name: '_PurchasesStoreBase.itemCount'))
          .value;
  Computed<bool>? _$firstLoadingComputed;

  @override
  bool get firstLoading =>
      (_$firstLoadingComputed ??= Computed<bool>(() => super.firstLoading,
              name: '_PurchasesStoreBase.firstLoading'))
          .value;

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

  final _$skipAtom = Atom(name: '_PurchasesStoreBase.skip');

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

  final _$limitReachedAtom = Atom(name: '_PurchasesStoreBase.limitReached');

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
      AsyncAction('_PurchasesStoreBase.loadPurchases');

  @override
  Future<dynamic> loadPurchases(PurchasesFilterViewModel filter) {
    return _$loadPurchasesAsyncAction.run(() => super.loadPurchases(filter));
  }

  final _$createPurchaseAsyncAction =
      AsyncAction('_PurchasesStoreBase.createPurchase');

  @override
  Future<PurchaseModel?> createPurchase(CreatePurchaseViewModel createModel) {
    return _$createPurchaseAsyncAction
        .run(() => super.createPurchase(createModel));
  }

  final _$deletePurchaseAsyncAction =
      AsyncAction('_PurchasesStoreBase.deletePurchase');

  @override
  Future<void> deletePurchase(int index) {
    return _$deletePurchaseAsyncAction.run(() => super.deletePurchase(index));
  }

  final _$resetPageAsyncAction = AsyncAction('_PurchasesStoreBase.resetPage');

  @override
  Future<void> resetPage() {
    return _$resetPageAsyncAction.run(() => super.resetPage());
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
  void setLoading(bool _value) {
    final _$actionInfo = _$_PurchasesStoreBaseActionController.startAction(
        name: '_PurchasesStoreBase.setLoading');
    try {
      return super.setLoading(_value);
    } finally {
      _$_PurchasesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String _value) {
    final _$actionInfo = _$_PurchasesStoreBaseActionController.startAction(
        name: '_PurchasesStoreBase.setError');
    try {
      return super.setError(_value);
    } finally {
      _$_PurchasesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updatePurchase(PurchaseModel model) {
    final _$actionInfo = _$_PurchasesStoreBaseActionController.startAction(
        name: '_PurchasesStoreBase.updatePurchase');
    try {
      return super.updatePurchase(model);
    } finally {
      _$_PurchasesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeIndex(int index) {
    final _$actionInfo = _$_PurchasesStoreBaseActionController.startAction(
        name: '_PurchasesStoreBase.removeIndex');
    try {
      return super.removeIndex(index);
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
  String toString() {
    return '''
status: ${status},
skip: ${skip},
loading: ${loading},
error: ${error},
limitReached: ${limitReached},
itemCount: ${itemCount},
firstLoading: ${firstLoading}
    ''';
  }
}
