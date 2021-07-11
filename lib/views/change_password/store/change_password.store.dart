import 'package:emptio/repositories/user.repository.dart';
import 'package:emptio/view-models/change_password.view-model.dart';
import 'package:mobx/mobx.dart';
part 'change_password.store.g.dart';

class ChangePasswordStore = _ChangePasswordStoreBase with _$ChangePasswordStore;

abstract class _ChangePasswordStoreBase with Store {
  @observable
  String? actualPassword;

  @observable
  String? newPassword;

  @observable
  String? confirmNewPassword;

  @observable
  bool loading = false;

  @observable
  String error = "";

  @action
  void setActualPassword(String _value) => actualPassword = _value;

  @action
  void setNewPassword(String _value) => newPassword = _value;

  @action
  void setConfirmNewPassword(String _value) => confirmNewPassword = _value;

  @action
  Future<bool> changePassword() async {
    loading = true;
    error = "";

    final model = ChangePasswordViewModel(
      actualPassword: actualPassword!,
      newPassword: newPassword!,
    );

    try {
      await UserRepository().changePassword(model);
      return true;
    } on String catch (_error) {
      error = _error;
      return false;
    } finally {
      loading = false;
    }
  }

  @computed
  bool get actualPasswordValid {
    final _password = actualPassword ?? "";
    return _password.isNotEmpty && _password.length >= 6;
  }

  @computed
  String? get actualPasswordError {
    final _password = actualPassword ?? "";
    if (actualPassword == null || actualPasswordValid) {
      return null;
    } else if (_password.isEmpty) {
      return "Campo obrigatório!";
    }

    return "Senha muito curta!";
  }

  @computed
  bool get newPasswordValid {
    final _password = newPassword ?? "";
    return _password.isNotEmpty && _password.length >= 6;
  }

  @computed
  String? get newPasswordError {
    final _password = newPassword ?? "";
    if (newPassword == null || newPasswordValid) {
      return null;
    } else if (_password.isEmpty) {
      return "Campo obrigatório!";
    }

    return "Senha muito curta!";
  }

  @computed
  bool get confirmNewPasswordValid {
    final _password = confirmNewPassword ?? "";
    return _password.isNotEmpty && newPasswordValid && _password == newPassword;
  }

  @computed
  String? get confirmNewPasswordError {
    final _password = confirmNewPassword ?? "";
    if (confirmNewPassword == null || confirmNewPasswordValid) {
      return null;
    } else if (_password.isEmpty) {
      return "Campo obrigatório!";
    }

    return "As senhas não coincidem!";
  }

  @computed
  bool get hasError => error.isNotEmpty;

  @computed
  bool get isFormValid =>
      actualPasswordValid && newPasswordValid && confirmNewPasswordValid;
}
