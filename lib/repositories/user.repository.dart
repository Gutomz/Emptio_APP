import 'package:emptio/core/app_api-errors.dart';
import 'package:emptio/core/app_api.dart';
import 'package:emptio/core/app_errors.dart';
import 'package:emptio/models/auth.model.dart';
import 'package:emptio/models/user.model.dart';
import 'package:emptio/view-models/login.view-model.dart';
import 'package:emptio/view-models/redefine_password.view-model.dart';
import 'package:emptio/view-models/register.view-model.dart';

class UserRepository {
  static const String TAG = "UserRepository";
  final AppApi _api = AppApi();

  Future<AuthModel> register(RegisterViewModel model) async {
    try {
      dynamic data = await _api.post('/users', body: model.toJson());
      return AuthModel.fromJson(data);
    } catch (error) {
      print('$TAG.register: $error');
      if (AppApiErrors.isError(error)) {
        String code = AppApiErrors.getCode(error);

        if (code.isNotEmpty) {
          if (code.contains(AppErrors.UNIQUE_FIELD)) {
            return Future.error("E-mail já cadastrado!");
          }
        }
      }

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<AuthModel> login(LoginViewModel model) async {
    try {
      dynamic data = await _api.post('/auth', body: model.toJson());
      return AuthModel.fromJson(data);
    } catch (error) {
      print('$TAG.login: $error');

      if (AppApiErrors.isError(error)) {
        String code = AppApiErrors.getCode(error);

        if (code.contains(AppErrors.USER_NOT_FOUND) ||
            code.contains(AppErrors.INVALID_FIELD)) {
          return Future.error("E-mail e/ou senha inválidos!");
        }
      }

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future logout() async {
    try {
      await _api.delete('/auth');
    } catch (error) {
      print('$TAG.logout: $error');

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _api.post('/users/forgot-password', body: {"email": email});
    } catch (error) {
      print('$TAG.forgotPassword: $error');

      if (AppApiErrors.isError(error)) {
        String code = AppApiErrors.getCode(error);

        if (code.contains(AppErrors.USER_NOT_FOUND) ||
            code.contains(AppErrors.INVALID_FIELD)) {
          return Future.error("E-mail não cadastrado!");
        }
      }

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<AuthModel> redefinePassword(RedefinePasswordViewModel model) async {
    try {
      dynamic data =
          await _api.post('/users/redefine-password', body: model.toJson());
      return AuthModel.fromJson(data);
    } catch (error) {
      print('$TAG.redefinePassword: $error');

      if (AppApiErrors.isError(error)) {
        String code = AppApiErrors.getCode(error);

        if (code.contains("user_not_found_error") ||
            code.contains("invalid_field_error")) {
          return Future.error("Código inválido!");
        }
      }

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<UserModel> getMe() async {
    try {
      dynamic data = await _api.get("/users/me");
      return UserModel.fromJson(data);
    } catch (error) {
      print('$TAG.getMe: $error');

      return Future.error(AppApiErrors.handleError(error));
    }
  }
}
