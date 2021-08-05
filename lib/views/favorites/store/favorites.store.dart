import 'package:emptio/models/favorites.model.dart';
import 'package:emptio/repositories/favorites.repository.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/favorites_filter.view-model.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'favorites.store.g.dart';

class FavoritesStore = _FavoritesStoreBase with _$FavoritesStore;

abstract class _FavoritesStoreBase with Store {
  final AuthStore _authStore = GetIt.I<AuthStore>();

  _FavoritesStoreBase() {
    autorun((_) async {
      if (_authStore.isLogged) {
        setLoading(true);
        final filter = FavoritesFilterViewModel(
          skip: skip,
        );

        await load(filter);
        setLoading(false);
      }
    });
  }

  ObservableList<FavoritesModel> list = ObservableList();

  @observable
  int skip = 0;

  @observable
  bool reachedEnd = false;

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
  Future<void> load(FavoritesFilterViewModel filter) async {
    try {
      final data = await FavoritesRepository().get(filter);

      if (filter.skip == 0) {
        list.clear();
      }

      if (data.length < filter.limit) {
        reachedEnd = true;
      }

      list.addAll(data);
      setError("");
    } on String catch (_error) {
      setError(_error);
    }
  }

  @action
  void loadNextPage() {
    skip = list.length;
  }

  @action
  Future<void> resetPage() async {
    list.clear();
    skip = 0;
    reachedEnd = false;
  }

  @action
  Future<FavoritesModel?> create(String productId) async {
    setLoading(true);
    setError("");

    try {
      final favorite = await FavoritesRepository().create(productId);
      list.insert(0, favorite);
      return favorite;
    } on String catch (_error) {
      setError(_error);
    } finally {
      setLoading(false);
    }
  }

  @action
  Future<void> delete(String sId) async {
    setLoading(true);
    setError("");

    try {
      list.removeWhere((element) => element.sId.contains(sId));
      await FavoritesRepository().delete(sId);
    } on String catch (_error) {
      setError(_error);
    } finally {
      setLoading(false);
    }
  }

  @computed
  bool get hasError => error.isNotEmpty;

  @computed
  bool get firstLoading => loading && list.isEmpty;

  @computed
  int get listCount => reachedEnd ? list.length : list.length + 1;
}
