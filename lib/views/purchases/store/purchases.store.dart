import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'purchases.store.g.dart';

class PurchasesStore = _PurchasesStoreBase with _$PurchasesStore;

abstract class _PurchasesStoreBase with Store {
  final AuthStore _authStore = GetIt.I<AuthStore>();

  _PurchasesStoreBase({
    bool shouldAutoRun = true,
    this.status = PurchaseStatusTypes.OPEN,
  }) {
    if (shouldAutoRun) {
      autorun((_) async {
        loadPurchases();
      });

      reaction((_) => _authStore.isLogged, (logged) async {
        loadPurchases();
      });
    }
  }

  ObservableList<PurchaseModel> purchaseList = ObservableList<PurchaseModel>();

  @observable
  String status;

  @observable
  String search = "";

  @observable
  int page = 0;

  @observable
  bool loading = false;

  @observable
  String error = "";

  @action
  void setStatus(String _value) {
    status = _value;
    resetPage();
  }

  @action
  void setSearch(String _value) {
    search = _value;
    resetPage();
  }

  @action
  Future loadPurchases() async {
    loading = true;

    print('get purchases');
    await Future.delayed(Duration(seconds: 5));

    loading = false;
  }

  @action
  void loadNextPage() {
    page++;
  }

  @action
  void resetPage() {
    page = 0;
    purchaseList.clear();
  }
}
