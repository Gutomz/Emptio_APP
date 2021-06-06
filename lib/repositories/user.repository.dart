import 'package:emptio/core/app_api-errors.dart';
import 'package:emptio/core/app_api.dart';
import 'package:emptio/models/auth.model.dart';
import 'package:emptio/view-models/register.view-model.dart';

class UserRepository {
  final AppApi api = AppApi();

  Future<AuthModel> register(RegisterViewModel model) async {
    try {
      dynamic data = await api.post('/users', model.toJson());
      return AuthModel.fromJson(data);
    } catch (error) {
      if (error is Map<String, dynamic>) {
        String code = error['code'] ?? "";

        if (code.isNotEmpty) {
          if (code.contains("unique_field_error")) {
            return Future.error("E-mail já cadastrado!");
          }
        }
      }

      return Future.error(AppApiErrors.handleError(error));
    }
  }
}
