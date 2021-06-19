import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/repositories/purchase.repository.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/view-models/add_purchase_item.view-model.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'purchase_details.store.g.dart';

class PurchaseDetailsStore = _PurchaseDetailsStoreBase
    with _$PurchaseDetailsStore;

abstract class _PurchaseDetailsStoreBase with Store {
  @observable
  PurchaseModel? purchase;

  @observable
  bool loading = false;

  @observable
  String error = "";

  @action
  void setPurchase(PurchaseModel _value) => purchase = _value;

  @action
  void clear() {
    purchase = null;
  }

  @action
  Future<void> addItem(AddPurchaseItemViewModel model) async {
    loading = true;
    error = "";

    try {
      PurchaseModel _purchase =
          await PurchaseRepository().addItem(purchase!.sId, model);

      purchase = _purchase;
    } on String catch (_error) {
      error = _error;
    }

    loading = false;
  }

  @computed
  bool get isMarketConnected => purchase != null && purchase!.market != null;
}
