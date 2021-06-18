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

  final _$purchaseAtom = Atom(name: '_PurchaseDetailsStoreBase.purchase');

  @override
  PurchaseModel? get purchase {
    _$purchaseAtom.reportRead();
    return super.purchase;
  }

  @override
  set purchase(PurchaseModel? value) {
    _$purchaseAtom.reportWrite(value, super.purchase, () {
      super.purchase = value;
    });
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
  void clear() {
    final _$actionInfo = _$_PurchaseDetailsStoreBaseActionController
        .startAction(name: '_PurchaseDetailsStoreBase.clear');
    try {
      return super.clear();
    } finally {
      _$_PurchaseDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
purchase: ${purchase},
isMarketConnected: ${isMarketConnected}
    ''';
  }
}
