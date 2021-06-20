// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_item.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PurchaseItemStore on _PurchaseItemStoreBase, Store {
  Computed<double>? _$totalPriceComputed;

  @override
  double get totalPrice =>
      (_$totalPriceComputed ??= Computed<double>(() => super.totalPrice,
              name: '_PurchaseItemStoreBase.totalPrice'))
          .value;
  Computed<bool>? _$quantityMinLimitComputed;

  @override
  bool get quantityMinLimit => (_$quantityMinLimitComputed ??= Computed<bool>(
          () => super.quantityMinLimit,
          name: '_PurchaseItemStoreBase.quantityMinLimit'))
      .value;
  Computed<bool>? _$quantityMaxLimitComputed;

  @override
  bool get quantityMaxLimit => (_$quantityMaxLimitComputed ??= Computed<bool>(
          () => super.quantityMaxLimit,
          name: '_PurchaseItemStoreBase.quantityMaxLimit'))
      .value;

  final _$priceAtom = Atom(name: '_PurchaseItemStoreBase.price');

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

  final _$quantityAtom = Atom(name: '_PurchaseItemStoreBase.quantity');

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

  final _$checkedAtom = Atom(name: '_PurchaseItemStoreBase.checked');

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

  final _$updateItemAsyncAction =
      AsyncAction('_PurchaseItemStoreBase.updateItem');

  @override
  Future<void> updateItem({bool shoulRefresh = false}) {
    return _$updateItemAsyncAction
        .run(() => super.updateItem(shoulRefresh: shoulRefresh));
  }

  final _$deleteItemAsyncAction =
      AsyncAction('_PurchaseItemStoreBase.deleteItem');

  @override
  Future<void> deleteItem() {
    return _$deleteItemAsyncAction.run(() => super.deleteItem());
  }

  final _$_PurchaseItemStoreBaseActionController =
      ActionController(name: '_PurchaseItemStoreBase');

  @override
  void toggleChecked() {
    final _$actionInfo = _$_PurchaseItemStoreBaseActionController.startAction(
        name: '_PurchaseItemStoreBase.toggleChecked');
    try {
      return super.toggleChecked();
    } finally {
      _$_PurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementQuantity() {
    final _$actionInfo = _$_PurchaseItemStoreBaseActionController.startAction(
        name: '_PurchaseItemStoreBase.incrementQuantity');
    try {
      return super.incrementQuantity();
    } finally {
      _$_PurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementQuantity() {
    final _$actionInfo = _$_PurchaseItemStoreBaseActionController.startAction(
        name: '_PurchaseItemStoreBase.decrementQuantity');
    try {
      return super.decrementQuantity();
    } finally {
      _$_PurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
price: ${price},
quantity: ${quantity},
checked: ${checked},
totalPrice: ${totalPrice},
quantityMinLimit: ${quantityMinLimit},
quantityMaxLimit: ${quantityMaxLimit}
    ''';
  }
}
