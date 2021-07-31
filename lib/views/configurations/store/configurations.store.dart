import 'package:emptio/repositories/user.repository.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'configurations.store.g.dart';

class ConfigurationsStore = _ConfigurationsStoreBase with _$ConfigurationsStore;

abstract class _ConfigurationsStoreBase with Store {
  final AuthStore _authStore = GetIt.I<AuthStore>();

  _ConfigurationsStoreBase() {
    if (_authStore.offlineLogged) {
      canNotify = _authStore.user!.configurations.canNotify;
    }
    offlineMode = _authStore.offlineMode;
  }

  @observable
  bool offlineMode = false;

  @observable
  bool canNotify = false;

  @observable
  String error = "";

  @action
  // ignore: avoid_positional_boolean_parameters
  Future<void> triggerCanNotify(bool value) async {
    try {
      canNotify = value;
      await UserRepository().updateCanNotify(value);
      error = "";
    } on String catch (_error) {
      error = _error;
      canNotify = !value;
    }
  }

  @action
  // ignore: avoid_positional_boolean_parameters
  Future<void> triggerOfflineMode(bool value) async {
    try {
      offlineMode = value;
      await _authStore.triggerOfflineMode(value);
      error = "";
    } on String catch (_error) {
      error = _error;
      offlineMode = !value;
    }
  }

  @computed
  bool get isLogged => _authStore.isLogged;
}
