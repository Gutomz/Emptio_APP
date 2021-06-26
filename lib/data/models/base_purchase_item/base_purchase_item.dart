import 'package:emptio/data/database.dart';
import 'package:hive/hive.dart';

part 'base_purchase_item.g.dart';

@HiveType(typeId: Database.basePurchaseItemAdapterId)
class BasePurchaseItem extends HiveObject {
  @HiveField(0)
  int productKey;

  @HiveField(1)
  int quantity;

  BasePurchaseItem({
    required this.productKey,
    required this.quantity,
  });
}
