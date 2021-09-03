import 'package:emptio/helpers/parsers.dart';
import 'package:emptio/models/product.model.dart';

class PurchaseItemModel {
  String sId;
  ProductModel product;
  double price;
  int quantity;
  bool checked;

  String? completedProductMarket;

  PurchaseItemModel({
    required this.sId,
    required this.product,
    required this.price,
    required this.quantity,
    required this.checked,
    this.completedProductMarket,
  });

  factory PurchaseItemModel.fromJson(Map<String, dynamic> json) {
    final model = PurchaseItemModel(
      sId: JsonParser.parseToString(json['_id']),
      product: JsonParser.parseToProduct(json['product'])!,
      price: JsonParser.parseToDouble(json['price']),
      quantity: JsonParser.parseToInt(json['quantity']),
      checked: JsonParser.parseToBool(json['checked']),
      completedProductMarket:
          JsonParser.parseToString(json["completedProductMarket"]),
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['product'] = product.toJson();
    data['price'] = price;
    data['quantity'] = quantity;
    data['checked'] = checked;
    return data;
  }

  @override
  int get hashCode => sId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseItemModel && sId == other.sId);
}
