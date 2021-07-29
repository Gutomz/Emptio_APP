import 'package:emptio/core/app_api_errors.dart';
import 'package:emptio/core/app_api.dart';
import 'package:emptio/helpers/logger.dart';
import 'package:emptio/models/market_suggestion.model.dart';
import 'package:emptio/services/google_places_api.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/market_suggestions_filter.view-model.dart';
import 'package:get_it/get_it.dart';

class MarketRepository {
  static const String tag = "MarketRepository";
  final AppApi api = AppApi();
  final GooglePlacesApi _googlePlacesApi = GooglePlacesApi();
  final AuthStore _authStore = GetIt.I<AuthStore>();

  Future<List<MarketSuggestion>> getSuggestions(
      MarketSuggestionFilterViewModel filter) async {
    try {
      if (_authStore.isLogged) {
        final sessionId = _authStore.user!.sId;

        final data = await _googlePlacesApi.autocomplete(sessionId,
            queryParameters: filter.toQuery());

        final predictions = (data['predictions'] as List<dynamic>).where(
            (element) =>
                ((element as Map<String, dynamic>)['types'] as List<dynamic>)
                    .contains('grocery_or_supermarket') ||
                (element['types'] as List<dynamic>).contains('supermarket'));

        final list = (predictions
            .map<MarketSuggestion>((product) =>
                MarketSuggestion.fromJson(product as Map<String, dynamic>))
            .toList())
          ..sort((a, b) => a.distanceMeters.compareTo(b.distanceMeters));
        return list;
      }

      return [];
    } catch (error, stack) {
      Logger.error(tag, 'getSuggestions', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }
}
