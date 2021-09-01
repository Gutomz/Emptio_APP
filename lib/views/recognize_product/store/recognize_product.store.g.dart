// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recognize_product.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RecognizeProductStore on _RecognizeProductStoreBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_RecognizeProductStoreBase.hasError'))
          .value;
  Computed<bool>? _$hasItemsComputed;

  @override
  bool get hasItems =>
      (_$hasItemsComputed ??= Computed<bool>(() => super.hasItems,
              name: '_RecognizeProductStoreBase.hasItems'))
          .value;
  Computed<int>? _$itemsCountComputed;

  @override
  int get itemsCount =>
      (_$itemsCountComputed ??= Computed<int>(() => super.itemsCount,
              name: '_RecognizeProductStoreBase.itemsCount'))
          .value;

  final _$loadingAtom = Atom(name: '_RecognizeProductStoreBase.loading');

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

  final _$errorAtom = Atom(name: '_RecognizeProductStoreBase.error');

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$loadedAtom = Atom(name: '_RecognizeProductStoreBase.loaded');

  @override
  bool get loaded {
    _$loadedAtom.reportRead();
    return super.loaded;
  }

  @override
  set loaded(bool value) {
    _$loadedAtom.reportWrite(value, super.loaded, () {
      super.loaded = value;
    });
  }

  final _$hasResetAtom = Atom(name: '_RecognizeProductStoreBase.hasReset');

  @override
  bool get hasReset {
    _$hasResetAtom.reportRead();
    return super.hasReset;
  }

  @override
  set hasReset(bool value) {
    _$hasResetAtom.reportWrite(value, super.hasReset, () {
      super.hasReset = value;
    });
  }

  final _$imageBytesAtom = Atom(name: '_RecognizeProductStoreBase.imageBytes');

  @override
  Uint8List? get imageBytes {
    _$imageBytesAtom.reportRead();
    return super.imageBytes;
  }

  @override
  set imageBytes(Uint8List? value) {
    _$imageBytesAtom.reportWrite(value, super.imageBytes, () {
      super.imageBytes = value;
    });
  }

  final _$recognizeProductAsyncAction =
      AsyncAction('_RecognizeProductStoreBase.recognizeProduct');

  @override
  Future<void> recognizeProduct(Uint8List bytes) {
    return _$recognizeProductAsyncAction
        .run(() => super.recognizeProduct(bytes));
  }

  final _$_RecognizeProductStoreBaseActionController =
      ActionController(name: '_RecognizeProductStoreBase');

  @override
  void setLoading(bool _value) {
    final _$actionInfo = _$_RecognizeProductStoreBaseActionController
        .startAction(name: '_RecognizeProductStoreBase.setLoading');
    try {
      return super.setLoading(_value);
    } finally {
      _$_RecognizeProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoaded(bool _value) {
    final _$actionInfo = _$_RecognizeProductStoreBaseActionController
        .startAction(name: '_RecognizeProductStoreBase.setLoaded');
    try {
      return super.setLoaded(_value);
    } finally {
      _$_RecognizeProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String? _value) {
    final _$actionInfo = _$_RecognizeProductStoreBaseActionController
        .startAction(name: '_RecognizeProductStoreBase.setError');
    try {
      return super.setError(_value);
    } finally {
      _$_RecognizeProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHasReset(bool _value) {
    final _$actionInfo = _$_RecognizeProductStoreBaseActionController
        .startAction(name: '_RecognizeProductStoreBase.setHasReset');
    try {
      return super.setHasReset(_value);
    } finally {
      _$_RecognizeProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_RecognizeProductStoreBaseActionController
        .startAction(name: '_RecognizeProductStoreBase.reset');
    try {
      return super.reset();
    } finally {
      _$_RecognizeProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void restore() {
    final _$actionInfo = _$_RecognizeProductStoreBaseActionController
        .startAction(name: '_RecognizeProductStoreBase.restore');
    try {
      return super.restore();
    } finally {
      _$_RecognizeProductStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
error: ${error},
loaded: ${loaded},
hasReset: ${hasReset},
imageBytes: ${imageBytes},
hasError: ${hasError},
hasItems: ${hasItems},
itemsCount: ${itemsCount}
    ''';
  }
}
