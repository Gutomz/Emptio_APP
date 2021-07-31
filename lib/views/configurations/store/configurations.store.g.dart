// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configurations.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConfigurationsStore on _ConfigurationsStoreBase, Store {
  Computed<bool>? _$isLoggedComputed;

  @override
  bool get isLogged =>
      (_$isLoggedComputed ??= Computed<bool>(() => super.isLogged,
              name: '_ConfigurationsStoreBase.isLogged'))
          .value;

  final _$offlineModeAtom = Atom(name: '_ConfigurationsStoreBase.offlineMode');

  @override
  bool get offlineMode {
    _$offlineModeAtom.reportRead();
    return super.offlineMode;
  }

  @override
  set offlineMode(bool value) {
    _$offlineModeAtom.reportWrite(value, super.offlineMode, () {
      super.offlineMode = value;
    });
  }

  final _$canNotifyAtom = Atom(name: '_ConfigurationsStoreBase.canNotify');

  @override
  bool get canNotify {
    _$canNotifyAtom.reportRead();
    return super.canNotify;
  }

  @override
  set canNotify(bool value) {
    _$canNotifyAtom.reportWrite(value, super.canNotify, () {
      super.canNotify = value;
    });
  }

  final _$errorAtom = Atom(name: '_ConfigurationsStoreBase.error');

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

  final _$triggerCanNotifyAsyncAction =
      AsyncAction('_ConfigurationsStoreBase.triggerCanNotify');

  @override
  Future<void> triggerCanNotify(bool value) {
    return _$triggerCanNotifyAsyncAction
        .run(() => super.triggerCanNotify(value));
  }

  final _$triggerOfflineModeAsyncAction =
      AsyncAction('_ConfigurationsStoreBase.triggerOfflineMode');

  @override
  Future<void> triggerOfflineMode(bool value) {
    return _$triggerOfflineModeAsyncAction
        .run(() => super.triggerOfflineMode(value));
  }

  @override
  String toString() {
    return '''
offlineMode: ${offlineMode},
canNotify: ${canNotify},
error: ${error},
isLogged: ${isLogged}
    ''';
  }
}
