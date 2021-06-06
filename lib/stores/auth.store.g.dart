// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStoreBase, Store {
  final _$authAtom = Atom(name: '_AuthStoreBase.auth');

  @override
  AuthModel? get auth {
    _$authAtom.reportRead();
    return super.auth;
  }

  @override
  set auth(AuthModel? value) {
    _$authAtom.reportWrite(value, super.auth, () {
      super.auth = value;
    });
  }

  final _$_AuthStoreBaseActionController =
      ActionController(name: '_AuthStoreBase');

  @override
  void setAuth(AuthModel _value) {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.setAuth');
    try {
      return super.setAuth(_value);
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
auth: ${auth}
    ''';
  }
}
