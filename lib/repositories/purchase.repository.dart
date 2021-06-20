import 'package:emptio/core/app_api-errors.dart';
import 'package:emptio/core/app_api.dart';
import 'package:emptio/data/dao/purchase/purchase.dao.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/add_purchase_item.view-model.dart';
import 'package:emptio/view-models/purchase_filter.view-model.dart';
import 'package:emptio/view-models/update_purchase_item.view-model.dart';
import 'package:get_it/get_it.dart';

class PurchaseRepository {
  final AppApi _api = AppApi();
  final PurchaseDao _dao = PurchaseDao();
  final AuthStore _authStore = GetIt.I<AuthStore>();

  Future<PurchaseModel> create() async {
    try {
      if (_authStore.isLogged) {
        dynamic data = await _api.post("/purchases");
        return PurchaseModel.fromJson(data);
      }

      return await _dao.create();
    } catch (error) {
      print(error);
      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<List<PurchaseModel>> get(PurchasesFilterViewModel filter) async {
    try {
      if (_authStore.isLogged) {
        List data =
            await _api.get('/purchases', queryParameters: filter.toQuery());
        var list = data
            .map((purchase) => PurchaseModel.fromJson(purchase))
            .cast<PurchaseModel>()
            .toList();
        return list;
      }

      return _dao.getPurchases(filter);
    } catch (error) {
      print(error);
      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<void> delete(String purchaseId) async {
    try {
      if (_authStore.isLogged) {
        return await _api.delete("/purchases/$purchaseId");
      }

      return _dao.delete(int.parse(purchaseId));
    } catch (error) {
      print(error);
      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<PurchaseModel> addItem(
      String purchaseId, AddPurchaseItemViewModel model) async {
    try {
      if (_authStore.isLogged) {
        var data =
            await _api.post("/purchases/$purchaseId", body: model.toJson());

        return PurchaseModel.fromJson(data);
      }

      return await _dao.addItem(int.parse(purchaseId), model);
    } catch (error) {
      print(error);
      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<PurchaseModel> updateItem(
      String purchaseId, String itemId, UpdatePurchaseItemViewModel model) async {
    try {
      if (_authStore.isLogged) {
        var data =
            await _api.put("/purchases/$purchaseId/$itemId", model.toJson());

        return PurchaseModel.fromJson(data);
      }

      return await _dao.updateItem(int.parse(purchaseId), int.parse(itemId), model);
    } catch (error) {
      print(error);
      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<PurchaseModel> removeItem(String purchaseId, String itemId) async {
    try {
      if (_authStore.isLogged) {
        return await _api.delete("/purchases/$purchaseId/$itemId");
      }

      return _dao.removeItem(int.parse(purchaseId), int.parse(itemId));
    } catch (error) {
      print(error);
      return Future.error(AppApiErrors.handleError(error));
    }
  }
}
