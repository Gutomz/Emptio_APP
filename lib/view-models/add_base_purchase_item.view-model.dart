import 'package:emptio/view-models/product_create.view-model.dart';

class AddBasePurchaseItemViewModel {
  int quantity;
  String? productId;
  ProductCreateViewModel? productModel;

  AddBasePurchaseItemViewModel({
    required this.quantity,
    this.productId,
    this.productModel,
  }) : assert(productId != null || productModel != null);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    if (productId != null) data['product_id'] = productId;
    if (productModel != null) data['product'] = productModel!.toJson();
    return data;
  }
}
