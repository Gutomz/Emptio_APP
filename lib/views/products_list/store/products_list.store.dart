import 'package:emptio/models/product.model.dart';
import 'package:emptio/repositories/product.repository.dart';
import 'package:emptio/view-models/product_filter.view-model.dart';
import 'package:mobx/mobx.dart';
part 'products_list.store.g.dart';

class ProductsListStore = _ProductsListStoreBase with _$ProductsListStore;

abstract class _ProductsListStoreBase with Store {
  _ProductsListStoreBase() {
    autorun((_) async {
      setLoading(true);

      final filter = ProductFilterViewModel(
        search: search,
        skip: skip,
      );

      await load(filter);
      setLoading(false);
    });
  }

  ObservableList<ProductModel> list = ObservableList();

  @observable
  String search = "";

  @observable
  int skip = 0;

  @observable
  bool reachedEnd = false;

  @observable
  bool loading = false;

  @observable
  String error = "";

  @action
  // ignore: avoid_positional_boolean_parameters
  void setLoading(bool _value) => loading = _value;

  @action
  void setSearch(String _value) => search = _value;

  @action
  Future<void> load(ProductFilterViewModel filter) async {
    try {
      final data = await ProductRepository().get(filter);

      if (filter.skip == 0) {
        list.clear();
      }

      if (data.length < filter.limit) {
        reachedEnd = true;
      }

      error = "";
      list.addAll(data);
    } on String catch (_error) {
      error = _error;
    }
  }

  @action
  void loadNextPage() {
    skip = list.length;
  }

  @action
  Future<void> reset() async {
    list.clear();
    skip = 0;
    reachedEnd = false;
  }

  @action
  Future<void> deleteProduct(String sId) async {
    try {
      list.removeWhere((element) => element.sId.contains(sId));
      await ProductRepository().delete(sId);
    } on String catch (_error) {
      error = _error;
    }
  }

  @action
  Future<void> getById(String sId) async {
    try {
      final index = list.indexWhere((element) => element.sId.contains(sId));
      final data = await ProductRepository().getById(sId);
      list[index] = data;
    } on String catch (_error) {
      error = _error;
    }
  }

  @computed
  bool get hasError => error.isNotEmpty;

  @computed
  int get listCount => reachedEnd ? list.length : list.length + 1;

  @computed
  bool get firstLoading => loading && list.isEmpty;
}
