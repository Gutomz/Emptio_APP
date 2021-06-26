import 'package:emptio/models/base_purchase_item.model.dart';

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
    var model = BasePurchaseModel(
      sId: json['_id'],
      name: json['name'],
      items: List.empty(growable: true),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );

    if (json['items'] != null) {
      json['items'].forEach((v) {
        model.items.add(BasePurchaseItemModel.fromJson(v));
      });
    }

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['items'] = this.items.map((v) => v.toJson()).toList();
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
