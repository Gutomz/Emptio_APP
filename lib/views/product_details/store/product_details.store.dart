import 'package:emptio/models/product.model.dart';
import 'package:mobx/mobx.dart';
part 'product_details.store.g.dart';

class ProductDetailsStore = _ProductDetailsStoreBase with _$ProductDetailsStore;

abstract class _ProductDetailsStoreBase with Store {
  _ProductDetailsStoreBase(this.product);

  @observable
  ProductModel product;

  @observable
  bool loading = false;
}
