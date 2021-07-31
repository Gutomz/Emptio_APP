import 'package:emptio/data/database.dart';
import 'package:emptio/data/models/measurement/measurement.dart';
import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: Database.productAdapterId)
class Product extends HiveObject {
  @HiveField(0)
  String brand;

  @HiveField(1)
  String name;

  @HiveField(2)
  String variation;

  @HiveField(3)
  String? image;

  @HiveField(4)
  Measurement weight;

  @HiveField(5)
  List<String> tags;

  @HiveField(6)
  String createdAt;

  @HiveField(7)
  String updatedAt;

  @HiveField(8)
  double? marketPrice;

  @HiveField(9)
  String? marketPriceUpdatedAt;

  @HiveField(10)
  bool deleted = false;
  

  Product({
    required this.brand,
    required this.name,
    required this.variation,
    this.image,
    required this.weight,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    this.marketPrice,
    this.marketPriceUpdatedAt,
  });
}
