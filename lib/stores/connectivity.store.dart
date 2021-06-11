import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobx/mobx.dart';
part 'connectivity.store.g.dart';

class ConnectivityStore = _ConnectivityStoreBase with _$ConnectivityStore;

abstract class _ConnectivityStoreBase with Store {
  _ConnectivityStoreBase() {
    autorun((_) {
      print('Connectivity changed: ${connectivityStream.status}');
    });
  }

  @observable
  ObservableStream<ConnectivityResult> connectivityStream =
      ObservableStream(Connectivity().onConnectivityChanged);

  @computed
  bool get isActive => connectivityStream.status == StreamStatus.active;

  @computed
  bool get isConnected =>
      isActive ? connectivityStream.value != ConnectivityResult.none : false;

  void dispose() {}
}
