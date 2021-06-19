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
  Computed<int>? _$itemsCountComputed;

  @override
  int get itemsCount =>
      (_$itemsCountComputed ??= Computed<int>(() => super.itemsCount,
              name: '_PurchaseDetailsStoreBase.itemsCount'))
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

  final _$addItemAsyncAction = AsyncAction('_PurchaseDetailsStoreBase.addItem');

  @override
  Future<void> addItem(AddPurchaseItemViewModel model) {
    return _$addItemAsyncAction.run(() => super.addItem(model));
  }

  final _$_PurchaseDetailsStoreBaseActionController =
      ActionController(name: '_PurchaseDetailsStoreBase');

  @override
  void setPurchase(PurchaseModel _value) {
    final _$actionInfo = _$_PurchaseDetailsStoreBaseActionController
        .startAction(name: '_PurchaseDetailsStoreBase.setPurchase');
    try {
      return super.setPurchase(_value);
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
isMarketConnected: ${isMarketConnected},
itemsCount: ${itemsCount}
    ''';
  }
}
