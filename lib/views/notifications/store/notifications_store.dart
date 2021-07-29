import 'package:emptio/models/notification.model.dart';
import 'package:emptio/repositories/notifications.repository.dart';
import 'package:emptio/view-models/notifications_filter.view-model.dart';
import 'package:mobx/mobx.dart';
part 'notifications_store.g.dart';

class NotificationsStore = _NotificationsStoreBase with _$NotificationsStore;

abstract class _NotificationsStoreBase with Store {
  final int limit;

  _NotificationsStoreBase({
    this.limit = 10,
  }) {
    autorun((_) async {
      setLoading(true);
      final filter = NotificationsFilterViewModel(
        limit: limit,
        skip: skip,
      );

      await load(filter);
      setLoading(false);
    });
  }

  ObservableList<NotificationModel> list = ObservableList();

  @observable
  int skip = 0;

  @observable
  bool loading = false;

  @observable
  String error = "";

  @observable
  bool limitReached = false;

  @action
  // ignore: avoid_positional_boolean_parameters
  void setLoading(bool _value) => loading = _value;

  @action
  void setError(String _value) => error = _value;

  @action
  Future load(NotificationsFilterViewModel filter) async {
    try {
      final notifications = await NotificationsRepository().get(filter);

      if (notifications.length < filter.limit) limitReached = true;

      if (filter.skip == 0) {
        list.clear();
      }

      list.addAll(notifications);
      setError("");
    } on String catch (_error) {
      setError(_error);
    }
  }

  @action
  void loadNextPage() {
    skip = list.length;
  }

  @action
  Future<void> resetPage() async {
    skip = 0;
    list.clear();
    limitReached = false;
    await Future.delayed(Duration(seconds: 2));
  }

  @computed
  int get itemCount => limitReached ? list.length : list.length + 1;

  @computed
  bool get firstLoading => loading && list.isEmpty;

  @computed
  bool get hasError => error.isNotEmpty;
}
