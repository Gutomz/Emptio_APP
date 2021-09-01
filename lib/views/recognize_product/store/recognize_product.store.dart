import 'dart:typed_data';

import 'package:emptio/models/product.model.dart';
import 'package:emptio/repositories/product.repository.dart';
import 'package:emptio/view-models/product_recognizer.view-model.dart';
import 'package:mobx/mobx.dart';
import 'package:emptio/helpers/extensions.dart';

part 'recognize_product.store.g.dart';

class RecognizeProductStore = _RecognizeProductStoreBase
    with _$RecognizeProductStore;

abstract class _RecognizeProductStoreBase with Store {
  final String purchaseId;
  final String basePurchaseId;
  final bool isFavorite;

  _RecognizeProductStoreBase({
    this.purchaseId = "",
    this.basePurchaseId = "",
    this.isFavorite = false,
  });

  @observable
  bool loading = false;

  @observable
  String? error;

  @observable
  bool loaded = false;

  @observable
  bool hasReset = false;

  @observable
  Uint8List? imageBytes;

  ObservableList<ProductModel> list = ObservableList();

  @action
  // ignore: avoid_positional_boolean_parameters
  void setLoading(bool _value) => loading = _value;

  @action
  // ignore: avoid_positional_boolean_parameters
  void setLoaded(bool _value) => loaded = _value;

  @action
  void setError(String? _value) => error = _value;

  @action
  // ignore: avoid_positional_boolean_parameters
  void setHasReset(bool _value) => hasReset = _value;

  @action
  Future<void> recognizeProduct(Uint8List bytes) async {
    setLoading(true);
    setLoaded(false);
    setError(null);
    imageBytes = bytes;

    try {
      final model = ProductRecognizerViewModel(
        image: bytes.parseToBase64(),
        purchaseId: purchaseId,
        basePurchaseId: basePurchaseId,
        isFavorite: isFavorite,
      );

      final startTime = DateTime.now();
      final response = await ProductRepository().recognize(model);
      final endTime = DateTime.now();

      final diference = endTime.difference(startTime);
      if (diference.inSeconds < 2) {
        await Future.delayed(Duration(seconds: 2));
      }

      list.clear();
      list.addAll(response);
      setLoaded(true);
    } on String catch (_error) {
      setError(_error);
    } finally {
      setLoading(false);
    }
  }

  @action
  void reset() {
    setHasReset(true);
    setLoaded(false);
  }

  @action
  void restore() {
    setLoaded(true);
  }

  @computed
  bool get hasError => error != null && error!.isNotEmpty;

  @computed
  bool get hasItems => list.isNotEmpty;

  @computed
  int get itemsCount => list.length;
}
