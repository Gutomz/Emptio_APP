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
  final String _keepLoggedOuthKey = "keepLoggedOut_key";

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

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(_authKey, jsonEncode(authModel.toJson()));
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_authKey);

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
      SharedPreferences prefs = await SharedPreferences.getInstance();

      bool? _keepLoggedOut = prefs.getBool(_keepLoggedOuthKey);
      if (_keepLoggedOut != null) {
        keepLoggedOut = _keepLoggedOut;
      }

      String? authString = prefs.getString(_authKey);
      if (authString != null) {
        AuthModel authModel = AuthModel.fromJson(jsonDecode(authString));
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
  Future<void> setKeepLoggedOut(bool _value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool(_keepLoggedOuthKey, _value);
    keepLoggedOut = _value;
  }

  @computed
  bool get isLogged =>
      _connectivityStore.isConnected && auth != null && user != null;

  @computed
  bool get offlineLogged => auth != null && user != null;
}
