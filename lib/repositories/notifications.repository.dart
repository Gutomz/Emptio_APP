import 'package:emptio/core/app_api_errors.dart';
import 'package:emptio/core/app_api.dart';
import 'package:emptio/helpers/logger.dart';
import 'package:emptio/models/notification.model.dart';
import 'package:emptio/view-models/notifications_filter.view-model.dart';

class NotificationsRepository {
  static const String tag = "NotificationsRepository";
  final AppApi _api = AppApi();

  Future<List<NotificationModel>> get(
      NotificationsFilterViewModel filter) async {
    try {
      final data = await _api.get('/notifications',
          queryParameters: filter.toQuery()) as List<dynamic>;
      final list = data
          .map<NotificationModel>((follower) =>
              NotificationModel.fromJson(follower as Map<String, dynamic>))
          .toList();
      return list;
    } catch (error, stack) {
      Logger.error(tag, 'get', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }
}
