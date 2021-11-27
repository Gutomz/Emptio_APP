import 'package:mobx/mobx.dart';
part 'environment.store.g.dart';

class EnvironmentStore = _EnvironmentStoreBase with _$EnvironmentStore;

abstract class _EnvironmentStoreBase with Store {
  @observable
  String apiUrl = "";

  @observable
  String googlePlacesKey = "";

  @observable
  String entryTitle = "";

  @observable
  String entryDescription = "";

  @action
  void setApiUrl(String _value) => apiUrl = _value;

  @action
  void setGooglePlacesKey(String _value) => googlePlacesKey = _value;

  @action
  void setEntryTitle(String _value) => entryTitle = _value;

  @action
  void setEntryDescription(String _value) => entryDescription = _value;
}
