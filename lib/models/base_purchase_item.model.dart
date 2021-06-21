import 'package:emptio/models/product.model.dart';

class BasePurchaseItemModel {
  String sId;
  ProductModel product;
  int quantity;

  BasePurchaseItemModel({
    required this.sId,
    required this.product,
    required this.quantity,
  });

  factory BasePurchaseItemModel.fromJson(Map<String, dynamic> json) {
    var model = BasePurchaseItemModel(
      sId: json['_id'],
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['product'] = this.product.toJson();
    data['quantity'] = this.quantity;
    return data;
  }
}
