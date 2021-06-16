import 'package:emptio/data/database.dart';
import 'package:emptio/data/models/product/product.dart';
import 'package:emptio/models/measurement.model.dart';
import 'package:emptio/models/product.model.dart';
import 'package:hive/hive.dart';

class ProductDao {
  Box<Product>? _mBox;

  Future<void> openBox() async {
    if (_mBox == null) {
      _mBox = await Hive.openBox<Product>(Database.productBoxName);
    }
  }

  Future<ProductModel> get(int key) async {
    await openBox();

    Product? product = _mBox!.get(key);

    if (product != null) {
      return parseToProductModel(product);
    }

    // TODO - create error structure
    throw {
      "code": "product_not_found",
    };
  }

  Future<ProductModel> parseToProductModel(Product product) async {
    return ProductModel(
      sId: product.key.toString(),
      name: product.name,
      variation: product.variation,
      tags: product.tags,
      weight: MeasurementModel(
        sId: product.key.toString(),
        unit: product.weight.unit,
        value: product.weight.value,
      ),
      image: product.image,
      createdAt: product.createdAt,
      updatedAt: product.updatedAt,
    );
  }
}
