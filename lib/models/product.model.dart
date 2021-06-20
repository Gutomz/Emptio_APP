import 'package:emptio/core/app_api.dart';
import 'package:emptio/models/measurement.model.dart';

class ProductModel {
  String? sId;
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
    this.sId,
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

  ProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    variation = json['variation'];
    image = json['image'] != null && json['image'].isNotEmpty
        ? AppApi.getUrl(json['image'])
        : null;
    weight = MeasurementModel.fromJson(json['weight']);
    tags = json['tags'].cast<String>();
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    if (json['productMarket'] != null) {
      marketPrice = json['productMarket']['price']?.toDouble();
      marketPriceUpdatedAt = json['productMarket']['updatedAt'];
      marketPriceUpdatedBy = json['productMarket']['updatedBy']['name'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
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
