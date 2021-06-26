import 'package:emptio/view-models/update_base_purchase_item.view-model.dart';
import 'package:emptio/views/base_purchase_details/store/base_purchase_details.store.dart';
import 'package:mobx/mobx.dart';
part 'base_purchase_item.store.g.dart';

class BasePurchaseItemStore = _BasePurchaseItemStoreBase
    with _$BasePurchaseItemStore;

abstract class _BasePurchaseItemStoreBase with Store {
  final BasePurchaseDetailsStore purchaseStore;
  final String itemId;

  _BasePurchaseItemStoreBase({
    required this.purchaseStore,
    required this.itemId,
    required this.quantity,
  });

  @observable
  int quantity = 1;

  @action
  Future<void> updateItem() async {
    purchaseStore.updateItem(
      itemId,
      UpdateBasePurchaseItemViewModel(quantity: quantity),
    );
  }

  @action
  Future<void> deleteItem() async {
    await purchaseStore.deleteItem(itemId);
  }

  @action
  void incrementQuantity() {
    if (quantity + 1 > 999) return;

    quantity += 1;
    updateItem();
  }

  @action
  void decrementQuantity() {
    if (quantity - 1 < 1) return;

    quantity -= 1;
    updateItem();
  }

  @action
  void setItem(UpdateBasePurchaseItemViewModel model) {
    quantity = model.quantity;
    updateItem();
  }

  @computed
  bool get quantityMinLimit => quantity == 1;

  @computed
  bool get quantityMaxLimit => quantity == 999;
}
