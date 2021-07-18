import 'package:emptio/models/friendship_request.model.dart';
import 'package:emptio/repositories/followers.repository.dart';
import 'package:mobx/mobx.dart';
part 'friendship_requests_store.g.dart';

class FriendshipRequestsStore = _FriendshipRequestsStoreBase
    with _$FriendshipRequestsStore;

abstract class _FriendshipRequestsStoreBase with Store {
  _FriendshipRequestsStoreBase() {
    autorun((_) => load());
  }

  ObservableList<FriendshipRequestModel> list = ObservableList();

  @observable
  bool loading = false;

  @observable
  String error = "";

  @action
  Future<void> load() async {
    loading = true;
    error = "";

    try {
      final data = await FollowersRepository().getRequests();
      list.clear();
      list.addAll(data);
    } on String catch (_error) {
      error = _error;
    } finally {
      loading = false;
    }
  }

  @action
  // ignore: avoid_positional_boolean_parameters
  Future<void> updateRequest(String requestId, bool accept) async {
    loading = true;
    error = "";

    try {
      list.removeWhere((element) => element.sId == requestId);
      await FollowersRepository().updateRequest(requestId, accept);
    } on String catch (_error) {
      error = _error;
    } finally {
      loading = false;
    }
  }

  @action
  void acceptRequest(String requestId) {
    updateRequest(requestId, true);
  }

  @action
  void ignoreRequest(String requestId) {
    updateRequest(requestId, false);
  }

  @computed
  bool get hasError => error.isNotEmpty;
}
