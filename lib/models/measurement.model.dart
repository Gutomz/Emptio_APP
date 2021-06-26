import 'package:intl/intl.dart';

class MeasurementTypes {
  static const String Kg = 'Kg';
  static const String g = 'g';
  static const String L = 'L';
  static const String mL = 'ml';

  static List<String> list = [Kg, g, L, mL];
}

class MeasurementModel {
  double value;
  String unit;

  MeasurementModel({
    required this.value,
    required this.unit,
  });

  factory MeasurementModel.fromJson(Map<String, dynamic> json) {
    var model = MeasurementModel(
      value: json['value'].toDouble(),
      unit: json['unit'],
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['unit'] = this.unit;
    return data;
  }

  String toString() {
    return "${NumberFormat.decimalPattern('pt-Br').format(value)}$unit";
  }
}
