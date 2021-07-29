import 'package:emptio/helpers/location.dart';
import 'package:emptio/models/market_suggestion.model.dart';
import 'package:emptio/repositories/market.repository.dart';
import 'package:emptio/view-models/market_suggestions_filter.view-model.dart';
import 'package:mobx/mobx.dart';

part 'market_search.store.g.dart';

class MarketSearchStore = _MarketSearchStoreBase with _$MarketSearchStore;

abstract class _MarketSearchStoreBase with Store {
  ObservableList<MarketSuggestion> suggestionList = ObservableList();

  @observable
  bool loading = false;

  @observable
  String error = "";

  @action
  Future<void> loadSuggestions(String search) async {
    loading = true;
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
      loading = false;
    }
  }

  @computed
  bool get hasError => error.isNotEmpty;

  @computed
  int get suggestionsCount => suggestionList.length;
}
