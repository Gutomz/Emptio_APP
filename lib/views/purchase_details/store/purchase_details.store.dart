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
  })  : items = ObservableList<PurchaseItemModel>()
          ..addAll(purchase.items.where((v) => !v.checked)),
        checkedItems = ObservableList<PurchaseItemModel>()
          ..addAll(purchase.items.where((v) => v.checked)),
        showChecked = PurchaseStatusTypes.closed.contains(purchase.status);

  @observable
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
  // ignore: avoid_positional_boolean_parameters
  void setFilter(bool _value) => showChecked = _value;

  @action
  void toggleFilter() {
    setFilter(!showChecked);
  }

  @action
  Future<void> addItem(AddPurchaseItemViewModel model) async {
    loading = true;
    error = "";

    try {
      final _purchase = await PurchaseRepository().addItem(purchase.sId, model);

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
      final _purchase =
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
      final _purchase =
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
    checkedItems.addAll(models.where((v) => v.checked));
  }

  @action
  void updatePurchase(PurchaseModel model) {
    purchase = model;
    updateItems(model.items);
    _purchasesStore.updatePurchase(model);
  }

  @computed
  bool get isMarketConnected => purchase.market != null;

  @computed
  List<PurchaseItemModel> get filteredItems =>
      showChecked ? checkedItems : items;

  @computed
  int get itemsCount => filteredItems.length;

  @computed
  int get productsCount =>
      checkedItems.length + (showChecked ? 0 : items.length);

  @computed
  bool get isClosed => PurchaseStatusTypes.closed.contains(purchase.status);
}
