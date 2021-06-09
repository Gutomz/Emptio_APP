import 'dart:convert';

import 'package:emptio/models/auth.model.dart';
import 'package:emptio/models/user.model.dart';
import 'package:emptio/repositories/user.repository.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth.store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final String _authKey = "auth_key";

  @observable
  AuthModel? auth;

  @observable
  UserModel? user;

  @action
  Future login(AuthModel authModel) async {
    auth = authModel;
    user = await UserRepository().getMe();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authKey, jsonEncode(authModel.toJson()));
  }

  @action
  Future logout() async {
    await UserRepository().logout();

    auth = null;
    user = null;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authKey);
  }

  @action
  Future<bool> initAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? authString = prefs.getString(_authKey);
    if (authString != null) {
      AuthModel authModel = AuthModel.fromJson(jsonDecode(authString));
      await login(authModel);

      return Future.value(true);
    }

    return Future.value(false);
  }

  @computed
  bool get isLogged => auth != null && user != null;
}
