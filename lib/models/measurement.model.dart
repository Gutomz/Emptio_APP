import 'package:intl/intl.dart';

class MeasurementTypes {
  static const String Kg = 'Kg';
  static const String g = 'g';
  static const String L = 'L';
  static const String mL = 'ml';

  static List<String> list = [Kg, g, L, mL];
}

class MeasurementModel {
  String? sId;
  double value;
  String unit;

  MeasurementModel({
    this.sId,
    required this.value,
    required this.unit,
  });

  factory MeasurementModel.fromJson(Map<String, dynamic> json) {
    var model = MeasurementModel(
      sId: json['_id'],
      value: json['value'].toDouble(),
      unit: json['unit'],
    );

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['value'] = this.value;
    data['unit'] = this.unit;
    return data;
  }

  String toString() {
    return "${NumberFormat.decimalPattern('pt-Br').format(value)}$unit";
  }
}
