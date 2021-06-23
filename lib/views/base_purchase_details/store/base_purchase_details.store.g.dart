// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_purchase_details.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BasePurchaseDetailsStore on _BasePurchaseDetailsStoreBase, Store {
  Computed<List<BasePurchaseItemModel>>? _$filtredItemsComputed;

  @override
  List<BasePurchaseItemModel> get filtredItems => (_$filtredItemsComputed ??=
          Computed<List<BasePurchaseItemModel>>(() => super.filtredItems,
              name: '_BasePurchaseDetailsStoreBase.filtredItems'))
      .value;
  Computed<int>? _$itemsCountComputed;

  @override
  int get itemsCount =>
      (_$itemsCountComputed ??= Computed<int>(() => super.itemsCount,
              name: '_BasePurchaseDetailsStoreBase.itemsCount'))
          .value;

  final _$loadingAtom = Atom(name: '_BasePurchaseDetailsStoreBase.loading');

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

  final _$errorAtom = Atom(name: '_BasePurchaseDetailsStoreBase.error');

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

  final _$addItemAsyncAction =
      AsyncAction('_BasePurchaseDetailsStoreBase.addItem');

  @override
  Future<void> addItem(AddBasePurchaseItemViewModel model) {
    return _$addItemAsyncAction.run(() => super.addItem(model));
  }

  final _$updateItemAsyncAction =
      AsyncAction('_BasePurchaseDetailsStoreBase.updateItem');

  @override
  Future<void> updateItem(
      String itemId, UpdateBasePurchaseItemViewModel model) {
    return _$updateItemAsyncAction.run(() => super.updateItem(itemId, model));
  }

  final _$deleteItemAsyncAction =
      AsyncAction('_BasePurchaseDetailsStoreBase.deleteItem');

  @override
  Future<void> deleteItem(String itemId) {
    return _$deleteItemAsyncAction.run(() => super.deleteItem(itemId));
  }

  final _$_BasePurchaseDetailsStoreBaseActionController =
      ActionController(name: '_BasePurchaseDetailsStoreBase');

  @override
  void updateItems(List<BasePurchaseItemModel> models) {
    final _$actionInfo = _$_BasePurchaseDetailsStoreBaseActionController
        .startAction(name: '_BasePurchaseDetailsStoreBase.updateItems');
    try {
      return super.updateItems(models);
    } finally {
      _$_BasePurchaseDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updatePurchase(BasePurchaseModel model) {
    final _$actionInfo = _$_BasePurchaseDetailsStoreBaseActionController
        .startAction(name: '_BasePurchaseDetailsStoreBase.updatePurchase');
    try {
      return super.updatePurchase(model);
    } finally {
      _$_BasePurchaseDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
error: ${error},
filtredItems: ${filtredItems},
itemsCount: ${itemsCount}
    ''';
  }
}
