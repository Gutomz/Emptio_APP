import 'package:emptio/models/product.model.dart';

class PurchaseItemModel {
  late String sId;
  late ProductModel product;
  late double price;
  late int quantity;
  late bool checked;

  PurchaseItemModel({
    required this.sId,
    required this.product,
    required this.price,
    required this.quantity,
    required this.checked,
  });

  PurchaseItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product = ProductModel.fromJson(json['product']);
    price = json['price'].toDouble();
    quantity = json['quantity'];
    checked = json['checked'];
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
