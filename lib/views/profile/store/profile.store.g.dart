// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileStore on _ProfileStoreBase, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_ProfileStoreBase.hasError'))
          .value;

  final _$profileAtom = Atom(name: '_ProfileStoreBase.profile');

  @override
  ProfileModel? get profile {
    _$profileAtom.reportRead();
    return super.profile;
  }

  @override
  set profile(ProfileModel? value) {
    _$profileAtom.reportWrite(value, super.profile, () {
      super.profile = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ProfileStoreBase.loading');

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

  final _$errorAtom = Atom(name: '_ProfileStoreBase.error');

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

  final _$loadProfileAsyncAction = AsyncAction('_ProfileStoreBase.loadProfile');

  @override
  Future<void> loadProfile(String id) {
    return _$loadProfileAsyncAction.run(() => super.loadProfile(id));
  }

  @override
  String toString() {
    return '''
profile: ${profile},
loading: ${loading},
error: ${error},
hasError: ${hasError}
    ''';
  }
}
