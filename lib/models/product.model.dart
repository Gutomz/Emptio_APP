import 'package:emptio/core/app_api.dart';
import 'package:emptio/models/measurement.model.dart';

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

  double? marketPrice;
  String? marketPriceUpdatedAt;
  String? marketPriceUpdatedBy;

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
    this.marketPrice,
    this.marketPriceUpdatedAt,
    this.marketPriceUpdatedBy,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    var model = ProductModel(
      sId: json['_id'],
      brand: json['brand'],
      name: json['name'],
      variation: json['variation'],
      image: json['image'] != null && json['image'].isNotEmpty
          ? AppApi.getUrl(json['image'])
          : null,
      weight: MeasurementModel.fromJson(json['weight']),
      tags: json['tags'].cast<String>(),
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
    );

    if (json['productMarket'] != null) {
      model.marketPrice = json['productMarket']['price']?.toDouble();
      model.marketPriceUpdatedAt = json['productMarket']['updatedAt'];
      model.marketPriceUpdatedBy = json['productMarket']['updatedBy']['name'];
    }

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['brand'] = this.brand;
    data['name'] = this.name;
    data['variation'] = this.variation;
    data['image'] = this.image;
    data['weight'] = this.weight.toJson();
    data['tags'] = this.tags;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }

  String getCombinedName() {
    return "$name${variation.isNotEmpty ? " - $variation" : ""}";
  }
}
