import 'package:emptio/models/post.model.dart';
import 'package:emptio/repositories/post.repository.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/get_feed_filter.view-model.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'feed.store.g.dart';

class FeedStore = _FeedStoreBase with _$FeedStore;

abstract class _FeedStoreBase with Store {
  final AuthStore _authStore = GetIt.I<AuthStore>();

  _FeedStoreBase() {
    autorun((_) async {
      if (_authStore.isLogged) {
        setLoading(true);
        final filter = GetFeedFilterViewModel(
          skip: skip,
        );
        await loadFeed(filter);
        setLoading(false);
      }
    });
  }

  ObservableList<PostModel> list = ObservableList();

  @observable
  int skip = 0;

  @observable
  bool reachedEnd = false;

  @observable
  bool loading = false;

  @observable
  String error = "";

  @action
  // ignore: avoid_positional_boolean_parameters
  void setLoading(bool _value) => loading = _value;

  @action
  void setError(String _value) => error = _value;

  @action
  Future<void> loadFeed(GetFeedFilterViewModel filter) async {
    try {
      final data = await PostRepository().getFeed(filter);

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
  Future<void> resetPage() async {
    list.clear();
    skip = 0;
    reachedEnd = false;
  }

  @action
  Future<void> delete(String sId) async {
    list.removeWhere((element) => element.sId == sId);
  }

  @computed
  bool get hasError => error.isNotEmpty;

  @computed
  bool get firstLoading => loading && list.isEmpty;

  @computed
  int get listCount => reachedEnd ? list.length : list.length + 1;
}
