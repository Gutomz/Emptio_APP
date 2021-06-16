import 'package:emptio/data/database.dart';
import 'package:hive/hive.dart';

part 'market.g.dart';

@HiveType(typeId: Database.marketAdapterId)
class Market extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String? image;

  @HiveField(2)
  String createdAt;

  @HiveField(3)
  String updatedAt;

  Market({
    required this.name,
    this.image,
    required this.createdAt,
    required this.updatedAt,
  });
}
