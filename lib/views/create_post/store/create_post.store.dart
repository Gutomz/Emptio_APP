import 'package:emptio/models/post_data.model.dart';
import 'package:emptio/repositories/post.repository.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/view-models/create_post.view-model.dart';
import 'package:emptio/views/feed/store/feed.store.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
part 'create_post.store.g.dart';

class CreatePostStore = _CreatePostStoreBase with _$CreatePostStore;

abstract class _CreatePostStoreBase with Store {
  String type;
  final FeedStore _feedStore = GetIt.I<AppStore>().feedStore;

  _CreatePostStoreBase(this.type);

  @observable
  bool loading = false;

  @observable
  String description = "";

  @observable
  String? purchaseName;

  @observable
  String error = "";

  @action
  void setDescription(String _value) => description = _value;

  @action
  void setPurchaseName(String? _value) => purchaseName = _value;

  @action
  void setError(String _value) => error = _value;

  @action
  Future<void> create(CreatePostViewModel model) async {
    loading = true;
    setError("");
    try {
      await PostRepository().create(model);
      _feedStore.resetPage();
    } on String catch (_error) {
      setError(_error);
    } finally {
      loading = false;
    }
  }

  @computed
  bool get isDescriptionValid => description.isNotEmpty;

  @computed
  bool get isPurchaseNameValid =>
      type == PostDataTypes.productMarket ||
      (purchaseName?.isNotEmpty ?? false);

  @computed
  bool get canCreate => isDescriptionValid && isPurchaseNameValid;

  @computed
  String get canCreateError {
    if (type == PostDataTypes.purchase && !isPurchaseNameValid) {
      return "Insira o nome da lista para continuar.";
    }

    if (!isDescriptionValid) {
      return "Insira uma descrição para continuar.";
    }

    return "Preencha todos os campos para continuar.";
  }
}
