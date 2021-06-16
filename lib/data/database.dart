import 'package:emptio/data/models/market/market.dart';
import 'package:emptio/data/models/measurement/measurement.dart';
import 'package:emptio/data/models/product/product.dart';
import 'package:emptio/data/models/purchase/purchase.dart';
import 'package:emptio/data/models/purchase_item/purchase_item.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Database {
  static const String productBoxName = "products";
  static const String purchaseBoxName = "purchases";
  static const String marketBoxName = "markets";

  static const int measurementAdapterId = 0;
  static const int productAdapterId = 1;
  static const int marketAdapterId = 2;
  static const int purchaseItemAdapterId = 3;
  static const int purchaseAdapterId = 4;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MeasurementAdapter());
    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(MarketAdapter());
    Hive.registerAdapter(PurchaseItemAdapter());
    Hive.registerAdapter(PurchaseAdapter());
  }
}
