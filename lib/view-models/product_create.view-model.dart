import 'package:emptio/models/measurement.model.dart';

class ProductCreateViewModel {
  String brand;
  String name;
  String variation;
  MeasurementModel weight;
  List<String> tags;
  String? image;

  ProductCreateViewModel({
    required this.brand,
    required this.name,
    required this.variation,
    required this.weight,
    required this.tags,
    this.image,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand'] = this.brand;
    data['name'] = this.name;
    data['variation'] = this.variation;
    data['weight'] = this.weight.toJson();
    data['tags'] = this.tags;
    data['image'] = this.image;
    return data;
  }
}
