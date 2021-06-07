import 'package:emptio/core/app_api-errors.dart';
import 'package:emptio/core/app_api.dart';
import 'package:emptio/models/auth.model.dart';
import 'package:emptio/view-models/login.view-model.dart';
import 'package:emptio/view-models/register.view-model.dart';

class UserRepository {
  final AppApi api = AppApi();

  Future<AuthModel> register(RegisterViewModel model) async {
    try {
      dynamic data = await api.post('/users', model.toJson());
      return AuthModel.fromJson(data);
    } catch (error) {
      if (AppApiErrors.isError(error)) {
        String code = AppApiErrors.getCode(error);

        if (code.isNotEmpty) {
          if (code.contains("unique_field_error")) {
            return Future.error("E-mail já cadastrado!");
          }
        }
      }

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<AuthModel> login(LoginViewModel model) async {
    try {
      dynamic data = await api.post('/auth', model.toJson());
      return AuthModel.fromJson(data);
    } catch (error) {
      if (AppApiErrors.isError(error)) {
        String code = AppApiErrors.getCode(error);

        if (code.contains("user_not_found_error") ||
            code.contains("invalid_field_error")) {
          return Future.error("E-mail e/ou senha inválidos!");
        }
      }
      return Future.error(AppApiErrors.handleError(error));
    }
  }
}
