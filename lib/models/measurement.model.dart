class MeasurementTypes {
  static const String Kg = 'Kg';
  static const String g = 'g';
  static const String L = 'L';
  static const String mL = 'ml';
}

class MeasurementModel {
  String? sId;
  late int value;
  late String unit;

  MeasurementModel({
    this.sId,
    required this.value,
    required this.unit,
  });

  MeasurementModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    value = json['value'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['value'] = this.value;
    data['unit'] = this.unit;
    return data;
  }
}
