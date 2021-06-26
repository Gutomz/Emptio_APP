// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_purchase_item.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BasePurchaseItemStore on _BasePurchaseItemStoreBase, Store {
  Computed<bool>? _$quantityMinLimitComputed;

  @override
  bool get quantityMinLimit => (_$quantityMinLimitComputed ??= Computed<bool>(
          () => super.quantityMinLimit,
          name: '_BasePurchaseItemStoreBase.quantityMinLimit'))
      .value;
  Computed<bool>? _$quantityMaxLimitComputed;

  @override
  bool get quantityMaxLimit => (_$quantityMaxLimitComputed ??= Computed<bool>(
          () => super.quantityMaxLimit,
          name: '_BasePurchaseItemStoreBase.quantityMaxLimit'))
      .value;

  final _$quantityAtom = Atom(name: '_BasePurchaseItemStoreBase.quantity');

  @override
  int get quantity {
    _$quantityAtom.reportRead();
    return super.quantity;
  }

  @override
  set quantity(int value) {
    _$quantityAtom.reportWrite(value, super.quantity, () {
      super.quantity = value;
    });
  }

  final _$updateItemAsyncAction =
      AsyncAction('_BasePurchaseItemStoreBase.updateItem');

  @override
  Future<void> updateItem() {
    return _$updateItemAsyncAction.run(() => super.updateItem());
  }

  final _$deleteItemAsyncAction =
      AsyncAction('_BasePurchaseItemStoreBase.deleteItem');

  @override
  Future<void> deleteItem() {
    return _$deleteItemAsyncAction.run(() => super.deleteItem());
  }

  final _$_BasePurchaseItemStoreBaseActionController =
      ActionController(name: '_BasePurchaseItemStoreBase');

  @override
  void incrementQuantity() {
    final _$actionInfo = _$_BasePurchaseItemStoreBaseActionController
        .startAction(name: '_BasePurchaseItemStoreBase.incrementQuantity');
    try {
      return super.incrementQuantity();
    } finally {
      _$_BasePurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementQuantity() {
    final _$actionInfo = _$_BasePurchaseItemStoreBaseActionController
        .startAction(name: '_BasePurchaseItemStoreBase.decrementQuantity');
    try {
      return super.decrementQuantity();
    } finally {
      _$_BasePurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setItem(UpdateBasePurchaseItemViewModel model) {
    final _$actionInfo = _$_BasePurchaseItemStoreBaseActionController
        .startAction(name: '_BasePurchaseItemStoreBase.setItem');
    try {
      return super.setItem(model);
    } finally {
      _$_BasePurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
quantity: ${quantity},
quantityMinLimit: ${quantityMinLimit},
quantityMaxLimit: ${quantityMaxLimit}
    ''';
  }
}
