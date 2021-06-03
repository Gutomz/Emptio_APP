import 'package:mobx/mobx.dart';
part 'redefine_password.store.g.dart';

class RedefinePasswordStore = _RedefinePasswordStoreBase
    with _$RedefinePasswordStore;

abstract class _RedefinePasswordStoreBase with Store {
  @observable
  String code = "";

  @observable
  String password = "";

  @observable
  String confirmPassword = "";

  @observable
  bool passwordVisible = false;

  @observable
  bool confirmPasswordVisible = false;

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

  @computed
  bool get codeValid => code.isNotEmpty && code.length == 6;
  String? get codeError =>
      code.isEmpty || codeValid ? null : 'Campo Obrigatório';

  @computed
  bool get passwordValid => password.isNotEmpty && password.length >= 6;
  String? get passwordError =>
      password.isEmpty || passwordValid ? null : 'Campo Obrigatório';

  @computed
  bool get confirmPasswordValid => confirmPassword == password;
  String? get confirmPasswordError =>
      confirmPassword.isEmpty || confirmPasswordValid
          ? null
          : 'Campo Obrigatório';

  @computed
  bool get redefinePasswordValid =>
      codeValid && passwordValid && confirmPasswordValid;
}
