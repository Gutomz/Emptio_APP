import 'package:emptio/models/market.model.dart';
import 'package:emptio/repositories/market.repository.dart';
import 'package:mobx/mobx.dart';
part 'market_details.store.g.dart';

class MarketDetailsStore = _MarketDetailsStoreBase with _$MarketDetailsStore;

abstract class _MarketDetailsStoreBase with Store {
  final String sId;

  _MarketDetailsStoreBase({required this.sId}) {
    autorun((_) {
      load();
    });
  }

  @observable
  MarketModel? market;

  @observable
  bool loading = false;

  @observable
  String error = "";

  @action
  // ignore: avoid_positional_boolean_parameters
  void setLoading(bool _value) => loading = _value;

  @action
  void setError(String _value) => error = _value;

  @action
  Future<void> load() async {
    setLoading(true);
    try {
      market = await MarketRepository().getDetails(sId);
      setError("");
    } on String catch (_error) {
      setError(_error);
    } finally {
      setLoading(false);
    }
  }

  @computed
  bool get hasError => error.isNotEmpty;

  @computed
  bool get marketLoaded => market != null;
}
