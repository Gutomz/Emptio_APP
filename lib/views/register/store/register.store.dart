import 'dart:io';
import 'package:emptio/helpers/extensions.dart';
import 'package:emptio/models/auth.model.dart';
import 'package:emptio/repositories/user.repository.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/register.view-model.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:mobx/mobx.dart';
part 'register.store.g.dart';

class RegisterStore = _RegisterStoreBase with _$RegisterStore;

abstract class _RegisterStoreBase with Store {
  @observable
  File? photo;

  @observable
  String? name;

  @observable
  String? email;

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
  String error = "";

  @observable
  bool logged = false;

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

  @action
  Future<void> register() async {
    loading = true;
    error = "";

    File? _photo = photo;

    Location location = Location();
    LocationData userLocation = await location.getLocation();

    RegisterViewModel userModel = RegisterViewModel(
      name: name!,
      email: email!,
      password: password!,
      photo: _photo != null ? _photo.parseToBase64() : "",
      location: '${userLocation.latitude},${userLocation.longitude}',
    );

    try {
      AuthModel auth = await UserRepository().register(userModel);
      GetIt.I<AuthStore>().setAuth(auth);
      logged = true;
    } catch (_error) {
      if (_error is String) {
        error = _error;
      }
    }

    loading = false;
  }

  @computed
  bool get nameValid {
    String _name = name ?? "";

    return _name.isNotEmpty && _name.length >= 3;
  }

  @computed
  String? get nameError {
    String _name = name ?? "";

    if (name == null || nameValid) {
      return null;
    } else if (_name.isEmpty) {
      return "Campo obrigatório!";
    }

    return "Nome muito curto";
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
      return 'Campo obrigatório!';
    }

    return "E-mail inválido!";
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
    String _confirmPassword = confirmPassword ?? "";

    if (confirmPassword == null || confirmPasswordValid) {
      return null;
    } else if (_confirmPassword.isEmpty) {
      return "Campo obrigatório!";
    }

    return "As senhas não coincidem!";
  }

  @computed
  bool get isFormValid =>
      !loading &&
      nameValid &&
      emailValid &&
      passwordValid &&
      confirmPasswordValid;
}
