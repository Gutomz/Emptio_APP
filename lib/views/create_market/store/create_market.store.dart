import 'dart:io';

import 'package:emptio/models/market.model.dart';
import 'package:emptio/repositories/market.repository.dart';
import 'package:emptio/view-models/create_market.view-model.dart';
import 'package:mobx/mobx.dart';
import 'package:emptio/helpers/extensions.dart';
part 'create_market.store.g.dart';

class CreateMarketStore = _CreateMarketStoreBase with _$CreateMarketStore;

abstract class _CreateMarketStoreBase with Store {
  @observable
  File? image;

  @observable
  String? name;

  @observable
  String error = "";

  @action
  void setImage(File? _value) => image = _value;

  @action
  void setName(String _value) => name = _value;

  @action
  Future<MarketModel?> create() async {
    try {
      final model = MarketCreateViewModel(
        name: name!,
        image: image?.parseToBase64(),
      );

      final market = await MarketRepository().create(model);

      return market;
    } on String catch (_error) {
      error = _error;
    }
  }

  @computed
  bool get nameValid {
    final _name = name ?? "";
    return _name.isNotEmpty && _name.length > 1;
  }

  @computed
  String? get nameError {
    final _name = name ?? "";

    if (name == null || nameValid) {
      return null;
    } else if (_name.isEmpty) {
      return "Campo obrigatório!";
    }

    return "Nome muito curto";
  }

  @computed
  bool get formValid => nameValid;
}
