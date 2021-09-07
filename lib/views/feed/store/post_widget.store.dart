import 'dart:async';

import 'package:emptio/models/post.model.dart';
import 'package:emptio/repositories/post.repository.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'post_widget.store.g.dart';

class PostWidgetStore = _PostWidgetStoreBase with _$PostWidgetStore;

abstract class _PostWidgetStoreBase with Store {
  final AuthStore _authStore = GetIt.I<AuthStore>();

  Timer? timer;

  _PostWidgetStoreBase(this.post) {
    timer = Timer.periodic(Duration(seconds: 30), (Timer t) => update());
  }

  @observable
  PostModel post;

  @observable
  bool loading = false;

  @observable
  bool shouldDelete = false;

  @observable
  String error = "";

  @action
  Future<void> toggleLike() async {
    loading = true;

    try {
      post = await PostRepository().like(post.sId);
      error = "";
    } on String catch (_) {/* do nothing */} finally {
      loading = false;
    }
  }

  @action
  Future<void> toggleDislike() async {
    loading = true;

    try {
      post = await PostRepository().dislike(post.sId);
      error = "";
    } on String catch (_) {/* do nothing */} finally {
      loading = false;
    }
  }

  @action
  Future<void> update() async {
    if (loading) return;

    try {
      post = await PostRepository().getById(post.sId);
      error = "";
    } on String catch (_) {
      dispose();
      shouldDelete = true;
    }
  }

  @action
  Future<void> delete(String sId) async {
    loading = true;
    try {
      await PostRepository().delete(sId);
      dispose();
      error = "";
    } on String catch (_error) {
      error = _error;
    } finally {
      loading = false;
    }
  }

  @computed
  bool get hasError => error.isNotEmpty;

  @computed
  String get type => post.data.type;

  @computed
  int get likes => post.likes.length;

  @computed
  int get dislikes => post.dislikes.length;

  @computed
  bool get isLikeSelected => post.likes.contains(_authStore.user!.sId);

  @computed
  bool get isDislikeSelected => post.dislikes.contains(_authStore.user!.sId);

  void dispose() {
    timer?.cancel();
  }
}
