// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'environment.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EnvironmentStore on _EnvironmentStoreBase, Store {
  final _$apiUrlAtom = Atom(name: '_EnvironmentStoreBase.apiUrl');

  @override
  String get apiUrl {
    _$apiUrlAtom.reportRead();
    return super.apiUrl;
  }

  @override
  set apiUrl(String value) {
    _$apiUrlAtom.reportWrite(value, super.apiUrl, () {
      super.apiUrl = value;
    });
  }

  final _$_EnvironmentStoreBaseActionController =
      ActionController(name: '_EnvironmentStoreBase');

  @override
  void setApiUrl(String _value) {
    final _$actionInfo = _$_EnvironmentStoreBaseActionController.startAction(
        name: '_EnvironmentStoreBase.setApiUrl');
    try {
      return super.setApiUrl(_value);
    } finally {
      _$_EnvironmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
apiUrl: ${apiUrl}
    ''';
  }
}
