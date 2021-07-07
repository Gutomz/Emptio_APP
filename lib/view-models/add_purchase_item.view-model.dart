import 'package:emptio/view-models/product_create.view-model.dart';

class AddPurchaseItemViewModel {
  double price;
  int quantity;
  String? productId;
  ProductCreateViewModel? productModel;

  AddPurchaseItemViewModel({
    required this.price,
    required this.quantity,
    this.productId,
    this.productModel,
  }) : assert(productId != null || productModel != null);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['quantity'] = quantity;
    if (productId != null) data['product_id'] = productId;
    if (productModel != null) data['product'] = productModel!.toJson();
    return data;
  }
}
