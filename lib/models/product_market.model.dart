import 'package:emptio/helpers/parsers.dart';
import 'package:emptio/models/market.model.dart';
import 'package:emptio/models/product.model.dart';

class ProductMarketModel {
  String sId;
  ProductModel product;
  MarketModel market;
  double price;
  String updatedAt;
  String? updatedBy;

  ProductMarketModel({
    required this.sId,
    required this.product,
    required this.market,
    required this.price,
    required this.updatedAt,
    this.updatedBy,
  });

  factory ProductMarketModel.fromJson(Map<String, dynamic> json) {
    final model = ProductMarketModel(
      sId: JsonParser.parseToString(json['_id']),
      product: JsonParser.parseToProduct(json["product"])!,
      market: JsonParser.parseToMarket(json["market"])!,
      price: JsonParser.parseToDouble(json['price']),
      updatedAt: JsonParser.parseToString(json['updatedAt']),
      updatedBy: JsonParser.parseToNullableString(json['updatedBy']['name']),
    );

    return model;
  }
}
