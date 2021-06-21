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
  late double value;
  late String unit;

  MeasurementModel({
    this.sId,
    required this.value,
    required this.unit,
  });

  MeasurementModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    value = json['value'].toDouble();
    unit = json['unit'];
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
