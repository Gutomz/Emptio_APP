import 'package:mobx/mobx.dart';
import 'package:emptio/helpers/extensions.dart';
part 'login.store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  bool visible = false;

  @action
  void setEmail(String _value) => email = _value;

  @action
  void setPassword(String _value) => password = _value;

  @action
  void toggleVisible() => visible = !visible;

  @action
  void login() {

  }

  @computed
  bool get emailValid => email.isNotEmpty && email.isEmailValid();
  String? get emailError =>
      email.isEmpty || emailValid ? null : 'E-mail inválido';

  @computed
  bool get passwordValid => password.isNotEmpty && password.length >= 6;
  String? get passwordError =>
      password.isEmpty || passwordValid ? null : 'Senha inválida';

  @computed
  bool get loginValid => emailValid && passwordValid;
}
