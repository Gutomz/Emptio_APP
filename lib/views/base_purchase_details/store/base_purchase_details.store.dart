import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/models/base_purchase_item.model.dart';
import 'package:emptio/repositories/base_purchase.repository.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/view-models/add_base_purchase_item.view-model.dart';
import 'package:emptio/view-models/update_base_purchase_item.view-model.dart';
import 'package:emptio/views/base_purchases/store/base_purchases.store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'base_purchase_details.store.g.dart';

class BasePurchaseDetailsStore = _BasePurchaseDetailsStoreBase
    with _$BasePurchaseDetailsStore;

abstract class _BasePurchaseDetailsStoreBase with Store {
  final BasePurchasesStore _purchasesStore =
      GetIt.I<AppStore>().basePurchasesStore;

  _BasePurchaseDetailsStoreBase({
    required this.purchase,
    required this.items,
  });

  BasePurchaseModel purchase;

  ObservableList<BasePurchaseItemModel> items;

  @observable
  bool loading = false;

  @observable
  String error = "";

  @action
  Future<void> addItem(AddBasePurchaseItemViewModel model) async {
    loading = true;
    error = "";

    try {
      BasePurchaseModel _purchase =
          await BasePurchaseRepository().addItem(purchase.sId, model);

      updatePurchase(_purchase);
    } on String catch (_error) {
      error = _error;
    }

    loading = false;
  }

  @action
  Future<void> updateItem(
      String itemId, UpdateBasePurchaseItemViewModel model) async {
    loading = true;
    error = "";

    try {
      BasePurchaseModel _purchase =
          await BasePurchaseRepository().updateItem(purchase.sId, itemId, model);

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
      BasePurchaseModel _purchase =
          await BasePurchaseRepository().removeItem(purchase.sId, itemId);

      updatePurchase(_purchase);
    } on String catch (_error) {
      error = _error;
    }

    loading = false;
  }

  @action
  void updateItems(List<BasePurchaseItemModel> models) {
    items.clear();
    items.addAll(models);
  }

  @action
  void updatePurchase(BasePurchaseModel model) {
    purchase = model;
    updateItems(model.items);
    _purchasesStore.updatePurchase(model);
  }

  @computed
  List<BasePurchaseItemModel> get filtredItems => items;

  @computed
  int get itemsCount => filtredItems.length;
}
