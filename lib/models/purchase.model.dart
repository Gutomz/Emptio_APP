import 'package:emptio/models/market.model.dart';
import 'package:emptio/models/purchase_item.model.dart';

class PurchaseStatusTypes {
  static const String OPEN = 'open';
  static const String CLOSED = 'closed';
}

class PurchaseModel {
  late String sId;
  late String status;
  late double cost;
  late double estimatedCost;
  late double limit;
  MarketModel? market;
  late List<PurchaseItemModel> items;
  late String updatedAt;
  late String createdAt;

  PurchaseModel({
    required this.sId,
    required this.status,
    required this.cost,
    required this.estimatedCost,
    required this.limit,
    this.market,
    required this.items,
    required this.updatedAt,
    required this.createdAt,
  });

  PurchaseModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    cost = json['cost'].toDouble();
    estimatedCost = json['estimatedCost'].toDouble();
    limit = json['limit'].toDouble();
    market = json['market'] != null && json['image'] != ""
        ? MarketModel.fromJson(json['market'])
        : null;
    items = List<PurchaseItemModel>.empty(growable: true);
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(new PurchaseItemModel.fromJson(v));
      });
    }
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['cost'] = this.cost;
    data['estimatedCost'] = this.estimatedCost;
    data['limit'] = this.limit;
    if (this.market != null) {
      data['market'] = this.market!.toJson();
    }
    data['items'] = this.items.map((v) => v.toJson()).toList();
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
