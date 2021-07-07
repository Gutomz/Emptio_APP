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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand'] = brand;
    data['name'] = name;
    data['variation'] = variation;
    data['weight'] = weight.toJson();
    data['tags'] = tags;
    data['image'] = image;
    return data;
  }
}
