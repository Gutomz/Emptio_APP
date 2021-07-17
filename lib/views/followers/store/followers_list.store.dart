import 'package:emptio/models/follower.model.dart';
import 'package:emptio/repositories/followers.repository.dart';
import 'package:emptio/view-models/followers_list_filter.view-model.dart';
import 'package:emptio/view-models/friendship_request.vew-model.dart';
import 'package:mobx/mobx.dart';
part 'followers_list.store.g.dart';

class FollowersListStore = _FollowersListStoreBase with _$FollowersListStore;

abstract class _FollowersListStoreBase with Store {
  _FollowersListStoreBase({this.userId, this.followers = false}) {
    autorun((_) => load());
  }

  ObservableList<FollowerModel> list = ObservableList();

  @observable
  String? userId;

  @observable
  bool followers;

  @observable
  bool loading = false;

  @observable
  String error = "";

  @action
  void setUserId(String? _value) => userId = _value;

  @action
  // ignore: avoid_positional_boolean_parameters
  void setFollowers(bool _value) => followers = _value;

  @action
  Future<void> request(String friendId) async {
    loading = true;
    error = "";

    final model = FriendshipRequestViewModel(friendId: friendId);

    try {
      final index =
          list.indexWhere((element) => element.user.sId.contains(friendId));
      list[index] = FollowerModel(
        sId: list[index].sId,
        user: list[index].user,
        isFollowing: list[index].isFollowing,
        followingStatus: FriendshipStatusTypes.pending,
      );
      
      await FollowersRepository().request(model);
    } on String catch (_error) {
      error = _error;
    } finally {
      loading = false;
    }
  }

  @action
  Future<void> load() async {
    loading = true;
    error = "";

    final filter = FollowersListFilterViewModel(
      userId: userId,
      followers: followers,
    );

    try {
      final data = await FollowersRepository().get(filter);
      list.clear();
      list.addAll(data);
    } on String catch (_error) {
      error = _error;
    } finally {
      loading = false;
    }
  }

  @action
  Future<void> remove(String sId) async {
    loading = true;
    error = "";

    try {
      list.removeWhere((element) => element.sId.contains(sId));
      await FollowersRepository().delete(sId);
    } on String catch (_error) {
      error = _error;
    } finally {
      loading = false;
    }
  }

  @computed
  bool get hasError => error.isNotEmpty;
}
