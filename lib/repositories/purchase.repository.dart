import 'dart:developer';

import 'package:emptio/core/app_api_errors.dart';
import 'package:emptio/core/app_api.dart';
import 'package:emptio/data/dao/purchase/purchase.dao.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/add_purchase_item.view-model.dart';
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
    } catch (error) {
      log('$tag.create: $error');

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
    } catch (error) {
      log('$tag.get: $error');

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<void> delete(String purchaseId) async {
    try {
      if (_authStore.isLogged) {
        return await _api.delete("/purchases/$purchaseId");
      }

      return PurchaseDao.delete(int.parse(purchaseId));
    } catch (error) {
      log('$tag.delete: $error');

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
    } catch (error) {
      log('$tag.addItem: $error');

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
    } catch (error) {
      log('$tag.updateItem: $error');

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
    } catch (error) {
      log('$tag.removeItem: $error');

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
    } catch (error) {
      log('$tag.complete: $error');

      return Future.error(AppApiErrors.handleError(error));
    }
  }
}
