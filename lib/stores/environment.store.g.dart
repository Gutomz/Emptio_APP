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

  final _$googlePlacesKeyAtom =
      Atom(name: '_EnvironmentStoreBase.googlePlacesKey');

  @override
  String get googlePlacesKey {
    _$googlePlacesKeyAtom.reportRead();
    return super.googlePlacesKey;
  }

  @override
  set googlePlacesKey(String value) {
    _$googlePlacesKeyAtom.reportWrite(value, super.googlePlacesKey, () {
      super.googlePlacesKey = value;
    });
  }

  final _$entryTitleAtom = Atom(name: '_EnvironmentStoreBase.entryTitle');

  @override
  String get entryTitle {
    _$entryTitleAtom.reportRead();
    return super.entryTitle;
  }

  @override
  set entryTitle(String value) {
    _$entryTitleAtom.reportWrite(value, super.entryTitle, () {
      super.entryTitle = value;
    });
  }

  final _$entryDescriptionAtom =
      Atom(name: '_EnvironmentStoreBase.entryDescription');

  @override
  String get entryDescription {
    _$entryDescriptionAtom.reportRead();
    return super.entryDescription;
  }

  @override
  set entryDescription(String value) {
    _$entryDescriptionAtom.reportWrite(value, super.entryDescription, () {
      super.entryDescription = value;
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
  void setGooglePlacesKey(String _value) {
    final _$actionInfo = _$_EnvironmentStoreBaseActionController.startAction(
        name: '_EnvironmentStoreBase.setGooglePlacesKey');
    try {
      return super.setGooglePlacesKey(_value);
    } finally {
      _$_EnvironmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEntryTitle(String _value) {
    final _$actionInfo = _$_EnvironmentStoreBaseActionController.startAction(
        name: '_EnvironmentStoreBase.setEntryTitle');
    try {
      return super.setEntryTitle(_value);
    } finally {
      _$_EnvironmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEntryDescription(String _value) {
    final _$actionInfo = _$_EnvironmentStoreBaseActionController.startAction(
        name: '_EnvironmentStoreBase.setEntryDescription');
    try {
      return super.setEntryDescription(_value);
    } finally {
      _$_EnvironmentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
apiUrl: ${apiUrl},
googlePlacesKey: ${googlePlacesKey},
entryTitle: ${entryTitle},
entryDescription: ${entryDescription}
    ''';
  }
}
