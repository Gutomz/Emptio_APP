import 'package:emptio/core/app_api-errors.dart';
import 'package:emptio/core/app_api.dart';
import 'package:emptio/data/dao/base_purchase/base_purchase.dao.dart';
import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/add_base_purchase_item.view-model.dart';
import 'package:emptio/view-models/base_purchase_filter.view-model.dart';
import 'package:emptio/view-models/update_base_purchase_item.view-model.dart';
import 'package:get_it/get_it.dart';

class BasePurchaseRepository {
  static const String TAG = "BasePurchaseRepository";
  final AppApi _api = AppApi();
  final AuthStore _authStore = GetIt.I<AuthStore>();

  Future<BasePurchaseModel> create() async {
    try {
      if (_authStore.isLogged) {
        dynamic data = await _api.post("/base-purchases");
        return BasePurchaseModel.fromJson(data);
      }

      return await BasePurchaseDao.createParsed();
    } catch (error) {
      print('$TAG.create: $error');

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<List<BasePurchaseModel>> get(
      BasePurchasesFilterViewModel filter) async {
    try {
      if (_authStore.isLogged) {
        List data = await _api.get('/base-purchases',
            queryParameters: filter.toQuery());
        var list = data
            .map<BasePurchaseModel>(
                (purchase) => BasePurchaseModel.fromJson(purchase))
            .toList();
        return list;
      }

      return BasePurchaseDao.getAllParsed(filter);
    } catch (error) {
      print('$TAG.get: $error');

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
      print('$TAG.delete: $error');

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<BasePurchaseModel> addItem(
      String purchaseId, AddBasePurchaseItemViewModel model) async {
    try {
      if (_authStore.isLogged) {
        var data = await _api.post("/base-purchases/$purchaseId",
            body: model.toJson());

        return BasePurchaseModel.fromJson(data);
      }

      return await BasePurchaseDao.addItemParsed(int.parse(purchaseId), model);
    } catch (error) {
      print('$TAG.addItem: $error');

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<BasePurchaseModel> updateItem(String purchaseId, String itemId,
      UpdateBasePurchaseItemViewModel model) async {
    try {
      if (_authStore.isLogged) {
        var data = await _api.put(
            "/base-purchases/$purchaseId/$itemId", model.toJson());

        return BasePurchaseModel.fromJson(data);
      }

      return await BasePurchaseDao.updateItemParsed(
          int.parse(purchaseId), int.parse(itemId), model);
    } catch (error) {
      print('$TAG.updateItem: $error');

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<BasePurchaseModel> removeItem(String purchaseId, String itemId) async {
    try {
      if (_authStore.isLogged) {
        return await _api.delete("/base-purchases/$purchaseId/$itemId");
      }

      return BasePurchaseDao.removeItemParsed(
          int.parse(purchaseId), int.parse(itemId));
    } catch (error) {
      print('$TAG.removeItem: $error');

      return Future.error(AppApiErrors.handleError(error));
    }
  }
}
