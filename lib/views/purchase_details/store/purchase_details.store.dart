import 'package:emptio/models/market.model.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:mobx/mobx.dart';
part 'purchase_details.store.g.dart';

class PurchaseDetailsStore = _PurchaseDetailsStoreBase
    with _$PurchaseDetailsStore;

abstract class _PurchaseDetailsStoreBase with Store {
  @observable
  PurchaseModel? purchase;

  @action
  void setPurchase(PurchaseModel _value) => purchase = _value;

  @action
  void clear() {
    purchase = null;
  }

  @computed
  bool get isMarketConnected => purchase != null && purchase!.market != null;
}
