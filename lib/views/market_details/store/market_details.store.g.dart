// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_details.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MarketDetailsStore on _MarketDetailsStoreBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_MarketDetailsStoreBase.hasError'))
          .value;
  Computed<bool>? _$marketLoadedComputed;

  @override
  bool get marketLoaded =>
      (_$marketLoadedComputed ??= Computed<bool>(() => super.marketLoaded,
              name: '_MarketDetailsStoreBase.marketLoaded'))
          .value;

  final _$marketAtom = Atom(name: '_MarketDetailsStoreBase.market');

  @override
  MarketModel? get market {
    _$marketAtom.reportRead();
    return super.market;
  }

  @override
  set market(MarketModel? value) {
    _$marketAtom.reportWrite(value, super.market, () {
      super.market = value;
    });
  }

  final _$loadingAtom = Atom(name: '_MarketDetailsStoreBase.loading');

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

  final _$errorAtom = Atom(name: '_MarketDetailsStoreBase.error');

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

  final _$loadAsyncAction = AsyncAction('_MarketDetailsStoreBase.load');

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  final _$_MarketDetailsStoreBaseActionController =
      ActionController(name: '_MarketDetailsStoreBase');

  @override
  void setLoading(bool _value) {
    final _$actionInfo = _$_MarketDetailsStoreBaseActionController.startAction(
        name: '_MarketDetailsStoreBase.setLoading');
    try {
      return super.setLoading(_value);
    } finally {
      _$_MarketDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String _value) {
    final _$actionInfo = _$_MarketDetailsStoreBaseActionController.startAction(
        name: '_MarketDetailsStoreBase.setError');
    try {
      return super.setError(_value);
    } finally {
      _$_MarketDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
market: ${market},
loading: ${loading},
error: ${error},
hasError: ${hasError},
marketLoaded: ${marketLoaded}
    ''';
  }
}
