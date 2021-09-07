import 'package:emptio/repositories/post.repository.dart';
import 'package:emptio/view-models/create_post.view-model.dart';
import 'package:mobx/mobx.dart';
part 'create_post.store.g.dart';

class CreatePostStore = _CreatePostStoreBase with _$CreatePostStore;

abstract class _CreatePostStoreBase with Store {
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
    } on String catch (_error) {
      setError(_error);
    } finally {
      loading = false;
    }
  }

  @computed
  bool get isDescriptionValid => description.isNotEmpty;

  @computed
  bool get isPurchaseNameValid => purchaseName?.isNotEmpty ?? false;

  @computed
  bool get canCreate => isDescriptionValid && isPurchaseNameValid;

  @computed
  String get canCreateError {
    if (!isPurchaseNameValid) {
      return "Insira o nome da lista para continuar.";
    }

    if (!isDescriptionValid) {
      return "Insira uma descrição para continuar.";
    }

    return "Preencha todos os campos para continuar.";
  }
}
