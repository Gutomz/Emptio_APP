import 'package:emptio/models/product.model.dart';
import 'package:emptio/repositories/product.repository.dart';
import 'package:emptio/view-models/product_filter.view-model.dart';
import 'package:mobx/mobx.dart';
part 'product_search.store.g.dart';

class ProductSearchStore = _ProductSearchStoreBase with _$ProductSearchStore;

abstract class _ProductSearchStoreBase with Store {
  int limit;

  _ProductSearchStoreBase({
    String purchaseId = "",
    String basePurchaseId = "",
    this.limit = 10,
  }) {
    autorun((_) async {
      if (query.isNotEmpty) {
        setLoading(true);
        ProductFilterViewModel filter = ProductFilterViewModel(
          search: query,
          limit: limit,
          skip: skip,
          purchaseId: purchaseId,
          basePurchaseId: basePurchaseId,
        );

        await loadProducts(filter);
        setLoading(false);
      }
    });
  }

  @observable
  String query = "";

  @observable
  int skip = 0;

  @observable
  bool loading = false;

  @observable
  String error = "";

  @observable
  bool limitReached = false;

  ObservableList<ProductModel> productsList = ObservableList<ProductModel>();

  @action
  void setLoading(bool _value) => loading = _value;

  @action
  void setError(String _value) => error = _value;

  @action
  void setQuery(String _value) => query = _value;

  @action
  Future<void> loadProducts(ProductFilterViewModel filter) async {
    try {
      List<ProductModel> list = await ProductRepository().get(filter);

      if (list.length < filter.limit) limitReached = true;

      if (filter.skip == 0) {
        productsList.clear();
      }

      productsList.addAll(list);
      setError("");
    } on String catch (_error) {
      setError(_error);
    }
  }

  @action
  void removeProduct(String productId) {
    productsList.removeWhere((element) => element.sId == productId);
    final newList = productsList.toList();
    productsList = ObservableList()..addAll(newList);
  }

  @action
  void resetPage(String _query) {
    productsList.clear();
    limitReached = false;
    query = _query;
    skip = 0;
  }

  @action
  void loadNextPage() {
    skip = productsList.length;
  }

  @computed
  int get itemCount =>
      limitReached ? productsList.length : productsList.length + 1;

  @computed
  bool get firstLoading => loading && productsList.isEmpty;
}
