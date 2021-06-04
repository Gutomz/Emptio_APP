import 'package:mobx/mobx.dart';
import 'package:emptio/helpers/extensions.dart';
part 'login.store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  @observable
  String? email;

  @observable
  String? password;

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
    print('login');
  }

  @computed
  bool get emailValid {
    String _email = email ?? "";
    return _email.isNotEmpty && _email.isEmailValid();
  }

  @computed
  String? get emailError {
    String _email = email ?? "";

    if(email == null || emailValid) {
      return null;
    } else if (_email.isEmpty) {
      return "Campo obrigatório!";
    }

    return "E-mail inválido";
  }
      
  @computed
  bool get passwordValid {
    String _password = password ?? "";
    return _password.isNotEmpty && _password.length >= 6;
  }

  @computed
  String? get passwordError {
    String _password = password ?? "";

    if(password == null || _password.isNotEmpty || passwordValid){
      return null;
    }

    return "Campo obrigatório!";
  }

  @computed
  bool get loginValid => emailValid && passwordValid;
}
