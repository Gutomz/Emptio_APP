import 'package:emptio/models/friendship_request.model.dart';
import 'package:emptio/models/profile.model.dart';
import 'package:emptio/repositories/followers.repository.dart';
import 'package:emptio/repositories/user.repository.dart';
import 'package:emptio/view-models/friendship_request.vew-model.dart';
import 'package:mobx/mobx.dart';
part 'profile.store.g.dart';

class ProfileStore = _ProfileStoreBase with _$ProfileStore;

abstract class _ProfileStoreBase with Store {
  final String userId;

  _ProfileStoreBase({required this.userId}) {
    autorun((_) {
      loadProfile();
    });
  }

  @observable
  ProfileModel? profile;

  @observable
  bool loading = false;

  @observable
  String error = "";

  @action
  Future<String?> request(String friendId) async {
    final model = FriendshipRequestViewModel(friendId: friendId);

    try {
      final requestId = await FollowersRepository().request(model);
      profile!.friendshipId = requestId;
      profile!.friendshipStatus = FriendshipStatusTypes.pending;
      profile = ProfileModel.copy(profile!);
    } on String catch (_error) {
      return _error;
    }
  }

  @action
  Future<String?> deleteRequest() async {
    try {
      if (profile != null && profile!.friendshipId != null) {
        await FollowersRepository().delete(profile!.friendshipId!);
        if (profile!.isFollowing) {
          profile!.followersCount--;
          profile!.isFollowing = false;
        }

        profile!.friendshipId = null;
        profile!.friendshipStatus = FriendshipStatusTypes.none;
        profile = ProfileModel.copy(profile!);
        return null;
      }

      throw 'Ocorreu um erro! Tente novamente mais tarde.';
    } on String catch (_error) {
      return _error;
    }
  }

  @action
  Future<void> loadProfile() async {
    loading = true;
    try {
      final profileData = await UserRepository().getProfile(userId);

      profile = profileData;
      error = "";
    } on String catch (_error) {
      error = _error;
    } finally {
      loading = false;
    }
  }

  @computed
  bool get hasError => error.isNotEmpty;
}
