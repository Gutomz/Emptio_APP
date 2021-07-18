import 'package:emptio/core/app_api_errors.dart';
import 'package:emptio/core/app_api.dart';
import 'package:emptio/helpers/logger.dart';
import 'package:emptio/helpers/parsers.dart';
import 'package:emptio/models/follower.model.dart';
import 'package:emptio/models/friendship_request.model.dart';
import 'package:emptio/view-models/followers_list_filter.view-model.dart';
import 'package:emptio/view-models/friendship_request.vew-model.dart';

class FollowersRepository {
  static const String tag = "FollowersRepository";
  final AppApi _api = AppApi();

  Future<String> request(FriendshipRequestViewModel model) async {
    try {
      final data = await _api.post('/friendships/requests',
          body: model.toJson()) as Map<String, dynamic>;

      return JsonParser.parseToString(data['_id']);
    } catch (error, stack) {
      Logger.error(tag, 'request', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<List<FollowerModel>> get(FollowersListFilterViewModel filter) async {
    try {
      final data = await _api.get('/friendships',
          queryParameters: filter.toQuery()) as List<dynamic>;
      final list = data
          .map<FollowerModel>((follower) =>
              FollowerModel.fromJson(follower as Map<String, dynamic>))
          .toList();
      return list;
    } catch (error, stack) {
      Logger.error(tag, 'get', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<void> delete(String sId) async {
    try {
      await _api.delete('/friendships/$sId');
    } catch (error, stack) {
      Logger.error(tag, 'delete', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<List<FriendshipRequestModel>> getRequests() async {
    try {
      final data = await _api.get('/friendships/requests') as List<dynamic>;
      final list = data
          .map<FriendshipRequestModel>((follower) =>
              FriendshipRequestModel.fromJson(follower as Map<String, dynamic>))
          .toList();
      return list;
    } catch (error, stack) {
      Logger.error(tag, 'getRequests', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }

  // ignore: avoid_positional_boolean_parameters
  Future<void> updateRequest(String requestId, bool accept) async {
    try {
      await _api
          .put('/friendships/requests/$requestId', body: {"accept": accept});
    } catch (error, stack) {
      Logger.error(tag, 'updateRequest', error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }
}
