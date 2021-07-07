import 'package:emptio/helpers/parsers.dart';
import 'package:emptio/models/market.model.dart';
import 'package:emptio/models/purchase_item.model.dart';

class PurchaseStatusTypes {
  static const String open = 'open';
  static const String closed = 'closed';
}

class PurchaseModel {
  String sId;
  String status;
  double cost;
  double estimatedCost;
  double limit;
  MarketModel? market;
  List<PurchaseItemModel> items;
  String updatedAt;
  String createdAt;

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

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {
    final model = PurchaseModel(
      sId: JsonParser.parseToString(json['_id']),
      status: JsonParser.parseToString(json['status']),
      cost: JsonParser.parseToDouble(json['cost']),
      estimatedCost: JsonParser.parseToDouble(json['estimatedCost']),
      limit: JsonParser.parseToDouble(json['limit']),
      market: JsonParser.parseToMarket(json['market']),
      items: JsonParser.parseToPurchaseItemList(json['items']),
      updatedAt: JsonParser.parseToString(json['updatedAt']),
      createdAt: JsonParser.parseToString(json['createdAt']),
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['status'] = status;
    data['cost'] = cost;
    data['estimatedCost'] = estimatedCost;
    data['limit'] = limit;
    if (market != null) {
      data['market'] = market!.toJson();
    }
    data['items'] = items.map((v) => v.toJson()).toList();
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
}
