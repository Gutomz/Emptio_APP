// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_search.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MarketSearchStore on _MarketSearchStoreBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_MarketSearchStoreBase.hasError'))
          .value;
  Computed<int>? _$suggestionsCountComputed;

  @override
  int get suggestionsCount => (_$suggestionsCountComputed ??= Computed<int>(
          () => super.suggestionsCount,
          name: '_MarketSearchStoreBase.suggestionsCount'))
      .value;
  Computed<int>? _$marketsCountComputed;

  @override
  int get marketsCount =>
      (_$marketsCountComputed ??= Computed<int>(() => super.marketsCount,
              name: '_MarketSearchStoreBase.marketsCount'))
          .value;
  Computed<bool>? _$firstLoadingComputed;

  @override
  bool get firstLoading =>
      (_$firstLoadingComputed ??= Computed<bool>(() => super.firstLoading,
              name: '_MarketSearchStoreBase.firstLoading'))
          .value;

  final _$searchAtom = Atom(name: '_MarketSearchStoreBase.search');

  @override
  String get search {
    _$searchAtom.reportRead();
    return super.search;
  }

  @override
  set search(String value) {
    _$searchAtom.reportWrite(value, super.search, () {
      super.search = value;
    });
  }

  final _$limitReachedAtom = Atom(name: '_MarketSearchStoreBase.limitReached');

  @override
  bool get limitReached {
    _$limitReachedAtom.reportRead();
    return super.limitReached;
  }

  @override
  set limitReached(bool value) {
    _$limitReachedAtom.reportWrite(value, super.limitReached, () {
      super.limitReached = value;
    });
  }

  final _$loadingAtom = Atom(name: '_MarketSearchStoreBase.loading');

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

  final _$loadingSuggestionsAtom =
      Atom(name: '_MarketSearchStoreBase.loadingSuggestions');

  @override
  bool get loadingSuggestions {
    _$loadingSuggestionsAtom.reportRead();
    return super.loadingSuggestions;
  }

  @override
  set loadingSuggestions(bool value) {
    _$loadingSuggestionsAtom.reportWrite(value, super.loadingSuggestions, () {
      super.loadingSuggestions = value;
    });
  }

  final _$errorAtom = Atom(name: '_MarketSearchStoreBase.error');

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

  final _$loadMarketsAsyncAction =
      AsyncAction('_MarketSearchStoreBase.loadMarkets');

  @override
  Future<dynamic> loadMarkets(MarketFilterViewModel filter) {
    return _$loadMarketsAsyncAction.run(() => super.loadMarkets(filter));
  }

  final _$loadSuggestionsAsyncAction =
      AsyncAction('_MarketSearchStoreBase.loadSuggestions');

  @override
  Future<void> loadSuggestions(String search) {
    return _$loadSuggestionsAsyncAction
        .run(() => super.loadSuggestions(search));
  }

  final _$_MarketSearchStoreBaseActionController =
      ActionController(name: '_MarketSearchStoreBase');

  @override
  void setLoading(bool _value) {
    final _$actionInfo = _$_MarketSearchStoreBaseActionController.startAction(
        name: '_MarketSearchStoreBase.setLoading');
    try {
      return super.setLoading(_value);
    } finally {
      _$_MarketSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String _value) {
    final _$actionInfo = _$_MarketSearchStoreBaseActionController.startAction(
        name: '_MarketSearchStoreBase.setError');
    try {
      return super.setError(_value);
    } finally {
      _$_MarketSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadNextPage() {
    final _$actionInfo = _$_MarketSearchStoreBaseActionController.startAction(
        name: '_MarketSearchStoreBase.loadNextPage');
    try {
      return super.loadNextPage();
    } finally {
      _$_MarketSearchStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
search: ${search},
limitReached: ${limitReached},
loading: ${loading},
loadingSuggestions: ${loadingSuggestions},
error: ${error},
hasError: ${hasError},
suggestionsCount: ${suggestionsCount},
marketsCount: ${marketsCount},
firstLoading: ${firstLoading}
    ''';
  }
}
