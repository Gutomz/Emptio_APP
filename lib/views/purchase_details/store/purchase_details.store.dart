import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/models/purchase_item.model.dart';
import 'package:emptio/repositories/purchase.repository.dart';
import 'package:emptio/view-models/add_purchase_item.view-model.dart';
import 'package:emptio/view-models/update_purchase_item.view-model.dart';
import 'package:mobx/mobx.dart';
part 'purchase_details.store.g.dart';

class PurchaseDetailsStore = _PurchaseDetailsStoreBase
    with _$PurchaseDetailsStore;

abstract class _PurchaseDetailsStoreBase with Store {
  _PurchaseDetailsStoreBase({required this.purchase, required this.items});

  PurchaseModel purchase;

  ObservableList<PurchaseItemModel> items;

  @observable
  bool loading = false;

  @observable
  String error = "";

  @observable
  bool showChecked = false;

  @action
  void setPurchase(PurchaseModel _value) => purchase = _value;

  @action
  void changeFilter(bool _value) {
    showChecked = _value;
  }

  @action
  Future<void> addItem(AddPurchaseItemViewModel model) async {
    loading = true;
    error = "";

    try {
      PurchaseModel _purchase =
          await PurchaseRepository().addItem(purchase.sId, model);

      purchase = _purchase;
    } on String catch (_error) {
      error = _error;
    }

    loading = false;
  }

  @action
  Future<void> updateItem(String itemId, UpdatePurchaseItemViewModel model,
      {bool shouldRefresh = false}) async {
    loading = true;
    error = "";

    try {
      PurchaseModel _purchase =
          await PurchaseRepository().updateItem(purchase.sId, itemId, model);

      purchase = _purchase;

      if(shouldRefresh) refreshItems();
    } on String catch (_error) {
      error = _error;
    }

    loading = false;
  }

  @action
  Future<void> deleteItem(String itemId) async {
    loading = true;
    error = "";

    try {
      items.removeWhere((element) => element.sId == itemId);
      PurchaseModel _purchase =
          await PurchaseRepository().removeItem(purchase.sId, itemId);

      purchase = _purchase;
    } on String catch (_error) {
      error = _error;
    }

    loading = false;
  }

  @action
  void refreshItems() {
    items.clear();
    items.addAll(purchase.items);
  }

  @computed
  bool get isMarketConnected => purchase.market != null;

  @computed
  List<PurchaseItemModel> get filtredItems =>
      items.where((element) => element.checked == showChecked).toList();

  @computed
  int get itemsCount => filtredItems.length;
}
