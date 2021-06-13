import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/repositories/purchase.repository.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/purchase_filter.view-model.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'purchases.store.g.dart';

class PurchasesStore = _PurchasesStoreBase with _$PurchasesStore;

abstract class _PurchasesStoreBase with Store {
  final AuthStore _authStore = GetIt.I<AuthStore>();
  final int limit;

  _PurchasesStoreBase({
    this.status = PurchaseStatusTypes.OPEN,
    this.limit = 10,
  }) {
    autorun((_) async {
      setLoading(true);
      PurchasesFilterViewModel filter = PurchasesFilterViewModel(
        status: status,
        limit: limit,
        skip: skip,
        orderBy:
            status.contains(PurchaseStatusTypes.CLOSED) ? "updatedAt" : null,
      );

      await loadPurchases(filter);
      setLoading(false);
    });

    reaction((_) => _authStore.isLogged, (logged) {
      resetPage();
    });
  }

  ObservableList<PurchaseModel> purchaseList = ObservableList<PurchaseModel>();

  @observable
  String status;

  @observable
  int skip = 0;

  @observable
  bool loading = false;

  @observable
  String error = "";

  @observable
  bool limitReached = false;

  @action
  void setStatus(String _value) {
    status = _value;
    resetPage();
  }

  @action
  void setLoading(bool _value) => loading = _value;

  @action
  void setError(String _value) => error = _value;

  @action
  Future loadPurchases(PurchasesFilterViewModel filter) async {
    try {
      List<PurchaseModel> list = await PurchaseRepository().get(filter);

      if (list.length < filter.limit) limitReached = true;

      purchaseList.addAll(list);
      setError("");
    } on String catch (_error) {
      error = _error;
    }
  }

  @action
  Future<void> createPurchase() async {
    loading = true;
    error = "";

    try {
      PurchaseModel model = await PurchaseRepository().create();
      purchaseList.insert(0, model);
    } on String catch (_error) {
      error = _error;
    }

    loading = false;
  }

  @action
  Future<void> deletePurchase(int index) async {
    loading = true;
    error = "";

    PurchaseModel model = purchaseList[index];
    removeIndex(index);
    try {
      await PurchaseRepository().delete(model.sId);
    } on String catch (_error) {
      error = _error;
    }

    loading = false;
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
  void resetPage() {
    skip = 0;
    purchaseList.clear();
    limitReached = false;
  }

  @computed
  int get itemCount =>
      limitReached ? purchaseList.length : purchaseList.length + 1;

  @computed
  bool get firstLoading => loading && purchaseList.isEmpty;
}
