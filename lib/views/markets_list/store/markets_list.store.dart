import 'package:emptio/models/market.model.dart';
import 'package:emptio/repositories/market.repository.dart';
import 'package:emptio/view-models/market_filter.view-model.dart';
import 'package:mobx/mobx.dart';
part 'markets_list.store.g.dart';

class MarketsListStore = _MarketsListStoreBase with _$MarketsListStore;

abstract class _MarketsListStoreBase with Store {
  _MarketsListStoreBase() {
    autorun((_) async {
      setLoading(true);

      final filter = MarketFilterViewModel(
        search: search,
        skip: skip,
      );

      await load(filter);
      setLoading(false);
    });
  }

  ObservableList<MarketModel> list = ObservableList();

  @observable
  String search = "";

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
  void setSearch(String _value) => search = _value;

  @action
  Future<void> load(MarketFilterViewModel filter) async {
    try {
      final data = await MarketRepository().get(filter);

      if (filter.skip == 0) {
        list.clear();
      }

      if (data.length < filter.limit) {
        reachedEnd = true;
      }

      error = "";
      list.addAll(data);
    } on String catch (_error) {
      error = _error;
    }
  }

  @action
  void loadNextPage() {
    skip = list.length;
  }

  @action
  Future<void> reset() async {
    list.clear();
    skip = 0;
    reachedEnd = false;
  }

  @action
  Future<void> deleteMarket(String sId) async {
    try {
      list.removeWhere((element) => element.sId.contains(sId));
      // await MarketRepository().delete(sId);
    } on String catch (_error) {
      error = _error;
    }
  }

  @computed
  bool get hasError => error.isNotEmpty;

  @computed
  int get listCount => reachedEnd ? list.length : list.length + 1;

  @computed
  bool get firstLoading => loading && list.isEmpty;
}
