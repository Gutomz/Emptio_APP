// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_market.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreateMarketStore on _CreateMarketStoreBase, Store {
  Computed<bool>? _$nameValidComputed;

  @override
  bool get nameValid =>
      (_$nameValidComputed ??= Computed<bool>(() => super.nameValid,
              name: '_CreateMarketStoreBase.nameValid'))
          .value;
  Computed<String?>? _$nameErrorComputed;

  @override
  String? get nameError =>
      (_$nameErrorComputed ??= Computed<String?>(() => super.nameError,
              name: '_CreateMarketStoreBase.nameError'))
          .value;
  Computed<bool>? _$formValidComputed;

  @override
  bool get formValid =>
      (_$formValidComputed ??= Computed<bool>(() => super.formValid,
              name: '_CreateMarketStoreBase.formValid'))
          .value;

  final _$imageAtom = Atom(name: '_CreateMarketStoreBase.image');

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

  final _$nameAtom = Atom(name: '_CreateMarketStoreBase.name');

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

  final _$errorAtom = Atom(name: '_CreateMarketStoreBase.error');

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

  final _$createAsyncAction = AsyncAction('_CreateMarketStoreBase.create');

  @override
  Future<MarketModel?> create() {
    return _$createAsyncAction.run(() => super.create());
  }

  final _$_CreateMarketStoreBaseActionController =
      ActionController(name: '_CreateMarketStoreBase');

  @override
  void setImage(File? _value) {
    final _$actionInfo = _$_CreateMarketStoreBaseActionController.startAction(
        name: '_CreateMarketStoreBase.setImage');
    try {
      return super.setImage(_value);
    } finally {
      _$_CreateMarketStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String _value) {
    final _$actionInfo = _$_CreateMarketStoreBaseActionController.startAction(
        name: '_CreateMarketStoreBase.setName');
    try {
      return super.setName(_value);
    } finally {
      _$_CreateMarketStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
image: ${image},
name: ${name},
error: ${error},
nameValid: ${nameValid},
nameError: ${nameError},
formValid: ${formValid}
    ''';
  }
}
