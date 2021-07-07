import 'dart:developer';

import 'package:emptio/core/app_api_errors.dart';
import 'package:emptio/core/app_api.dart';
import 'package:emptio/data/dao/base_purchase/base_purchase.dao.dart';
import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/add_base_purchase_item.view-model.dart';
import 'package:emptio/view-models/base_purchase_filter.view-model.dart';
import 'package:emptio/view-models/update_base_purchase.view-model.dart';
import 'package:emptio/view-models/update_base_purchase_item.view-model.dart';
import 'package:get_it/get_it.dart';

class BasePurchaseRepository {
  static const String tag = "BasePurchaseRepository";
  final AppApi _api = AppApi();
  final AuthStore _authStore = GetIt.I<AuthStore>();

  Future<BasePurchaseModel> create() async {
    try {
      if (_authStore.isLogged) {
        final data = await _api.post("/base-purchases") as Map<String, dynamic>;
        return BasePurchaseModel.fromJson(data);
      }

      return await BasePurchaseDao.createParsed();
    } catch (error) {
      log('$tag.create: $error');

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<List<BasePurchaseModel>> get(
      BasePurchasesFilterViewModel filter) async {
    try {
      if (_authStore.isLogged) {
        final data = await _api.get(
          '/base-purchases',
          queryParameters: filter.toQuery(),
        ) as List<dynamic>;
        final list = data
            .map<BasePurchaseModel>((purchase) =>
                BasePurchaseModel.fromJson(purchase as Map<String, dynamic>))
            .toList();
        return list;
      }

      return BasePurchaseDao.getAllParsed(filter);
    } catch (error) {
      log('$tag.get: $error');

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<void> delete(String purchaseId) async {
    try {
      if (_authStore.isLogged) {
        return await _api.delete("/base-purchases/$purchaseId");
      }

      return BasePurchaseDao.delete(int.parse(purchaseId));
    } catch (error) {
      log('$tag.delete: $error');

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<BasePurchaseModel> addItem(
      String purchaseId, AddBasePurchaseItemViewModel model) async {
    try {
      if (_authStore.isLogged) {
        final data = await _api.post("/base-purchases/$purchaseId",
            body: model.toJson()) as Map<String, dynamic>;

        return BasePurchaseModel.fromJson(data);
      }

      return await BasePurchaseDao.addItemParsed(int.parse(purchaseId), model);
    } catch (error) {
      log('$tag.addItem: $error');

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<BasePurchaseModel> updateItem(String purchaseId, String itemId,
      UpdateBasePurchaseItemViewModel model) async {
    try {
      if (_authStore.isLogged) {
        final data = await _api.put(
          "/base-purchases/$purchaseId/$itemId",
          body: model.toJson(),
        ) as Map<String, dynamic>;

        return BasePurchaseModel.fromJson(data);
      }

      return await BasePurchaseDao.updateItemParsed(
          int.parse(purchaseId), int.parse(itemId), model);
    } catch (error) {
      log('$tag.updateItem: $error');

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<BasePurchaseModel> removeItem(String purchaseId, String itemId) async {
    try {
      if (_authStore.isLogged) {
        final data = await _api.delete("/base-purchases/$purchaseId/$itemId")
            as Map<String, dynamic>;
        return BasePurchaseModel.fromJson(data);
      }

      return BasePurchaseDao.removeItemParsed(
          int.parse(purchaseId), int.parse(itemId));
    } catch (error) {
      log('$tag.removeItem: $error');

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<BasePurchaseModel> updatePurchase(
      String purchaseId, UpdateBasePurchaseViewModel model) async {
    try {
      if (_authStore.isLogged) {
        final data = await _api.put(
          "/base-purchases/$purchaseId",
          body: model.toJson(),
        ) as Map<String, dynamic>;
        return BasePurchaseModel.fromJson(data);
      }

      return BasePurchaseDao.updateParsed(int.parse(purchaseId), model);
    } catch (error) {
      log('$tag.updatePurchase: $error');

      return Future.error(AppApiErrors.handleError(error));
    }
  }
}
