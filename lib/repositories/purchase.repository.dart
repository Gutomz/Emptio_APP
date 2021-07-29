import 'package:emptio/core/app_api_errors.dart';
import 'package:emptio/core/app_api.dart';
import 'package:emptio/data/dao/purchase.dao.dart';
import 'package:emptio/helpers/logger.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/add_purchase_item.view-model.dart';
import 'package:emptio/view-models/connect_market.view-model.dart';
import 'package:emptio/view-models/create_purchase.view-model.dart';
import 'package:emptio/view-models/purchase_filter.view-model.dart';
import 'package:emptio/view-models/update_purchase_item.view-model.dart';
import 'package:get_it/get_it.dart';

class PurchaseRepository {
  static const String tag = "PurchaseRepository";
  final AppApi _api = AppApi();
  final AuthStore _authStore = GetIt.I<AuthStore>();

  Future<PurchaseModel> create(CreatePurchaseViewModel model) async {
    try {
      if (_authStore.isLogged) {
        final data = await _api.post(
          "/purchases",
          body: model.toJson(),
        ) as Map<String, dynamic>;
        return PurchaseModel.fromJson(data);
      }

      return await PurchaseDao.createParsed(model);
    } catch (error, stack) {
      Logger.error(tag, 'create', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<List<PurchaseModel>> get(PurchasesFilterViewModel filter) async {
    try {
      if (_authStore.isLogged) {
        final data = await _api.get(
          '/purchases',
          queryParameters: filter.toQuery(),
        ) as List<dynamic>;
        final list = data
            .map<PurchaseModel>((purchase) =>
                PurchaseModel.fromJson(purchase as Map<String, dynamic>))
            .toList();
        return list;
      }

      return PurchaseDao.getAllParsed(filter);
    } catch (error, stack) {
      Logger.error(tag, 'get', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<void> delete(String purchaseId) async {
    try {
      if (_authStore.isLogged) {
        return await _api.delete("/purchases/$purchaseId");
      }

      return PurchaseDao.delete(int.parse(purchaseId));
    } catch (error, stack) {
      Logger.error(tag, 'delete', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<PurchaseModel> addItem(
      String purchaseId, AddPurchaseItemViewModel model) async {
    try {
      if (_authStore.isLogged) {
        final data = await _api.post(
          "/purchases/$purchaseId",
          body: model.toJson(),
        ) as Map<String, dynamic>;

        return PurchaseModel.fromJson(data);
      }

      return await PurchaseDao.addItemParsed(int.parse(purchaseId), model);
    } catch (error, stack) {
      Logger.error(tag, 'addItem', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<PurchaseModel> updateItem(String purchaseId, String itemId,
      UpdatePurchaseItemViewModel model) async {
    try {
      if (_authStore.isLogged) {
        final data = await _api.put(
          "/purchases/$purchaseId/$itemId",
          body: model.toJson(),
        ) as Map<String, dynamic>;

        return PurchaseModel.fromJson(data);
      }

      return await PurchaseDao.updateItemParsed(
          int.parse(purchaseId), int.parse(itemId), model);
    } catch (error, stack) {
      Logger.error(tag, 'updateItem', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<PurchaseModel> removeItem(String purchaseId, String itemId) async {
    try {
      if (_authStore.isLogged) {
        final data = await _api.delete("/purchases/$purchaseId/$itemId")
            as Map<String, dynamic>;
        return PurchaseModel.fromJson(data);
      }

      return PurchaseDao.removeItemParsed(
          int.parse(purchaseId), int.parse(itemId));
    } catch (error, stack) {
      Logger.error(tag, 'removeItem', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<PurchaseModel> complete(String purchaseId) async {
    try {
      if (_authStore.isLogged) {
        final data =
            await _api.put("/purchases/$purchaseId") as Map<String, dynamic>;
        return PurchaseModel.fromJson(data);
      }

      return PurchaseDao.completeParsed(int.parse(purchaseId));
    } catch (error, stack) {
      Logger.error(tag, 'complete', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<PurchaseModel> updateLimit(String purchaseId, double limit) async {
    try {
      if (_authStore.isLogged) {
        final data = await _api.patch(
          "/purchases/$purchaseId/limit",
          body: {"limit": limit},
        ) as Map<String, dynamic>;
        return PurchaseModel.fromJson(data);
      }

      return PurchaseDao.updateLimitParsed(int.parse(purchaseId), limit);
    } catch (error, stack) {
      Logger.error(tag, 'updateLimit', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<PurchaseModel> connectMarket(
      String purchaseId, ConnectMarketViewModel model) async {
    try {
      if (_authStore.isLogged) {
        final data = await _api.patch(
          "/purchases/$purchaseId/connect",
          body: model.toJson(),
        ) as Map<String, dynamic>;
        return PurchaseModel.fromJson(data);
      }

      int? marketKey;
      if (model.marketId != null) {
        marketKey = int.parse(model.marketId!);
      } else if (model.placeId != null) marketKey = int.parse(model.placeId!);

      return PurchaseDao.connectMarketParsed(int.parse(purchaseId), marketKey);
    } catch (error, stack) {
      Logger.error(tag, 'connectMarket', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }
}
