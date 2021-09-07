import 'package:emptio/core/app_api_errors.dart';
import 'package:emptio/core/app_api.dart';
import 'package:emptio/helpers/logger.dart';
import 'package:emptio/models/post.model.dart';
import 'package:emptio/view-models/create_post.view-model.dart';
import 'package:emptio/view-models/get_feed_filter.view-model.dart';
import 'package:emptio/view-models/get_post_profile_filter.view-model.dart';

class PostRepository {
  static const String tag = "PostRepository";
  final AppApi _api = AppApi();

  Future<PostModel> create(CreatePostViewModel model) async {
    try {
      final data = await _api.post('/posts', body: model.toJson())
          as Map<String, dynamic>;
      return PostModel.fromJson(data);
    } catch (error, stack) {
      Logger.error(tag, 'create', error, stack);
      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<List<PostModel>> getFeed(GetFeedFilterViewModel filter) async {
    try {
      final data = await _api.get('/posts/feed',
          queryParameters: filter.toQuery()) as List<dynamic>;
      return data
          .map<PostModel>((follower) =>
              PostModel.fromJson(follower as Map<String, dynamic>))
          .toList();
    } catch (error, stack) {
      Logger.error(tag, 'getFeed', error, stack);
      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<PostModel> getById(String postId) async {
    try {
      final data = await _api.get('/posts/$postId') as Map<String, dynamic>;
      return PostModel.fromJson(data);
    } catch (error, stack) {
      Logger.error(tag, 'getById', error, stack);
      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<List<PostModel>> getProfile(
      String userId, GetPostProfileFilterViewModel filter) async {
    try {
      final data = await _api.get('/posts/profiles/$userId',
          queryParameters: filter.toQuery()) as List<dynamic>;
      return data
          .map<PostModel>((follower) =>
              PostModel.fromJson(follower as Map<String, dynamic>))
          .toList();
    } catch (error, stack) {
      Logger.error(tag, 'getFeed', error, stack);
      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<void> delete(String postId) async {
    try {
      await _api.delete('/posts/$postId') as Map<String, dynamic>;
    } catch (error, stack) {
      Logger.error(tag, 'getById', error, stack);
      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<PostModel> like(String postId) async {
    try {
      final data =
          await _api.put('/posts/$postId/like') as Map<String, dynamic>;
      return PostModel.fromJson(data);
    } catch (error, stack) {
      Logger.error(tag, 'getById', error, stack);
      return Future.error(AppApiErrors.handleError(error));
    }
  }

  Future<PostModel> dislike(String postId) async {
    try {
      final data =
          await _api.put('/posts/$postId/dislike') as Map<String, dynamic>;
      return PostModel.fromJson(data);
    } catch (error, stack) {
      Logger.error(tag, 'getById', error, stack);
      return Future.error(AppApiErrors.handleError(error));
    }
  }
}
