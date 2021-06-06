import 'package:emptio/models/auth.model.dart';
import 'package:mobx/mobx.dart';
part 'auth.store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  @observable
  AuthModel? auth;

  @action
  void setAuth(AuthModel _value) => auth = _value;
}
