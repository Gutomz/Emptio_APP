import 'package:emptio/core/app_api-errors.dart';
import 'package:emptio/core/app_api.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/purchase_filter.view-model.dart';
import 'package:get_it/get_it.dart';

class PurchaseRepository {
  final AppApi _api = AppApi();
  final AuthStore _authStore = GetIt.I<AuthStore>();

  Future<PurchaseModel> create() async {
    try {
      if (_authStore.isLogged) {
        dynamic data = await _api.post("/purchases");
        return PurchaseModel.fromJson(data);
      }
      String dateNow = DateTime.now().toIso8601String();
      return PurchaseModel(
          sId: dateNow,
          status: "opened",
          cost: 0,
          estimatedCost: 0,
          limit: 0,
          items: [],
          updatedAt: dateNow,
          createdAt: dateNow);
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

      return List<PurchaseModel>.empty(growable: true);
    } catch (error) {
      print(error);
      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<void> delete(String purchaseId) async {
    try {
      if (_authStore.isLogged) {
        await _api.delete("/purchases/$purchaseId");
      }
    } catch (error) {
      print(error);
      return Future.error(AppApiErrors.handleError(error));
    }
  }
}
