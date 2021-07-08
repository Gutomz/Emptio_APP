import 'dart:convert';

import 'package:emptio/models/auth.model.dart';
import 'package:emptio/models/user.model.dart';
import 'package:emptio/repositories/user.repository.dart';
import 'package:emptio/stores/connectivity.store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth.store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final ConnectivityStore _connectivityStore = GetIt.I<ConnectivityStore>();
  final String _authKey = "auth_key";
  final String _keepLoggedOutKey = "keepLoggedOut_key";

  @observable
  AuthModel? auth;

  @observable
  UserModel? user;

  @observable
  bool loading = false;

  @observable
  bool isActive = false;

  @observable
  bool keepLoggedOut = false;

  @action
  Future login(AuthModel authModel) async {
    loading = true;
    auth = authModel;

    if (_connectivityStore.isConnected) {
      try {
        user = await UserRepository().getMe();

        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setString(
            _authKey, jsonEncode(authModel.toJson()));
      } catch (error) {
        auth = null;
      }
    }

    loading = false;
  }

  @action
  Future logout() async {
    loading = true;

    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.remove(_authKey);

      await UserRepository().logout();
    } catch (_) {/* do nothing */} finally {
      user = null;
      auth = null;
    }

    loading = false;
  }

  @action
  Future<bool> initAuthenticated() async {
    loading = true;

    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      final bool? _keepLoggedOut = sharedPreferences.getBool(_keepLoggedOutKey);
      if (_keepLoggedOut != null) {
        keepLoggedOut = _keepLoggedOut;
      }

      final String? authString = sharedPreferences.getString(_authKey);
      if (authString != null) {
        final AuthModel authModel =
            AuthModel.fromJson(jsonDecode(authString) as Map<String, dynamic>);
        await login(authModel);

        return Future.value(true);
      }

      return Future.value(false);
    } catch (error) {
      return Future.value(false);
    } finally {
      loading = false;
      isActive = true;
    }
  }

  @action
  Future<void> setKeepLoggedOut() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    sharedPreferences.setBool(_keepLoggedOutKey, true);
    keepLoggedOut = true;
  }

  @computed
  bool get isLogged =>
      _connectivityStore.isConnected && auth != null && user != null;

  @computed
  bool get offlineLogged => auth != null && user != null;
}
