import 'package:emptio/helpers/parsers.dart';

class ProductMarketModel {
  String sId;
  double price;
  String updatedAt;
  String? updatedBy;

  ProductMarketModel({
    required this.sId,
    required this.price,
    required this.updatedAt,
    this.updatedBy,
  });

  factory ProductMarketModel.fromJson(Map<String, dynamic> json) {
    final model = ProductMarketModel(
      sId: JsonParser.parseToString(json['_id']),
      price: JsonParser.parseToDouble(json['price']),
      updatedAt: JsonParser.parseToString(json['updatedAt']),
      updatedBy: JsonParser.parseToNullableString(json['updatedBy']['name']),
    );

    return model;
  }
}
