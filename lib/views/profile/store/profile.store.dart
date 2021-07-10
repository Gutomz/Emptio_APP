import 'package:emptio/models/profile.model.dart';
import 'package:emptio/repositories/user.repository.dart';
import 'package:mobx/mobx.dart';
part 'profile.store.g.dart';

class ProfileStore = _ProfileStoreBase with _$ProfileStore;

abstract class _ProfileStoreBase with Store {
  @observable
  ProfileModel? profile;

  @observable
  bool loading = false;

  @observable
  String error = "";

  @action
  Future<void> loadProfile(String id) async {
    loading = true;
    try {
      final profileData = await UserRepository().getProfile(id);

      profile = profileData;
      error = "";
    } on String catch (_error) {
      error = _error;
    } finally {
      loading = false;
    }
  }

  @computed
  bool get hasError => error.isNotEmpty;
}
