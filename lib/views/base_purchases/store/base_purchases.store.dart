import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/repositories/base_purchase.repository.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/base_purchase_filter.view-model.dart';
import 'package:emptio/view-models/create_purchase.view-model.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'base_purchases.store.g.dart';

class BasePurchasesStore = _BasePurchasesStoreBase with _$BasePurchasesStore;

abstract class _BasePurchasesStoreBase with Store {
  final AuthStore _authStore = GetIt.I<AuthStore>();
  final int limit;

  _BasePurchasesStoreBase({
    this.limit = 10,
  }) {
    autorun((_) async {
      setLoading(true);
      BasePurchasesFilterViewModel filter = BasePurchasesFilterViewModel(
        search: search,
        limit: limit,
        skip: skip,
      );

      await loadPurchases(filter);
      setLoading(false);
    });

    reaction((_) => _authStore.isLogged, (logged) {
      resetPage();
    });
  }

  ObservableList<BasePurchaseModel> purchaseList =
      ObservableList<BasePurchaseModel>();

  @observable
  String search = "";

  @observable
  int skip = 0;

  @observable
  bool loading = false;

  @observable
  String loadingTile = "";

  @observable
  String error = "";

  @observable
  bool limitReached = false;

  @action
  void setSearch(String _value) {
    search = _value;
    resetPage();
  }

  @action
  void setLoading(bool _value) => loading = _value;

  @action
  void setError(String _value) => error = _value;

  @action
  Future loadPurchases(BasePurchasesFilterViewModel filter) async {
    try {
      List<BasePurchaseModel> list = await BasePurchaseRepository().get(filter);

      if (list.length < filter.limit) limitReached = true;

      if (filter.skip == 0) {
        purchaseList.clear();
      }

      purchaseList.addAll(list);
      setError("");
    } on String catch (_error) {
      error = _error;
    }
  }

  @action
  Future<BasePurchaseModel?> createPurchase() async {
    loading = true;
    error = "";

    try {
      BasePurchaseModel model = await BasePurchaseRepository().create();
      purchaseList.insert(0, model);
      return model;
    } on String catch (_error) {
      error = _error;
    }

    loading = false;
  }

  @action
  Future<void> deletePurchase(int index) async {
    loading = true;
    error = "";

    BasePurchaseModel model = purchaseList[index];
    removeIndex(index);
    try {
      await BasePurchaseRepository().delete(model.sId);
    } on String catch (_error) {
      error = _error;
    }

    loading = false;
  }

  @action
  Future<PurchaseModel?> createPurchaseWithBaseModel(
      BasePurchaseModel baseModel) async {
    loadingTile = baseModel.sId;
    error = "";
    var purchasesStore = GetIt.I<AppStore>().openPurchasesStore;

    try {
      CreatePurchaseViewModel createModel =
          CreatePurchaseViewModel(basePurchaseId: baseModel.sId);
      PurchaseModel? model = await purchasesStore.createPurchase(createModel);
      return model;
    } on String catch (_error) {
      error = _error;
    } finally {
      loadingTile = "";
    }
  }

  @action
  void updatePurchase(BasePurchaseModel model) {
    int index = purchaseList.indexWhere((element) => element.sId == model.sId);
    purchaseList[index] = model;
  }

  @action
  void removeIndex(int index) {
    purchaseList.removeAt(index);
  }

  @action
  void loadNextPage() {
    skip = purchaseList.length;
  }

  @action
  Future<void> resetPage() async {
    skip = 0;
    purchaseList.clear();
    limitReached = false;
    await Future.delayed(Duration(seconds: 2));
  }

  @computed
  int get itemCount =>
      limitReached ? purchaseList.length : purchaseList.length + 1;

  @computed
  bool get firstLoading => loading && purchaseList.isEmpty;

  @computed
  bool get isLoadingTile => loadingTile.isNotEmpty;
}
