import 'package:emptio/helpers/parsers.dart';
import 'package:emptio/models/base_purchase_item.model.dart';
import 'package:emptio/models/purchase.model.dart';

class BasePurchaseModel {
  String sId;
  String name;
  List<BasePurchaseItemModel> items;
  String createdAt;
  String updatedAt;

  BasePurchaseModel({
    required this.sId,
    required this.name,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BasePurchaseModel.fromJson(Map<String, dynamic> json) {
    final model = BasePurchaseModel(
      sId: JsonParser.parseToString(json['_id']),
      name: JsonParser.parseToString(json['name']),
      items: JsonParser.parseToBasePurchaseItemList(json['items']),
      createdAt: JsonParser.parseToString(json['createdAt']),
      updatedAt: JsonParser.parseToString(json['updatedAt']),
    );

    return model;
  }

  factory BasePurchaseModel.fromPurchase(
    PurchaseModel purchaseModel, {
    String name = "Cópia da lista",
  }) {
    final model = BasePurchaseModel(
      sId: purchaseModel.sId,
      name: name,
      items: purchaseModel.items
          .map<BasePurchaseItemModel>(
              (e) => BasePurchaseItemModel.fromPurchaseItem(e))
          .toList(),
      createdAt: purchaseModel.createdAt,
      updatedAt: purchaseModel.updatedAt,
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['items'] = items.map((v) => v.toJson()).toList();
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
