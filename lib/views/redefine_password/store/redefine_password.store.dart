import 'package:emptio/models/auth.model.dart';
import 'package:emptio/repositories/user.repository.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/redefine_password.view-model.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'redefine_password.store.g.dart';

class RedefinePasswordStore = _RedefinePasswordStoreBase
    with _$RedefinePasswordStore;

abstract class _RedefinePasswordStoreBase with Store {
  @observable
  String? code;

  @observable
  String? password;

  @observable
  String? confirmPassword;

  @observable
  bool passwordVisible = false;

  @observable
  bool confirmPasswordVisible = false;

  @observable
  bool loading = false;

  @observable
  bool logged = false;

  @observable
  String error = "";

  @action
  void setCode(String _value) => code = _value;

  @action
  void setPassword(String _value) => password = _value;

  @action
  void setConfirmPassword(String _value) => confirmPassword = _value;

  @action
  void togglePasswordVisible() => passwordVisible = !passwordVisible;

  @action
  void toggleConfirmPasswordVisible() =>
      confirmPasswordVisible = !confirmPasswordVisible;

  @action
  Future<void> redefinePassword(String email) async {
    loading = true;
    error = "";

    RedefinePasswordViewModel model = RedefinePasswordViewModel(
      code: code!,
      email: email,
      password: password!,
    );

    try {
      AuthModel auth = await UserRepository().redefinePassword(model);
      await GetIt.I<AuthStore>().login(auth);
      logged = true;
    } catch (_error) {
      if (_error is String) {
        error = _error;
      }
    }

    loading = false;
  }

  @computed
  bool get codeValid {
    String _code = code ?? "";
    return _code.isNotEmpty && _code.length == 6;
  }

  String? get codeError {
    String _code = code ?? "";

    if (code == null || codeValid) {
      return null;
    } else if (_code.isEmpty) {
      return "Campo obrigatório!";
    }

    return "Código inválido!";
  }

  @computed
  bool get passwordValid {
    String _password = password ?? "";

    return _password.isNotEmpty && _password.length >= 6;
  }

  @computed
  String? get passwordError {
    String _password = password ?? "";
    if (password == null || passwordValid) {
      return null;
    } else if (_password.isEmpty) {
      return "Campo obrigatório!";
    }

    return "Senha muito curta!";
  }

  @computed
  bool get confirmPasswordValid {
    String _confirmPassword = confirmPassword ?? "";

    return _confirmPassword.isNotEmpty &&
        passwordValid &&
        confirmPassword == password;
  }

  @computed
  String? get confirmPasswordError {
    //confirmPassword.isEmpty || confirmPasswordValid ? null : 'Campo Obrigatório';
    String _confirmPassword = confirmPassword ?? "";

    if (confirmPassword == null || confirmPasswordValid) {
      return null;
    } else if (_confirmPassword.isEmpty) {
      return "Campo obrigatório!";
    }

    return "As senhas não coincidem!";
  }

  @computed
  bool get redefinePasswordValid =>
      !loading && codeValid && passwordValid && confirmPasswordValid;
}
