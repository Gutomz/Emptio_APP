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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    if (this.productId != null) data['product_id'] = this.productId;
    if (productModel != null) data['product'] = this.productModel!.toJson();
    return data;
  }
}
