import 'package:emptio/view-models/update_base_purchase_item.view-model.dart';
import 'package:emptio/view-models/update_purchase_item.view-model.dart';
import 'package:mobx/mobx.dart';
part 'edit_purchase_item.store.g.dart';

class EditPurchaseItemStore = _EditPurchaseItemStoreBase
    with _$EditPurchaseItemStore;

abstract class _EditPurchaseItemStoreBase with Store {
  _EditPurchaseItemStoreBase({
    required this.price,
    required this.quantity,
    required this.checked,
  });

  @observable
  double price;

  @observable
  int quantity;

  @observable
  bool checked;

  @action
  void setPrice(double _value) => price = _value;

  @action
  void incrementQuantity() {
    if (quantity + 1 <= 999) quantity += 1;
  }

  @action
  void decrementQuantity() {
    if (quantity - 1 >= 1) quantity -= 1;
  }

  @computed
  UpdatePurchaseItemViewModel get itemModel => UpdatePurchaseItemViewModel(
      price: price, quantity: quantity, checked: checked);

  @computed
  UpdateBasePurchaseItemViewModel get itemBaseModel =>
      UpdateBasePurchaseItemViewModel(quantity: quantity);

  @computed
  double get total => price * quantity;

  @computed
  bool get minQuantityReached => quantity == 1;
  bool get maxQuantityReached => quantity == 999;
}
