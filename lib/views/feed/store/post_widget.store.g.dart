// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_widget.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostWidgetStore on _PostWidgetStoreBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_PostWidgetStoreBase.hasError'))
          .value;
  Computed<String>? _$typeComputed;

  @override
  String get type => (_$typeComputed ??=
          Computed<String>(() => super.type, name: '_PostWidgetStoreBase.type'))
      .value;
  Computed<int>? _$likesComputed;

  @override
  int get likes => (_$likesComputed ??=
          Computed<int>(() => super.likes, name: '_PostWidgetStoreBase.likes'))
      .value;
  Computed<int>? _$dislikesComputed;

  @override
  int get dislikes =>
      (_$dislikesComputed ??= Computed<int>(() => super.dislikes,
              name: '_PostWidgetStoreBase.dislikes'))
          .value;
  Computed<bool>? _$isLikeSelectedComputed;

  @override
  bool get isLikeSelected =>
      (_$isLikeSelectedComputed ??= Computed<bool>(() => super.isLikeSelected,
              name: '_PostWidgetStoreBase.isLikeSelected'))
          .value;
  Computed<bool>? _$isDislikeSelectedComputed;

  @override
  bool get isDislikeSelected => (_$isDislikeSelectedComputed ??= Computed<bool>(
          () => super.isDislikeSelected,
          name: '_PostWidgetStoreBase.isDislikeSelected'))
      .value;

  final _$postAtom = Atom(name: '_PostWidgetStoreBase.post');

  @override
  PostModel get post {
    _$postAtom.reportRead();
    return super.post;
  }

  @override
  set post(PostModel value) {
    _$postAtom.reportWrite(value, super.post, () {
      super.post = value;
    });
  }

  final _$loadingAtom = Atom(name: '_PostWidgetStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$shouldDeleteAtom = Atom(name: '_PostWidgetStoreBase.shouldDelete');

  @override
  bool get shouldDelete {
    _$shouldDeleteAtom.reportRead();
    return super.shouldDelete;
  }

  @override
  set shouldDelete(bool value) {
    _$shouldDeleteAtom.reportWrite(value, super.shouldDelete, () {
      super.shouldDelete = value;
    });
  }

  final _$errorAtom = Atom(name: '_PostWidgetStoreBase.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$toggleLikeAsyncAction =
      AsyncAction('_PostWidgetStoreBase.toggleLike');

  @override
  Future<void> toggleLike() {
    return _$toggleLikeAsyncAction.run(() => super.toggleLike());
  }

  final _$toggleDislikeAsyncAction =
      AsyncAction('_PostWidgetStoreBase.toggleDislike');

  @override
  Future<void> toggleDislike() {
    return _$toggleDislikeAsyncAction.run(() => super.toggleDislike());
  }

  final _$updateAsyncAction = AsyncAction('_PostWidgetStoreBase.update');

  @override
  Future<void> update() {
    return _$updateAsyncAction.run(() => super.update());
  }

  final _$deleteAsyncAction = AsyncAction('_PostWidgetStoreBase.delete');

  @override
  Future<void> delete(String sId) {
    return _$deleteAsyncAction.run(() => super.delete(sId));
  }

  @override
  String toString() {
    return '''
post: ${post},
loading: ${loading},
shouldDelete: ${shouldDelete},
error: ${error},
hasError: ${hasError},
type: ${type},
likes: ${likes},
dislikes: ${dislikes},
isLikeSelected: ${isLikeSelected},
isDislikeSelected: ${isDislikeSelected}
    ''';
  }
}
