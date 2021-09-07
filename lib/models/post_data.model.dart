import 'package:emptio/helpers/parsers.dart';
import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/models/product_market.model.dart';

class PostDataTypes {
  static const String productMarket = 'product_market';
  static const String purchase = 'purchase';

  static List<String> list = [productMarket, purchase];

  static String formatString(String type) {
    switch (type) {
      case purchase:
        return 'compra';
      case productMarket:
      default:
        return 'produto';
    }
  }
}

class PostDataModel {
  String type;
  ProductMarketModel? productMarket;
  BasePurchaseModel? purchase;

  PostDataModel({
    required this.type,
    required this.productMarket,
    required this.purchase,
  });

  factory PostDataModel.fromJson(Map<String, dynamic> json) {
    final model = PostDataModel(
      type: JsonParser.parseToString(json["type"]),
      productMarket: JsonParser.parseToProductMarket(json["productMarket"]),
      purchase: JsonParser.parseToBasePurchase(json["purchase"]),
    );

    return model;
  }
}
