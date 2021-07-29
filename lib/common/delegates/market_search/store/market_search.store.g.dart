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

  final _$loadSuggestionsAsyncAction =
      AsyncAction('_MarketSearchStoreBase.loadSuggestions');

  @override
  Future<void> loadSuggestions(String search) {
    return _$loadSuggestionsAsyncAction
        .run(() => super.loadSuggestions(search));
  }

  @override
  String toString() {
    return '''
loading: ${loading},
error: ${error},
hasError: ${hasError},
suggestionsCount: ${suggestionsCount}
    ''';
  }
}
