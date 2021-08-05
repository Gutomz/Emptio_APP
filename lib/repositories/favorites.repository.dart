import 'package:emptio/core/app_api_errors.dart';
import 'package:emptio/core/app_api.dart';
import 'package:emptio/helpers/logger.dart';
import 'package:emptio/models/favorites.model.dart';
import 'package:emptio/view-models/connect_market.view-model.dart';
import 'package:emptio/view-models/favorites_filter.view-model.dart';

class FavoritesRepository {
  static const String tag = "FavoritesRepository";
  final AppApi _api = AppApi();

  Future<FavoritesModel> create(String productId) async {
    try {
      final data =
          await _api.post('/favorites', body: {"product_id": productId})
              as Map<String, dynamic>;
      return FavoritesModel.fromJson(data);
    } catch (error, stack) {
      Logger.error(tag, 'create', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<void> delete(String favoriteId) async {
    try {
      await _api.delete('/favorites/$favoriteId');
    } catch (error, stack) {
      Logger.error(tag, 'delete', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<FavoritesModel> addMarket(
      String favoriteId, ConnectMarketViewModel model) async {
    try {
      final data = await _api.put('/favorites/$favoriteId',
          body: model.toJson()) as Map<String, dynamic>;
      return FavoritesModel.fromJson(data);
    } catch (error, stack) {
      Logger.error(tag, 'addMarket', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<FavoritesModel> removeMarket(
      String favoriteId, String marketId) async {
    try {
      final data = await _api.delete('/favorites/$favoriteId/$marketId')
          as Map<String, dynamic>;
      return FavoritesModel.fromJson(data);
    } catch (error, stack) {
      Logger.error(tag, 'removeMarket', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<List<FavoritesModel>> get(FavoritesFilterViewModel filter) async {
    try {
      final data = await _api.get('/favorites',
          queryParameters: filter.toQuery()) as List<dynamic>;

      return data
          .map<FavoritesModel>((product) =>
              FavoritesModel.fromJson(product as Map<String, dynamic>))
          .toList();
    } catch (error, stack) {
      Logger.error(tag, 'get', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<FavoritesModel> getDetails(String favoriteId) async {
    try {
      final data =
          await _api.get('/favorites/$favoriteId') as Map<String, dynamic>;

      return FavoritesModel.fromJson(data);
    } catch (error, stack) {
      Logger.error(tag, 'getDetails', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }
}
