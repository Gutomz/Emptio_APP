import 'package:emptio/data/database.dart';
import 'package:hive/hive.dart';

part 'base_purchase.g.dart';

@HiveType(typeId: Database.basePurchaseAdapterId)
class BasePurchase extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<int> itemsKey;

  @HiveField(2)
  String createdAt;

  @HiveField(3)
  String updatedAt;

  BasePurchase({
    required this.name,
    required this.itemsKey,
    required this.createdAt,
    required this.updatedAt,
  });
}
