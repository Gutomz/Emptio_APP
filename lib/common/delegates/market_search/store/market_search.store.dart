import 'package:emptio/helpers/location.dart';
import 'package:emptio/models/market.model.dart';
import 'package:emptio/models/market_suggestion.model.dart';
import 'package:emptio/repositories/market.repository.dart';
import 'package:emptio/view-models/market_filter.view-model.dart';
import 'package:emptio/view-models/market_suggestions_filter.view-model.dart';
import 'package:mobx/mobx.dart';

part 'market_search.store.g.dart';

class MarketSearchStore = _MarketSearchStoreBase with _$MarketSearchStore;

abstract class _MarketSearchStoreBase with Store {
  final String? favoriteId;

  _MarketSearchStoreBase({required this.favoriteId});

  ObservableList<MarketSuggestion> suggestionList = ObservableList();
  ObservableList<MarketModel> marketsList = ObservableList();

  @observable
  String search = "";

  @observable
  bool limitReached = false;

  @observable
  bool loading = false;

  @observable
  bool loadingSuggestions = false;

  @observable
  String error = "";

  @action
  // ignore: avoid_positional_boolean_parameters
  void setLoading(bool _value) => loading = _value;

  @action
  void setError(String _value) => error = _value;

  @action
  Future loadMarkets(MarketFilterViewModel filter) async {
    setLoading(true);

    try {
      filter.favoriteId = favoriteId;
      final list = await MarketRepository().get(filter);
      search = filter.search;

      if (list.length < filter.limit) limitReached = true;

      if (filter.skip == 0) {
        marketsList.clear();
      }

      marketsList.addAll(list);
      setError("");
    } on String catch (_error) {
      setError(_error);
    } finally {
      setLoading(false);
    }
  }

  @action
  void loadNextPage() {
    final filter = MarketFilterViewModel(
      search: search,
      skip: marketsList.length,
    );
    loadMarkets(filter);
  }

  @action
  Future<void> loadSuggestions(String search) async {
    loadingSuggestions = true;
    error = "";

    final location = await requestLocation();
    final filter = MarketSuggestionFilterViewModel(
      input: search,
      location: location,
      origin: location,
    );

    try {
      final suggestions = await MarketRepository().getSuggestions(filter);
      suggestionList.clear();
      suggestionList.addAll(suggestions);
    } on String catch (_error) {
      error = _error;
    } finally {
      loadingSuggestions = false;
    }
  }

  @computed
  bool get hasError => error.isNotEmpty;

  @computed
  int get suggestionsCount => suggestionList.length;

  @computed
  int get marketsCount =>
      limitReached ? marketsList.length : marketsList.length + 1;

  @computed
  bool get firstLoading => marketsList.isEmpty && loading;
}
