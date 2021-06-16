import 'package:emptio/data/database.dart';
import 'package:emptio/data/models/measurement/measurement.dart';
import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: Database.productAdapterId)
class Product extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String variation;

  @HiveField(2)
  String? image;

  @HiveField(3)
  Measurement weight;

  @HiveField(4)
  List<String> tags;

  @HiveField(5)
  String createdAt;

  @HiveField(6)
  String updatedAt;

  Product({
    required this.name,
    required this.variation,
    this.image,
    required this.weight,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });
}
