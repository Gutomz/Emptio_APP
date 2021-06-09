import 'package:emptio/models/auth.model.dart';
import 'package:emptio/repositories/user.repository.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/login.view-model.dart';
import 'package:get_it/get_it.dart';
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

  @observable
  bool loginLoading = false;

  @observable
  bool forgotPasswordLoading = false;

  @observable
  String error = "";

  @observable
  bool logged = false;

  @observable
  bool emailSent = false;

  @action
  void setEmail(String _value) => email = _value;

  @action
  void setPassword(String _value) => password = _value;

  @action
  void toggleVisible() => visible = !visible;

  @action
  Future<void> login() async {
    loginLoading = true;
    error = "";

    final model = LoginViewModel(email: email!, password: password!);

    try {
      AuthModel auth = await UserRepository().login(model);
      await GetIt.I<AuthStore>().login(auth);
      logged = true;
    } catch (_error) {
      if (_error is String) {
        error = _error;
      }
    }

    loginLoading = false;
  }

  @action
  Future<void> forgotPassword() async {
    forgotPasswordLoading = true;
    error = "";
    emailSent = false;

    try {
      await UserRepository().forgotPassword(email!);
      emailSent = true;
    } catch (_error) {
      if (_error is String) {
        error = _error;
      }
    }

    forgotPasswordLoading = false;
  }

  @computed
  bool get emailValid {
    String _email = email ?? "";
    return _email.isNotEmpty && _email.isEmailValid();
  }

  @computed
  String? get emailError {
    String _email = email ?? "";

    if (email == null || emailValid) {
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

    if (password == null || _password.isNotEmpty || passwordValid) {
      return null;
    }

    return "Campo obrigatório!";
  }

  @computed
  bool get loginValid => !loading && emailValid && passwordValid;

  @computed
  bool get forgotPaswordValid => !loading && emailValid;

  @computed
  bool get loading => loginLoading || forgotPasswordLoading;
}
