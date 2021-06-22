import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/models/purchase_item.model.dart';
import 'package:emptio/repositories/purchase.repository.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/view-models/add_purchase_item.view-model.dart';
import 'package:emptio/view-models/update_purchase_item.view-model.dart';
import 'package:emptio/views/purchases/store/purchases.store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'purchase_details.store.g.dart';

class PurchaseDetailsStore = _PurchaseDetailsStoreBase
    with _$PurchaseDetailsStore;

abstract class _PurchaseDetailsStoreBase with Store {
  final PurchasesStore _purchasesStore = GetIt.I<AppStore>().openPurchasesStore;

  _PurchaseDetailsStoreBase({
    required this.purchase,
    required this.items,
    required this.checkedItems,
  });

  PurchaseModel purchase;

  ObservableList<PurchaseItemModel> items;
  ObservableList<PurchaseItemModel> checkedItems;

  @observable
  bool loading = false;

  @observable
  String error = "";

  @observable
  bool showChecked = false;

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

      updatePurchase(_purchase);
    } on String catch (_error) {
      error = _error;
    }

    loading = false;
  }

  @action
  Future<void> updateItem(
      String itemId, UpdatePurchaseItemViewModel model) async {
    loading = true;
    error = "";

    try {
      PurchaseModel _purchase =
          await PurchaseRepository().updateItem(purchase.sId, itemId, model);

      updatePurchase(_purchase);
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
      PurchaseModel _purchase =
          await PurchaseRepository().removeItem(purchase.sId, itemId);

      updatePurchase(_purchase);
    } on String catch (_error) {
      error = _error;
    }

    loading = false;
  }

  @action
  void updateItems(List<PurchaseItemModel> models) {
    items.clear();
    checkedItems.clear();
    items.addAll(models.where((v) => !v.checked));
    checkedItems..addAll(models.where((v) => v.checked));
  }

  @action
  void updatePurchase(PurchaseModel model) {
    purchase = model;
    updateItems(model.items);
    _purchasesStore.updatePurchase(model);
  }

  @action
  Future<void> toggleChecked(
      String itemsId, UpdatePurchaseItemViewModel model) async {
    items.removeWhere((v) => v.sId == itemsId);
    checkedItems.removeWhere((v) => v.sId == itemsId);
    updateItem(itemsId, model);
  }

  @computed
  bool get isMarketConnected => purchase.market != null;

  @computed
  List<PurchaseItemModel> get filtredItems =>
      showChecked ? checkedItems : items;

  @computed
  int get itemsCount => filtredItems.length;
}
