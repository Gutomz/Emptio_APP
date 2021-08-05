// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_details.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoriteDetailsStore on _FavoriteDetailsStoreBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_FavoriteDetailsStoreBase.hasError'))
          .value;
  Computed<bool>? _$favoriteLoadedComputed;

  @override
  bool get favoriteLoaded =>
      (_$favoriteLoadedComputed ??= Computed<bool>(() => super.favoriteLoaded,
              name: '_FavoriteDetailsStoreBase.favoriteLoaded'))
          .value;

  final _$favoriteAtom = Atom(name: '_FavoriteDetailsStoreBase.favorite');

  @override
  FavoritesModel? get favorite {
    _$favoriteAtom.reportRead();
    return super.favorite;
  }

  @override
  set favorite(FavoritesModel? value) {
    _$favoriteAtom.reportWrite(value, super.favorite, () {
      super.favorite = value;
    });
  }

  final _$loadingAtom = Atom(name: '_FavoriteDetailsStoreBase.loading');

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

  final _$errorAtom = Atom(name: '_FavoriteDetailsStoreBase.error');

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

  final _$loadAsyncAction = AsyncAction('_FavoriteDetailsStoreBase.load');

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  final _$addMarketAsyncAction =
      AsyncAction('_FavoriteDetailsStoreBase.addMarket');

  @override
  Future<void> addMarket({String? marketId, String? placeId}) {
    return _$addMarketAsyncAction
        .run(() => super.addMarket(marketId: marketId, placeId: placeId));
  }

  final _$removeMarketAsyncAction =
      AsyncAction('_FavoriteDetailsStoreBase.removeMarket');

  @override
  Future<void> removeMarket(String marketId) {
    return _$removeMarketAsyncAction.run(() => super.removeMarket(marketId));
  }

  final _$_FavoriteDetailsStoreBaseActionController =
      ActionController(name: '_FavoriteDetailsStoreBase');

  @override
  void setLoading(bool _value) {
    final _$actionInfo = _$_FavoriteDetailsStoreBaseActionController
        .startAction(name: '_FavoriteDetailsStoreBase.setLoading');
    try {
      return super.setLoading(_value);
    } finally {
      _$_FavoriteDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String _value) {
    final _$actionInfo = _$_FavoriteDetailsStoreBaseActionController
        .startAction(name: '_FavoriteDetailsStoreBase.setError');
    try {
      return super.setError(_value);
    } finally {
      _$_FavoriteDetailsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favorite: ${favorite},
loading: ${loading},
error: ${error},
hasError: ${hasError},
favoriteLoaded: ${favoriteLoaded}
    ''';
  }
}
