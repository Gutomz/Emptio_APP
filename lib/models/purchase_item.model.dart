import 'package:emptio/models/product.model.dart';

class PurchaseItemModel {
  String sId;
  ProductModel product;
  double price;
  int quantity;
  bool checked;

  PurchaseItemModel({
    required this.sId,
    required this.product,
    required this.price,
    required this.quantity,
    required this.checked,
  });

  factory PurchaseItemModel.fromJson(Map<String, dynamic> json) {
    var model = PurchaseItemModel(
      sId: json['_id'],
      product: ProductModel.fromJson(json['product']),
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      checked: json['checked'],
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['product'] = this.product.toJson();
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['checked'] = this.checked;
    return data;
  }
}
