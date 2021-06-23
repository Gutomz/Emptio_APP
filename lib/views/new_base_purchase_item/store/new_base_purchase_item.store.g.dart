// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_base_purchase_item.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewBasePurchaseItemStore on _NewBasePurchaseItemStoreBase, Store {
  Computed<bool>? _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_NewBasePurchaseItemStoreBase.nameValid'))
          .value;
  Computed<String?>? _$nameErrorComputed;

  @override
  String? get nameError =>
      (_$nameErrorComputed ??= Computed<String?>(() => super.nameError,
              name: '_NewBasePurchaseItemStoreBase.nameError'))
          .value;
  Computed<bool>? _$brandValidComputed;

  @override
  bool get brandValid =>
      (_$brandValidComputed ??= Computed<bool>(() => super.brandValid,
              name: '_NewBasePurchaseItemStoreBase.brandValid'))
          .value;
  Computed<String?>? _$brandErrorComputed;

  @override
  String? get brandError =>
      (_$brandErrorComputed ??= Computed<String?>(() => super.brandError,
              name: '_NewBasePurchaseItemStoreBase.brandError'))
          .value;
  Computed<bool>? _$minQuantityReachedComputed;

  @override
  bool get minQuantityReached => (_$minQuantityReachedComputed ??=
          Computed<bool>(() => super.minQuantityReached,
              name: '_NewBasePurchaseItemStoreBase.minQuantityReached'))
      .value;
  Computed<bool>? _$maxQuantityReachedComputed;

  @override
  bool get maxQuantityReached => (_$maxQuantityReachedComputed ??=
          Computed<bool>(() => super.maxQuantityReached,
              name: '_NewBasePurchaseItemStoreBase.maxQuantityReached'))
      .value;
  Computed<bool>? _$formValidComputed;

  @override
  bool get formValid =>
      (_$formValidComputed ??= Computed<bool>(() => super.formValid,
              name: '_NewBasePurchaseItemStoreBase.formValid'))
          .value;

  final _$brandAtom = Atom(name: '_NewBasePurchaseItemStoreBase.brand');

  @override
  String? get brand {
    _$brandAtom.reportRead();
    return super.brand;
  }

  @override
  set brand(String? value) {
    _$brandAtom.reportWrite(value, super.brand, () {
      super.brand = value;
    });
  }

  final _$nameAtom = Atom(name: '_NewBasePurchaseItemStoreBase.name');

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$variationAtom = Atom(name: '_NewBasePurchaseItemStoreBase.variation');

  @override
  String get variation {
    _$variationAtom.reportRead();
    return super.variation;
  }

  @override
  set variation(String value) {
    _$variationAtom.reportWrite(value, super.variation, () {
      super.variation = value;
    });
  }

  final _$weightValueAtom =
      Atom(name: '_NewBasePurchaseItemStoreBase.weightValue');

  @override
  double get weightValue {
    _$weightValueAtom.reportRead();
    return super.weightValue;
  }

  @override
  set weightValue(double value) {
    _$weightValueAtom.reportWrite(value, super.weightValue, () {
      super.weightValue = value;
    });
  }

  final _$weightUnitAtom =
      Atom(name: '_NewBasePurchaseItemStoreBase.weightUnit');

  @override
  String get weightUnit {
    _$weightUnitAtom.reportRead();
    return super.weightUnit;
  }

  @override
  set weightUnit(String value) {
    _$weightUnitAtom.reportWrite(value, super.weightUnit, () {
      super.weightUnit = value;
    });
  }

  final _$quantityAtom = Atom(name: '_NewBasePurchaseItemStoreBase.quantity');

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

  final _$_NewBasePurchaseItemStoreBaseActionController =
      ActionController(name: '_NewBasePurchaseItemStoreBase');

  @override
  void setBrand(String _value) {
    final _$actionInfo = _$_NewBasePurchaseItemStoreBaseActionController
        .startAction(name: '_NewBasePurchaseItemStoreBase.setBrand');
    try {
      return super.setBrand(_value);
    } finally {
      _$_NewBasePurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String _value) {
    final _$actionInfo = _$_NewBasePurchaseItemStoreBaseActionController
        .startAction(name: '_NewBasePurchaseItemStoreBase.setName');
    try {
      return super.setName(_value);
    } finally {
      _$_NewBasePurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVariation(String _value) {
    final _$actionInfo = _$_NewBasePurchaseItemStoreBaseActionController
        .startAction(name: '_NewBasePurchaseItemStoreBase.setVariation');
    try {
      return super.setVariation(_value);
    } finally {
      _$_NewBasePurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWeightValue(double _value) {
    final _$actionInfo = _$_NewBasePurchaseItemStoreBaseActionController
        .startAction(name: '_NewBasePurchaseItemStoreBase.setWeightValue');
    try {
      return super.setWeightValue(_value);
    } finally {
      _$_NewBasePurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWeightUnit(String _value) {
    final _$actionInfo = _$_NewBasePurchaseItemStoreBaseActionController
        .startAction(name: '_NewBasePurchaseItemStoreBase.setWeightUnit');
    try {
      return super.setWeightUnit(_value);
    } finally {
      _$_NewBasePurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementQuantity() {
    final _$actionInfo = _$_NewBasePurchaseItemStoreBaseActionController
        .startAction(name: '_NewBasePurchaseItemStoreBase.incrementQuantity');
    try {
      return super.incrementQuantity();
    } finally {
      _$_NewBasePurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementQuantity() {
    final _$actionInfo = _$_NewBasePurchaseItemStoreBaseActionController
        .startAction(name: '_NewBasePurchaseItemStoreBase.decrementQuantity');
    try {
      return super.decrementQuantity();
    } finally {
      _$_NewBasePurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTag(String tag) {
    final _$actionInfo = _$_NewBasePurchaseItemStoreBaseActionController
        .startAction(name: '_NewBasePurchaseItemStoreBase.addTag');
    try {
      return super.addTag(tag);
    } finally {
      _$_NewBasePurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTag(String tag) {
    final _$actionInfo = _$_NewBasePurchaseItemStoreBaseActionController
        .startAction(name: '_NewBasePurchaseItemStoreBase.removeTag');
    try {
      return super.removeTag(tag);
    } finally {
      _$_NewBasePurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  AddBasePurchaseItemViewModel getModel() {
    final _$actionInfo = _$_NewBasePurchaseItemStoreBaseActionController
        .startAction(name: '_NewBasePurchaseItemStoreBase.getModel');
    try {
      return super.getModel();
    } finally {
      _$_NewBasePurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
brand: ${brand},
name: ${name},
variation: ${variation},
weightValue: ${weightValue},
weightUnit: ${weightUnit},
quantity: ${quantity},
nameValid: ${nameValid},
nameError: ${nameError},
brandValid: ${brandValid},
brandError: ${brandError},
minQuantityReached: ${minQuantityReached},
maxQuantityReached: ${maxQuantityReached},
formValid: ${formValid}
    ''';
  }
}
