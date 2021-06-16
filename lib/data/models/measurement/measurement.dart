import 'package:emptio/data/database.dart';
import 'package:hive/hive.dart';

part 'measurement.g.dart';

@HiveType(typeId: Database.measurementAdapterId)
class Measurement extends HiveObject {
  @HiveField(0)
  double value;

  @HiveField(1)
  String unit;

  Measurement({required this.value, required this.unit});
}
