import 'package:emptio/core/app_api_errors.dart';
import 'package:emptio/core/app_api.dart';
import 'package:emptio/core/app_errors.dart';
import 'package:emptio/helpers/logger.dart';
import 'package:emptio/models/auth.model.dart';
import 'package:emptio/models/profile.model.dart';
import 'package:emptio/models/user.model.dart';
import 'package:emptio/view-models/login.view-model.dart';
import 'package:emptio/view-models/redefine_password.view-model.dart';
import 'package:emptio/view-models/register.view-model.dart';

class UserRepository {
  static const String tag = "UserRepository";
  final AppApi _api = AppApi();

  Future<AuthModel> register(RegisterViewModel model) async {
    try {
      final data = await _api.post('/users', body: model.toJson())
          as Map<String, dynamic>;
      return AuthModel.fromJson(data);
    } catch (error, stack) {
      Logger.error(tag, "Exception at 'register' function", error, stack);

      if (AppApiErrors.isError(error)) {
        final String code = AppApiErrors.getCode(error);

        if (code.isNotEmpty) {
          if (code.contains(AppErrors.uniqueField)) {
            return Future.error("E-mail já cadastrado!");
          }
        }
      }

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<AuthModel> login(LoginViewModel model) async {
    try {
      final data = await _api.post('/auth', body: model.toJson())
          as Map<String, dynamic>;
      return AuthModel.fromJson(data);
    } catch (error, stack) {
      Logger.error(tag, "Exception at 'login' function", error, stack);

      if (AppApiErrors.isError(error)) {
        final String code = AppApiErrors.getCode(error);

        if (code.contains(AppErrors.userNotFound) ||
            code.contains(AppErrors.invalidField)) {
          return Future.error("E-mail e/ou senha inválidos!");
        }
      }

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future logout() async {
    try {
      await _api.delete('/auth');
    } catch (error, stack) {
      Logger.error(tag, "Exception at 'logout' function", error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _api.post('/users/forgot-password', body: {"email": email});
    } catch (error, stack) {
      Logger.error(tag, "Exception at 'forgotPassword' function", error, stack);

      if (AppApiErrors.isError(error)) {
        final String code = AppApiErrors.getCode(error);

        if (code.contains(AppErrors.userNotFound) ||
            code.contains(AppErrors.invalidField)) {
          return Future.error("E-mail não cadastrado!");
        }
      }

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<AuthModel> redefinePassword(RedefinePasswordViewModel model) async {
    try {
      final data = await _api.post(
        '/users/redefine-password',
        body: model.toJson(),
      ) as Map<String, dynamic>;
      return AuthModel.fromJson(data);
    } catch (error, stack) {
      Logger.error(
          tag, "Exception at 'redefinePassword' function", error, stack);

      if (AppApiErrors.isError(error)) {
        final String code = AppApiErrors.getCode(error);

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
      final data = await _api.get("/users/me") as Map<String, dynamic>;
      return UserModel.fromJson(data);
    } catch (error, stack) {
      Logger.error(tag, "Exception at 'getMe' function", error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<ProfileModel> getProfile(String userId) async {
    try {
      final data =
          await _api.get('/users/profile/$userId') as Map<String, dynamic>;
      return ProfileModel.fromJson(data);
    } catch (error, stack) {
      Logger.error(tag, "Exception at 'getProfile' function", error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }
}
