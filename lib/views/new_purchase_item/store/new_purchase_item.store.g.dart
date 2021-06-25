// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_purchase_item.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewPurchaseItemStore on _NewPurchaseItemStoreBase, Store {
  Computed<bool>? _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_NewPurchaseItemStoreBase.nameValid'))
          .value;
  Computed<String?>? _$nameErrorComputed;

  @override
  String? get nameError =>
      (_$nameErrorComputed ??= Computed<String?>(() => super.nameError,
              name: '_NewPurchaseItemStoreBase.nameError'))
          .value;
  Computed<bool>? _$brandValidComputed;

  @override
  bool get brandValid =>
      (_$brandValidComputed ??= Computed<bool>(() => super.brandValid,
              name: '_NewPurchaseItemStoreBase.brandValid'))
          .value;
  Computed<String?>? _$brandErrorComputed;

  @override
  String? get brandError =>
      (_$brandErrorComputed ??= Computed<String?>(() => super.brandError,
              name: '_NewPurchaseItemStoreBase.brandError'))
          .value;
  Computed<bool>? _$minQuantityReachedComputed;

  @override
  bool get minQuantityReached => (_$minQuantityReachedComputed ??=
          Computed<bool>(() => super.minQuantityReached,
              name: '_NewPurchaseItemStoreBase.minQuantityReached'))
      .value;
  Computed<bool>? _$maxQuantityReachedComputed;

  @override
  bool get maxQuantityReached => (_$maxQuantityReachedComputed ??=
          Computed<bool>(() => super.maxQuantityReached,
              name: '_NewPurchaseItemStoreBase.maxQuantityReached'))
      .value;
  Computed<double>? _$totalComputed;

  @override
  double get total => (_$totalComputed ??= Computed<double>(() => super.total,
          name: '_NewPurchaseItemStoreBase.total'))
      .value;
  Computed<bool>? _$formValidComputed;

  @override
  bool get formValid =>
      (_$formValidComputed ??= Computed<bool>(() => super.formValid,
              name: '_NewPurchaseItemStoreBase.formValid'))
          .value;

  final _$imageAtom = Atom(name: '_NewPurchaseItemStoreBase.image');

  @override
  File? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(File? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$brandAtom = Atom(name: '_NewPurchaseItemStoreBase.brand');

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

  final _$nameAtom = Atom(name: '_NewPurchaseItemStoreBase.name');

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

  final _$variationAtom = Atom(name: '_NewPurchaseItemStoreBase.variation');

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

  final _$weightValueAtom = Atom(name: '_NewPurchaseItemStoreBase.weightValue');

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

  final _$weightUnitAtom = Atom(name: '_NewPurchaseItemStoreBase.weightUnit');

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

  final _$priceAtom = Atom(name: '_NewPurchaseItemStoreBase.price');

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

  final _$quantityAtom = Atom(name: '_NewPurchaseItemStoreBase.quantity');

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

  final _$_NewPurchaseItemStoreBaseActionController =
      ActionController(name: '_NewPurchaseItemStoreBase');

  @override
  void setImage(File? _value) {
    final _$actionInfo = _$_NewPurchaseItemStoreBaseActionController
        .startAction(name: '_NewPurchaseItemStoreBase.setImage');
    try {
      return super.setImage(_value);
    } finally {
      _$_NewPurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setBrand(String _value) {
    final _$actionInfo = _$_NewPurchaseItemStoreBaseActionController
        .startAction(name: '_NewPurchaseItemStoreBase.setBrand');
    try {
      return super.setBrand(_value);
    } finally {
      _$_NewPurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String _value) {
    final _$actionInfo = _$_NewPurchaseItemStoreBaseActionController
        .startAction(name: '_NewPurchaseItemStoreBase.setName');
    try {
      return super.setName(_value);
    } finally {
      _$_NewPurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVariation(String _value) {
    final _$actionInfo = _$_NewPurchaseItemStoreBaseActionController
        .startAction(name: '_NewPurchaseItemStoreBase.setVariation');
    try {
      return super.setVariation(_value);
    } finally {
      _$_NewPurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWeightValue(double _value) {
    final _$actionInfo = _$_NewPurchaseItemStoreBaseActionController
        .startAction(name: '_NewPurchaseItemStoreBase.setWeightValue');
    try {
      return super.setWeightValue(_value);
    } finally {
      _$_NewPurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setWeightUnit(String _value) {
    final _$actionInfo = _$_NewPurchaseItemStoreBaseActionController
        .startAction(name: '_NewPurchaseItemStoreBase.setWeightUnit');
    try {
      return super.setWeightUnit(_value);
    } finally {
      _$_NewPurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPrice(double _value) {
    final _$actionInfo = _$_NewPurchaseItemStoreBaseActionController
        .startAction(name: '_NewPurchaseItemStoreBase.setPrice');
    try {
      return super.setPrice(_value);
    } finally {
      _$_NewPurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void incrementQuantity() {
    final _$actionInfo = _$_NewPurchaseItemStoreBaseActionController
        .startAction(name: '_NewPurchaseItemStoreBase.incrementQuantity');
    try {
      return super.incrementQuantity();
    } finally {
      _$_NewPurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementQuantity() {
    final _$actionInfo = _$_NewPurchaseItemStoreBaseActionController
        .startAction(name: '_NewPurchaseItemStoreBase.decrementQuantity');
    try {
      return super.decrementQuantity();
    } finally {
      _$_NewPurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTag(String tag) {
    final _$actionInfo = _$_NewPurchaseItemStoreBaseActionController
        .startAction(name: '_NewPurchaseItemStoreBase.addTag');
    try {
      return super.addTag(tag);
    } finally {
      _$_NewPurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTag(String tag) {
    final _$actionInfo = _$_NewPurchaseItemStoreBaseActionController
        .startAction(name: '_NewPurchaseItemStoreBase.removeTag');
    try {
      return super.removeTag(tag);
    } finally {
      _$_NewPurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  AddPurchaseItemViewModel getModel() {
    final _$actionInfo = _$_NewPurchaseItemStoreBaseActionController
        .startAction(name: '_NewPurchaseItemStoreBase.getModel');
    try {
      return super.getModel();
    } finally {
      _$_NewPurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  AddBasePurchaseItemViewModel getBaseModel() {
    final _$actionInfo = _$_NewPurchaseItemStoreBaseActionController
        .startAction(name: '_NewPurchaseItemStoreBase.getBaseModel');
    try {
      return super.getBaseModel();
    } finally {
      _$_NewPurchaseItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
image: ${image},
brand: ${brand},
name: ${name},
variation: ${variation},
weightValue: ${weightValue},
weightUnit: ${weightUnit},
price: ${price},
quantity: ${quantity},
nameValid: ${nameValid},
nameError: ${nameError},
brandValid: ${brandValid},
brandError: ${brandError},
minQuantityReached: ${minQuantityReached},
maxQuantityReached: ${maxQuantityReached},
total: ${total},
formValid: ${formValid}
    ''';
  }
}
