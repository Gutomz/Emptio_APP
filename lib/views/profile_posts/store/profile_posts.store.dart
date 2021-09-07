import 'package:emptio/models/post.model.dart';
import 'package:emptio/repositories/post.repository.dart';
import 'package:emptio/view-models/get_post_profile_filter.view-model.dart';
import 'package:mobx/mobx.dart';
part 'profile_posts.store.g.dart';

class ProfilePostsStore = _ProfilePostsStoreBase with _$ProfilePostsStore;

abstract class _ProfilePostsStoreBase with Store {
  final String userId;
  final bool isMe;
  final bool lock;

  _ProfilePostsStoreBase(this.userId, {this.isMe = false, this.lock = false}) {
    autorun((_) async {
      if (!lock) {
        setLoading(true);
        final filter = GetPostProfileFilterViewModel(
          skip: skip,
        );
        await load(filter);
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
  Future<void> load(GetPostProfileFilterViewModel filter) async {
    try {
      final data = await PostRepository().getProfile(userId, filter);

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
