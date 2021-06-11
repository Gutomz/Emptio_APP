// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConnectivityStore on _ConnectivityStoreBase, Store {
  Computed<bool>? _$isActiveComputed;

  @override
  bool get isActive =>
      (_$isActiveComputed ??= Computed<bool>(() => super.isActive,
              name: '_ConnectivityStoreBase.isActive'))
          .value;
  Computed<bool>? _$isConnectedComputed;

  @override
  bool get isConnected =>
      (_$isConnectedComputed ??= Computed<bool>(() => super.isConnected,
              name: '_ConnectivityStoreBase.isConnected'))
          .value;

  final _$connectivityStreamAtom =
      Atom(name: '_ConnectivityStoreBase.connectivityStream');

  @override
  ObservableStream<ConnectivityResult> get connectivityStream {
    _$connectivityStreamAtom.reportRead();
    return super.connectivityStream;
  }

  @override
  set connectivityStream(ObservableStream<ConnectivityResult> value) {
    _$connectivityStreamAtom.reportWrite(value, super.connectivityStream, () {
      super.connectivityStream = value;
    });
  }

  @override
  String toString() {
    return '''
connectivityStream: ${connectivityStream},
isActive: ${isActive},
isConnected: ${isConnected}
    ''';
  }
}
