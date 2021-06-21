import 'package:emptio/data/database.dart';
import 'package:hive/hive.dart';

part 'purchase.g.dart';

@HiveType(typeId: Database.purchaseAdapterId)
class Purchase extends HiveObject {
  @HiveField(0)
  String status;

  @HiveField(1)
  double limit;

  @HiveField(2)
  int? marketKey;

  @HiveField(3)
  List<int> itemsKey;

  @HiveField(4)
  String createdAt;

  @HiveField(5)
  String updatedAt;

  Purchase({
    required this.status,
    required this.limit,
    this.marketKey,
    required this.itemsKey,
    required this.createdAt,
    required this.updatedAt,
  });
}
