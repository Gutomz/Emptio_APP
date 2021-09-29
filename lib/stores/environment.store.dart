import 'package:mobx/mobx.dart';
part 'environment.store.g.dart';

class EnvironmentStore = _EnvironmentStoreBase with _$EnvironmentStore;

abstract class _EnvironmentStoreBase with Store {
  @observable
  String apiUrl = "";

  @observable
  String googlePlacesKey = "";

  @action
  void setApiUrl(String _value) => apiUrl = _value;

  @action
  void setGooglePlacesKey(String _value) => googlePlacesKey = _value;
}
