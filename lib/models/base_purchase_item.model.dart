import 'package:emptio/helpers/parsers.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/models/purchase_item.model.dart';

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
    final model = BasePurchaseItemModel(
      sId: JsonParser.parseToString(json['_id']),
      product: JsonParser.parseToProduct(json['product'])!,
      quantity: JsonParser.parseToInt(json['quantity']),
    );

    return model;
  }

  factory BasePurchaseItemModel.fromPurchaseItem(
      PurchaseItemModel purchaseItemModel) {
    final model = BasePurchaseItemModel(
      sId: purchaseItemModel.sId,
      product: purchaseItemModel.product,
      quantity: purchaseItemModel.quantity,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['product'] = product.toJson();
    data['quantity'] = quantity;
    return data;
  }
}
