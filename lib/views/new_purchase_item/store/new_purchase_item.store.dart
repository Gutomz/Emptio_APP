import 'package:emptio/models/measurement.model.dart';
import 'package:emptio/view-models/add_purchase_item.view-model.dart';
import 'package:emptio/view-models/product_create.view-model.dart';
import 'package:mobx/mobx.dart';
part 'new_purchase_item.store.g.dart';

class NewPurchaseItemStore = _NewPurchaseItemStoreBase
    with _$NewPurchaseItemStore;

abstract class _NewPurchaseItemStoreBase with Store {
  @observable
  String? name;

  @observable
  String variation = "";

  @observable
  double weightValue = 0;

  @observable
  String weightUnit = MeasurementTypes.g;

  @observable
  double price = 0;

  ObservableList<String> tags = ObservableList();

  @observable
  int quantity = 1;

  @action
  void setName(String _value) => name = _value;

  @action
  void setVariation(String _value) => variation = _value;

  @action
  void setWeightValue(double _value) => weightValue = _value;

  @action
  void setWeightUnit(String _value) => weightUnit = _value;

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

  @action
  void addTag(String tag) => tags.add(tag);

  @action
  void removeTag(String tag) => tags.removeWhere((element) => element == tag);

  @action
  AddPurchaseItemViewModel getModel() {
    return AddPurchaseItemViewModel(
      price: price,
      quantity: quantity,
      productModel: ProductCreateViewModel(
        name: name!,
        variation: variation,
        weight: MeasurementModel(
          value: weightValue,
          unit: weightUnit,
        ),
        tags: tags,
      ),
    );
  }

  @computed
  bool get nameValid {
    String _name = name ?? "";
    return _name.isNotEmpty && _name.length > 1;
  }

  @computed
  String? get nameError {
    String _name = name ?? "";

    if (name == null || nameValid) {
      return null;
    } else if (_name.isEmpty) {
      return "Campo obrigatório!";
    }

    return "Nome muito curto";
  }

  @computed
  bool get minQuantityReached => quantity == 1;

  @computed
  bool get maxQuantityReached => quantity == 999;

  @computed
  double get total => price * quantity;

  @computed
  bool get formValid => nameValid;
}
