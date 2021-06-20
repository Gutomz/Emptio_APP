import 'package:emptio/data/database.dart';
import 'package:hive/hive.dart';

part 'purchase_item.g.dart';

@HiveType(typeId: Database.purchaseItemAdapterId)
class PurchaseItem extends HiveObject {
  @HiveField(0)
  int productKey;

  @HiveField(1)
  double price;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  bool checked;

  PurchaseItem({
    required this.productKey,
    required this.price,
    required this.quantity,
    this.checked = false,
  });
}
