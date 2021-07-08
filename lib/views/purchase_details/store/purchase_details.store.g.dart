// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_details.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PurchaseDetailsStore on _PurchaseDetailsStoreBase, Store {
  Computed<bool>? _$isMarketConnectedComputed;

  @override
  bool get isMarketConnected => (_$isMarketConnectedComputed ??= Computed<bool>(
          () => super.isMarketConnected,
          name: '_PurchaseDetailsStoreBase.isMarketConnected'))
      .value;
  Computed<List<PurchaseItemModel>>? _$filteredItemsComputed;

  @override
  List<PurchaseItemModel> get filteredItems => (_$filteredItemsComputed ??=
          Computed<List<PurchaseItemModel>>(() => super.filteredItems,
              name: '_PurchaseDetailsStoreBase.filteredItems'))
      .value;
  Computed<int>? _$itemsCountComputed;

  @override
  int get itemsCount =>
      (_$itemsCountComputed ??= Computed<int>(() => super.itemsCount,
              name: '_PurchaseDetailsStoreBase.itemsCount'))
          .value;
  Computed<int>? _$productsCountComputed;

  @override
  int get productsCount =>
      (_$productsCountComputed ??= Computed<int>(() => super.productsCount,
              name: '_PurchaseDetailsStoreBase.productsCount'))
          .value;
  Computed<bool>? _$isClosedComputed;

  @override
  bool get isClosed =>
      (_$isClosedComputed ??= Computed<bool>(() => super.isClosed,
              name: '_PurchaseDetailsStoreBase.isClosed'))
          .value;

  final _$purchaseAtom = Atom(name: '_PurchaseDetailsStoreBase.purchase');

  @override
  PurchaseModel get purchase {
    _$purchaseAtom.reportRead();
    return super.purchase;
  }

  @override
  set purchase(PurchaseModel value) {
    _$purchaseAtom.reportWrite(value, super.purchase, () {
      super.purchase = value;
    });
  }

  final _$loadingAtom = Atom(name: '_PurchaseDetailsStoreBase.loading');

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

  final _$errorAtom = Atom(name: '_PurchaseDetailsStoreBase.error');

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

  final _$showCheckedAtom = Atom(name: '_PurchaseDetailsStoreBase.showChecked');

  @override
  bool get showChecked {
    _$showCheckedAtom.reportRead();
    return super.showChecked;
  }

  @override
  set showChecked(bool value) {
    _$showCheckedAtom.reportWrite(value, super.showChecked, () {
      super.showChecked = value;
    });
  }

  final _$addItemAsyncAction = AsyncAction('_PurchaseDetailsStoreBase.addItem');

  @override
  Future<void> addItem(AddPurchaseItemViewModel model) {
    return _$addItemAsyncAction.run(() => super.addItem(model));
  }

  final _$updateItemAsyncAction =
      AsyncAction('_PurchaseDetailsStoreBase.updateItem');

  @override
  Future<void> updateItem(String itemId, UpdatePurchaseItemViewModel model) {
    return _$updateItemAsyncAction.run(() => super.updateItem(itemId, model));
  }

  final _$deleteItemAsyncAction =
      AsyncAction('_PurchaseDetailsStoreBase.deleteItem');

  @override
  Future<void> deleteItem(String itemId) {
    return _$deleteItemAsyncAction.run(() => super.deleteItem(itemId));
  }

  final _$_PurchaseDetailsStoreBaseActionController =
      ActionController(name: '_PurchaseDetailsStoreBase');

  @override
  void setFilter(bool _value) {
    final _$actionInfo = _$_PurchaseDetailsStoreBaseActionController
        .startAction(name: '_PurchaseDetailsStoreBase.setFilter');
    try {
      return super.setFilter(_value);
    } finally {
      _$_PurchaseDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleFilter() {
    final _$actionInfo = _$_PurchaseDetailsStoreBaseActionController
        .startAction(name: '_PurchaseDetailsStoreBase.toggleFilter');
    try {
      return super.toggleFilter();
    } finally {
      _$_PurchaseDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateItems(List<PurchaseItemModel> models) {
    final _$actionInfo = _$_PurchaseDetailsStoreBaseActionController
        .startAction(name: '_PurchaseDetailsStoreBase.updateItems');
    try {
      return super.updateItems(models);
    } finally {
      _$_PurchaseDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updatePurchase(PurchaseModel model) {
    final _$actionInfo = _$_PurchaseDetailsStoreBaseActionController
        .startAction(name: '_PurchaseDetailsStoreBase.updatePurchase');
    try {
      return super.updatePurchase(model);
    } finally {
      _$_PurchaseDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
purchase: ${purchase},
loading: ${loading},
error: ${error},
showChecked: ${showChecked},
isMarketConnected: ${isMarketConnected},
filteredItems: ${filteredItems},
itemsCount: ${itemsCount},
productsCount: ${productsCount},
isClosed: ${isClosed}
    ''';
  }
}
