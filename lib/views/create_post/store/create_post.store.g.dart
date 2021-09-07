// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreatePostStore on _CreatePostStoreBase, Store {
  Computed<bool>? _$isDescriptionValidComputed;

  @override
  bool get isDescriptionValid => (_$isDescriptionValidComputed ??=
          Computed<bool>(() => super.isDescriptionValid,
              name: '_CreatePostStoreBase.isDescriptionValid'))
      .value;
  Computed<bool>? _$isPurchaseNameValidComputed;

  @override
  bool get isPurchaseNameValid => (_$isPurchaseNameValidComputed ??=
          Computed<bool>(() => super.isPurchaseNameValid,
              name: '_CreatePostStoreBase.isPurchaseNameValid'))
      .value;
  Computed<bool>? _$canCreateComputed;

  @override
  bool get canCreate =>
      (_$canCreateComputed ??= Computed<bool>(() => super.canCreate,
              name: '_CreatePostStoreBase.canCreate'))
          .value;
  Computed<String>? _$canCreateErrorComputed;

  @override
  String get canCreateError =>
      (_$canCreateErrorComputed ??= Computed<String>(() => super.canCreateError,
              name: '_CreatePostStoreBase.canCreateError'))
          .value;

  final _$loadingAtom = Atom(name: '_CreatePostStoreBase.loading');

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

  final _$descriptionAtom = Atom(name: '_CreatePostStoreBase.description');

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$purchaseNameAtom = Atom(name: '_CreatePostStoreBase.purchaseName');

  @override
  String? get purchaseName {
    _$purchaseNameAtom.reportRead();
    return super.purchaseName;
  }

  @override
  set purchaseName(String? value) {
    _$purchaseNameAtom.reportWrite(value, super.purchaseName, () {
      super.purchaseName = value;
    });
  }

  final _$errorAtom = Atom(name: '_CreatePostStoreBase.error');

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

  final _$createAsyncAction = AsyncAction('_CreatePostStoreBase.create');

  @override
  Future<void> create(CreatePostViewModel model) {
    return _$createAsyncAction.run(() => super.create(model));
  }

  final _$_CreatePostStoreBaseActionController =
      ActionController(name: '_CreatePostStoreBase');

  @override
  void setDescription(String _value) {
    final _$actionInfo = _$_CreatePostStoreBaseActionController.startAction(
        name: '_CreatePostStoreBase.setDescription');
    try {
      return super.setDescription(_value);
    } finally {
      _$_CreatePostStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPurchaseName(String? _value) {
    final _$actionInfo = _$_CreatePostStoreBaseActionController.startAction(
        name: '_CreatePostStoreBase.setPurchaseName');
    try {
      return super.setPurchaseName(_value);
    } finally {
      _$_CreatePostStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String _value) {
    final _$actionInfo = _$_CreatePostStoreBaseActionController.startAction(
        name: '_CreatePostStoreBase.setError');
    try {
      return super.setError(_value);
    } finally {
      _$_CreatePostStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
description: ${description},
purchaseName: ${purchaseName},
error: ${error},
isDescriptionValid: ${isDescriptionValid},
isPurchaseNameValid: ${isPurchaseNameValid},
canCreate: ${canCreate},
canCreateError: ${canCreateError}
    ''';
  }
}
