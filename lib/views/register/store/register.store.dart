import 'dart:io';
import 'package:emptio/helpers/extensions.dart';
import 'package:mobx/mobx.dart';
part 'register.store.g.dart';

class RegisterStore = _RegisterStoreBase with _$RegisterStore;

abstract class _RegisterStoreBase with Store {
  @observable
  File? photo;

  @observable
  String name = "";

  @observable
  String email = "";

  @observable
  String password = "";

  @observable
  String confirmPassword = "";

  @observable
  bool passwordVisible = false;

  @observable
  bool confirmPasswordVisible = false;

  @action
  void setPhoto(File? _value) => photo = _value;

  @action
  void setName(String _value) => name = _value;

  @action
  void setEmail(String _value) => email = _value;

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
  bool get nameValid => name.isNotEmpty && name.length >= 3;
  String? get nameError =>
      name.isEmpty || nameValid ? null : 'Campo Obrigatório';

  @computed
  bool get emailValid => email.isNotEmpty && email.isEmailValid();
  String? get emailError =>
      email.isEmpty || emailValid ? null : 'Campo Obrigatório';

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
  bool get registerValid =>
      nameValid && emailValid && passwordValid && confirmPasswordValid;
}
