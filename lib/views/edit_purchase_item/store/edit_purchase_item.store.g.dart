// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_purchase_item.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditPurchaseItemStore on _EditPurchaseItemStoreBase, Store {
  Computed<UpdatePurchaseItemViewModel>? _$itemModelComputed;

  @override
  UpdatePurchaseItemViewModel get itemModel => (_$itemModelComputed ??=
          Computed<UpdatePurchaseItemViewModel>(() => super.itemModel,
              name: '_EditPurchaseItemStoreBase.itemModel'))
      .value;
  Computed<UpdateBasePurchaseItemViewModel>? _$itemBaseModelComputed;

  @override
  UpdateBasePurchaseItemViewModel get itemBaseModel =>
      (_$itemBaseModelComputed ??= Computed<UpdateBasePurchaseItemViewModel>(
              () => super.itemBaseModel,
              name: '_EditPurchaseItemStoreBase.itemBaseModel'))
          .value;
  Computed<double>? _$totalComputed;

  @override
  double get total => (_$totalComputed ??= Computed<double>(() => super.total,
          name: '_EditPurchaseItemStoreBase.total'))
      .value;
  Computed<bool>? _$minQuantityReachedComputed;

  @override
  bool get minQuantityReached => (_$minQuantityReachedComputed ??=
          Computed<bool>(() => super.minQuantityReached,
              name: '_EditPurchaseItemStoreBase.minQuantityReached'))
      .value;

  final _$priceAtom = Atom(name: '_EditPurchaseItemStoreBase.price');

  @override
  double get price {
    _$priceAtom.reportRead();
    return super.price;
  }

  @override
  set price(double value) {
    _$priceAtom.reportWrite(value, super.price, () {
      super.price = value;
    });
  }

  final _$quantityAtom = Atom(name: '_EditPurchaseItemStoreBase.quantity');

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

  final _$checkedAtom = Atom(name: '_EditPurchaseItemStoreBase.checked');

  @override
  bool get checked {
    _$checkedAtom.reportRead();
    return super.checked;
  }

  @override
  set checked(bool value) {
    _$checkedAtom.reportWrite(value, super.checked, () {
      super.checked = value;
    });
  }

  final _$_EditPurchaseItemStoreBaseActionController =
      ActionController(name: '_EditPurchaseItemStoreBase');

  @override
  void setPrice(double _value) {
    final _$actionInfo = _$_EditPurchaseItemStoreBaseActionController
        .startAction(name: '_EditPurchaseItemStoreBase.setPrice');
    try {
      return super.setPrice(_value);
    } finally {
      _$_EditPurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementQuantity() {
    final _$actionInfo = _$_EditPurchaseItemStoreBaseActionController
        .startAction(name: '_EditPurchaseItemStoreBase.incrementQuantity');
    try {
      return super.incrementQuantity();
    } finally {
      _$_EditPurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementQuantity() {
    final _$actionInfo = _$_EditPurchaseItemStoreBaseActionController
        .startAction(name: '_EditPurchaseItemStoreBase.decrementQuantity');
    try {
      return super.decrementQuantity();
    } finally {
      _$_EditPurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
price: ${price},
quantity: ${quantity},
checked: ${checked},
itemModel: ${itemModel},
itemBaseModel: ${itemBaseModel},
total: ${total},
minQuantityReached: ${minQuantityReached}
    ''';
  }
}
