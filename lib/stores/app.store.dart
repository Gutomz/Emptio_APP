import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/views/purchase_details/store/purchase_details.store.dart';
import 'package:emptio/views/purchases/store/purchases.store.dart';
import 'package:mobx/mobx.dart';
part 'app.store.g.dart';

class AppStore = _AppStoreBase with _$AppStore;

abstract class _AppStoreBase with Store {
  PurchasesStore openPurchasesStore = PurchasesStore();

  PurchasesStore closedPurchasesStore =
      PurchasesStore(status: PurchaseStatusTypes.CLOSED);

  PurchaseDetailsStore purchaseDetailsStore = PurchaseDetailsStore();

  @action
  void dismissPurchaseDetails() {
    print('dismiss purchase details');
    purchaseDetailsStore.clear();
    openPurchasesStore.resetPage();
    closedPurchasesStore.resetPage();
  }
}
