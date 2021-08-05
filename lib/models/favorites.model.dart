import 'package:emptio/helpers/parsers.dart';
import 'package:emptio/models/market.model.dart';
import 'package:emptio/models/product.model.dart';

class FavoritesModel {
  String sId;
  ProductModel product;
  List<MarketModel> markets;
  String createdAt;
  String updatedAt;

  FavoritesModel({
    required this.sId,
    required this.product,
    required this.markets,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) {
    final model = FavoritesModel(
      sId: JsonParser.parseToString(json['_id']),
      product: JsonParser.parseToProduct(json['product'])!,
      markets: JsonParser.parseToMarketList(json['markets']),
      createdAt: JsonParser.parseToString(json['createdAt']),
      updatedAt: JsonParser.parseToString(json['updatedAt']),
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['product'] = product.toJson();
    data['markets'] = markets.map((e) => e.toJson());
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
