import 'package:emptio/helpers/parsers.dart';
import 'package:emptio/models/measurement.model.dart';
import 'package:emptio/models/product_market.model.dart';

class ProductModel {
  String sId;
  late String brand;
  late String name;
  late String variation;
  String? image;
  late MeasurementModel weight;
  late List<String> tags;
  late String updatedAt;
  late String createdAt;

  ProductMarketModel? marketDetails;

  ProductModel({
    required this.sId,
    required this.brand,
    required this.name,
    required this.variation,
    this.image,
    required this.weight,
    required this.tags,
    required this.updatedAt,
    required this.createdAt,
    this.marketDetails,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final model = ProductModel(
      sId: JsonParser.parseToString(json['_id']),
      brand: JsonParser.parseToString(json['brand']),
      name: JsonParser.parseToString(json['name']),
      variation: JsonParser.parseToString(json['variation']),
      image: JsonParser.parseToImageUrl(json['image']),
      weight: JsonParser.parseToMeasurement(json['weight'])!,
      tags: JsonParser.parseToStringList(json['tags']),
      marketDetails: JsonParser.parseToProductMarket(json['productMarket']),
      updatedAt: JsonParser.parseToString(json['updatedAt']),
      createdAt: JsonParser.parseToString(json['createdAt']),
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['brand'] = brand;
    data['name'] = name;
    data['variation'] = variation;
    data['image'] = image;
    data['weight'] = weight.toJson();
    data['tags'] = tags;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }

  String getCombinedName() {
    return "$name${variation.isNotEmpty ? " - $variation" : ""}";
  }
}
