import 'package:emptio/models/product.model.dart';
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    if (this.productId != null) data['product_id'] = this.productId;
    if(productModel != null) data['product'] = this.productModel!.toJson();
    return data;
  }
}
