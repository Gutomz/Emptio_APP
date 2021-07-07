import 'package:emptio/helpers/parsers.dart';
import 'package:intl/intl.dart';

class MeasurementTypes {
  static const String kg = 'Kg';
  static const String g = 'g';
  static const String L = 'L';
  static const String mL = 'ml';

  static List<String> list = [kg, g, L, mL];
}

class MeasurementModel {
  double value;
  String unit;

  MeasurementModel({
    required this.value,
    required this.unit,
  });

  factory MeasurementModel.fromJson(Map<String, dynamic> json) {
    final model = MeasurementModel(
      value: JsonParser.parseToDouble(json['value']),
      unit: JsonParser.parseToString(json['unit']),
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['unit'] = unit;
    return data;
  }

  @override
  String toString() {
    return "${NumberFormat.decimalPattern('pt-Br').format(value)}$unit";
  }
}
