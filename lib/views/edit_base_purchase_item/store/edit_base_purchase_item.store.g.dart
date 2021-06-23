// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_base_purchase_item.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditBasePurchaseItemStore on _EditBasePurchaseItemStoreBase, Store {
  Computed<bool>? _$minQuantityReachedComputed;

  @override
  bool get minQuantityReached => (_$minQuantityReachedComputed ??=
          Computed<bool>(() => super.minQuantityReached,
              name: '_EditBasePurchaseItemStoreBase.minQuantityReached'))
      .value;

  final _$quantityAtom = Atom(name: '_EditBasePurchaseItemStoreBase.quantity');

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

  final _$_EditBasePurchaseItemStoreBaseActionController =
      ActionController(name: '_EditBasePurchaseItemStoreBase');

  @override
  void incrementQuantity() {
    final _$actionInfo = _$_EditBasePurchaseItemStoreBaseActionController
        .startAction(name: '_EditBasePurchaseItemStoreBase.incrementQuantity');
    try {
      return super.incrementQuantity();
    } finally {
      _$_EditBasePurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementQuantity() {
    final _$actionInfo = _$_EditBasePurchaseItemStoreBaseActionController
        .startAction(name: '_EditBasePurchaseItemStoreBase.decrementQuantity');
    try {
      return super.decrementQuantity();
    } finally {
      _$_EditBasePurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
quantity: ${quantity},
minQuantityReached: ${minQuantityReached}
    ''';
  }
}
