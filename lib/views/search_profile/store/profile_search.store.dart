import 'package:emptio/models/friendship_request.model.dart';
import 'package:emptio/models/profile_search.model.dart';
import 'package:emptio/repositories/followers.repository.dart';
import 'package:emptio/repositories/user.repository.dart';
import 'package:emptio/view-models/friendship_request.vew-model.dart';
import 'package:emptio/view-models/profile_search_filter.view-model.dart';
import 'package:mobx/mobx.dart';

part 'profile_search.store.g.dart';

class ProfileSearchStore = _ProfileSearchStoreBase with _$ProfileSearchStore;

abstract class _ProfileSearchStoreBase with Store {
  _ProfileSearchStoreBase() {
    autorun((_) async {
      setLoading(true);
      final filter = ProfileSearchFilterViewModel(
        search: search,
        skip: skip,
      );

      await load(filter);
      setLoading(false);
    });
  }

  @observable
  String search = "";

  @observable
  int skip = 0;

  @observable
  bool reachedEnd = false;

  @observable
  bool loading = false;

  @observable
  bool requestLoading = false;

  @observable
  String error = "";

  ObservableList<ProfileSearchModel> list = ObservableList();

  @action
  void setSearch(String _value) => search = _value;

  @action
  // ignore: avoid_positional_boolean_parameters
  void setLoading(bool _value) => loading = _value;

  @action
  void setError(String _value) => error = _value;

  @action
  Future<void> load(ProfileSearchFilterViewModel filter) async {
    try {
      final data = await UserRepository().getProfiles(filter);

      if (filter.skip == 0) {
        list.clear();
      }

      if (data.length < filter.limit) {
        reachedEnd = true;
      }

      list.addAll(data);
      setError("");
    } on String catch (_error) {
      setError(_error);
    }
  }

  @action
  void loadNextPage() {
    skip = list.length;
  }

  @action
  Future<void> reset() async {
    list.clear();
    skip = 0;
    reachedEnd = false;
  }

  @action
  Future<void> request(String friendId) async {
    requestLoading = true;
    error = "";

    final model = FriendshipRequestViewModel(friendId: friendId);

    try {
      final index =
          list.indexWhere((element) => element.user.sId.contains(friendId));
      list[index].friendshipStatus = FriendshipStatusTypes.pending;
      list[index] = ProfileSearchModel.copy(list[index]);

      final requestId = await FollowersRepository().request(model);
      list[index].friendshipId = requestId;
      list[index] = ProfileSearchModel.copy(list[index]);
    } on String catch (_error) {
      error = _error;
    } finally {
      requestLoading = false;
    }
  }

  @action
  Future<void> removeRequest(String sId, String requestId) async {
    requestLoading = true;
    error = "";

    try {
      final index =
          list.indexWhere((element) => element.user.sId.contains(sId));
      list[index].friendshipStatus = FriendshipStatusTypes.none;
      list[index] = ProfileSearchModel.copy(list[index]);
      await FollowersRepository().delete(requestId);
    } on String catch (_error) {
      error = _error;
    } finally {
      requestLoading = false;
    }
  }

  @computed
  bool get hasError => error.isNotEmpty;

  @computed
  int get itemsCount => reachedEnd ? list.length : list.length + 1;

  @computed
  bool get isFirstLoading => loading && list.isEmpty;
}
