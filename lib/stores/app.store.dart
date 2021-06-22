import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/views/base_purchases/store/base_purchases.store.dart';
import 'package:emptio/views/home/store/home.store.dart';
import 'package:emptio/views/purchases/store/purchases.store.dart';
import 'package:mobx/mobx.dart';

class AppStore with Store {
  HomeStore homeStore = HomeStore();

  PurchasesStore openPurchasesStore = PurchasesStore();

  PurchasesStore closedPurchasesStore =
      PurchasesStore(status: PurchaseStatusTypes.CLOSED);

  BasePurchasesStore basePurchasesStore = BasePurchasesStore();
}
