import 'package:mobx/mobx.dart';
part 'edit_base_purchase_item.store.g.dart';

class EditBasePurchaseItemStore = _EditBasePurchaseItemStoreBase
    with _$EditBasePurchaseItemStore;

abstract class _EditBasePurchaseItemStoreBase with Store {
  _EditBasePurchaseItemStoreBase({required this.quantity});

  @observable
  int quantity;

  @action
  void incrementQuantity() {
    if (quantity + 1 <= 999) quantity += 1;
  }

  @action
  void decrementQuantity() {
    if (quantity - 1 >= 1) quantity -= 1;
  }

  @computed
  bool get minQuantityReached => quantity == 1;
  bool get maxQuantityReached => quantity == 999;
}
