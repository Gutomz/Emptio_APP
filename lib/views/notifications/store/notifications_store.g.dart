// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationsStore on _NotificationsStoreBase, Store {
  Computed<int>? _$itemCountComputed;

  @override
  int get itemCount =>
      (_$itemCountComputed ??= Computed<int>(() => super.itemCount,
              name: '_NotificationsStoreBase.itemCount'))
          .value;
  Computed<bool>? _$firstLoadingComputed;

  @override
  bool get firstLoading =>
      (_$firstLoadingComputed ??= Computed<bool>(() => super.firstLoading,
              name: '_NotificationsStoreBase.firstLoading'))
          .value;
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_NotificationsStoreBase.hasError'))
          .value;

  final _$skipAtom = Atom(name: '_NotificationsStoreBase.skip');

  @override
  int get skip {
    _$skipAtom.reportRead();
    return super.skip;
  }

  @override
  set skip(int value) {
    _$skipAtom.reportWrite(value, super.skip, () {
      super.skip = value;
    });
  }

  final _$loadingAtom = Atom(name: '_NotificationsStoreBase.loading');

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

  final _$errorAtom = Atom(name: '_NotificationsStoreBase.error');

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

  final _$limitReachedAtom = Atom(name: '_NotificationsStoreBase.limitReached');

  @override
  bool get limitReached {
    _$limitReachedAtom.reportRead();
    return super.limitReached;
  }

  @override
  set limitReached(bool value) {
    _$limitReachedAtom.reportWrite(value, super.limitReached, () {
      super.limitReached = value;
    });
  }

  final _$loadAsyncAction = AsyncAction('_NotificationsStoreBase.load');

  @override
  Future<dynamic> load(NotificationsFilterViewModel filter) {
    return _$loadAsyncAction.run(() => super.load(filter));
  }

  final _$resetPageAsyncAction =
      AsyncAction('_NotificationsStoreBase.resetPage');

  @override
  Future<void> resetPage() {
    return _$resetPageAsyncAction.run(() => super.resetPage());
  }

  final _$_NotificationsStoreBaseActionController =
      ActionController(name: '_NotificationsStoreBase');

  @override
  void setLoading(bool _value) {
    final _$actionInfo = _$_NotificationsStoreBaseActionController.startAction(
        name: '_NotificationsStoreBase.setLoading');
    try {
      return super.setLoading(_value);
    } finally {
      _$_NotificationsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setError(String _value) {
    final _$actionInfo = _$_NotificationsStoreBaseActionController.startAction(
        name: '_NotificationsStoreBase.setError');
    try {
      return super.setError(_value);
    } finally {
      _$_NotificationsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loadNextPage() {
    final _$actionInfo = _$_NotificationsStoreBaseActionController.startAction(
        name: '_NotificationsStoreBase.loadNextPage');
    try {
      return super.loadNextPage();
    } finally {
      _$_NotificationsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
skip: ${skip},
loading: ${loading},
error: ${error},
limitReached: ${limitReached},
itemCount: ${itemCount},
firstLoading: ${firstLoading},
hasError: ${hasError}
    ''';
  }
}
