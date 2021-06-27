import 'package:emptio/data/database.dart';
import 'package:hive/hive.dart';

part 'product_market.g.dart';

@HiveType(typeId: Database.productMarketAdapterId)
class ProductMarket extends HiveObject {
  @HiveField(0)
  int productKey;

  @HiveField(1)
  int marketKey;

  @HiveField(2)
  double price;

  @HiveField(3)
  String updatedAt;

  ProductMarket({
    required this.productKey,
    required this.marketKey,
    required this.price,
    required this.updatedAt,
  });
}
