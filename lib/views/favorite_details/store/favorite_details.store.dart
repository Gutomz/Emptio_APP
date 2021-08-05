import 'package:emptio/models/favorites.model.dart';
import 'package:emptio/repositories/favorites.repository.dart';
import 'package:emptio/view-models/connect_market.view-model.dart';
import 'package:mobx/mobx.dart';
part 'favorite_details.store.g.dart';

class FavoriteDetailsStore = _FavoriteDetailsStoreBase
    with _$FavoriteDetailsStore;

abstract class _FavoriteDetailsStoreBase with Store {
  final String favoriteId;

  _FavoriteDetailsStoreBase({required this.favoriteId}) {
    load();
  }

  @observable
  FavoritesModel? favorite;

  @observable
  bool loading = false;

  @observable
  String error = "";

  @action
  // ignore: avoid_positional_boolean_parameters
  void setLoading(bool _value) => loading = _value;

  @action
  void setError(String _value) => error = _value;

  @action
  Future<void> load() async {
    setLoading(true);
    setError("");
    try {
      favorite = await FavoritesRepository().getDetails(favoriteId);
    } on String catch (_error) {
      setError(_error);
    } finally {
      setLoading(false);
    }
  }

  @action
  Future<void> addMarket({String? marketId, String? placeId}) async {
    setLoading(true);
    setError("");
    try {
      final model =
          ConnectMarketViewModel(marketId: marketId, placeId: placeId);
      favorite = await FavoritesRepository().addMarket(favoriteId, model);
    } on String catch (_error) {
      setError(_error);
    } finally {
      setLoading(false);
    }
  }

  @action
  Future<void> removeMarket(String marketId) async {
    setLoading(true);
    setError("");
    try {
      favorite = await FavoritesRepository().removeMarket(favoriteId, marketId);
    } on String catch (_error) {
      setError(_error);
    } finally {
      setLoading(false);
    }
  }

  @computed
  bool get hasError => error.isNotEmpty;

  @computed
  bool get favoriteLoaded => favorite != null;
}
