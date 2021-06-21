import 'package:emptio/view-models/update_purchase_item.view-model.dart';
import 'package:emptio/views/purchase_details/store/purchase_details.store.dart';
import 'package:mobx/mobx.dart';
part 'purchase_item.store.g.dart';

class PurchaseItemStore = _PurchaseItemStoreBase with _$PurchaseItemStore;

abstract class _PurchaseItemStoreBase with Store {
  final PurchaseDetailsStore purchaseStore;
  final String itemId;

  _PurchaseItemStoreBase({
    required this.purchaseStore,
    required this.itemId,
    required this.price,
    required this.quantity,
    required this.checked,
  });

  @observable
  double price = 0;

  @observable
  int quantity = 1;

  @observable
  bool checked = false;

  @action
  Future<void> updateItem({bool shoulRefresh = false}) async {
    purchaseStore.updateItem(
      itemId,
      UpdatePurchaseItemViewModel(
        price: price,
        quantity: quantity,
        checked: checked,
      ),
      shouldRefresh: shoulRefresh,
    );
  }

  @action
  Future<void> deleteItem() async {
    await purchaseStore.deleteItem(itemId);
  }

  @action
  void toggleChecked() {
    checked = !checked;
    updateItem(shoulRefresh: true);
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
  void setItem(UpdatePurchaseItemViewModel model) {
    price = model.price;
    quantity = model.quantity;
    checked = model.checked;
    updateItem(shoulRefresh: true);
  }

  @computed
  double get totalPrice => price * quantity;

  @computed
  bool get quantityMinLimit => quantity == 1;

  @computed
  bool get quantityMaxLimit => quantity == 999;
}
