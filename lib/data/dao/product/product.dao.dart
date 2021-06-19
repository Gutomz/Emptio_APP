import 'package:emptio/core/app_errors.dart';
import 'package:emptio/data/database.dart';
import 'package:emptio/data/database_errors.dart';
import 'package:emptio/data/models/measurement/measurement.dart';
import 'package:emptio/data/models/product/product.dart';
import 'package:emptio/models/measurement.model.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/view-models/product_create.view-model.dart';
import 'package:emptio/view-models/product_filter.view-model.dart';
import 'package:hive/hive.dart';

class ProductDao {
  Box<Product>? _mBox;

  Future<void> _openBox() async {
    if (_mBox == null) {
      _mBox = await Hive.openBox<Product>(Database.productBoxName);
    }
  }

  Future<Box<Product>> get instance async {
    await _openBox();

    return _mBox!;
  }

  Future<ProductModel> create(ProductCreateViewModel model) async {
    await _openBox();

    String createAt = DateTime.now().toIso8601String();
    int key = await _mBox!.add(Product(
      name: model.name,
      variation: model.variation,
      image: model.image,
      tags: model.tags,
      weight: Measurement(value: model.weight.value, unit: model.weight.unit),
      createdAt: createAt,
      updatedAt: createAt,
    ));

    return parseToProductModel(_mBox!.get(key)!);
  }

  Future<List<ProductModel>> getAll(ProductFilterViewModel filter) async {
    await _openBox();
    List<ProductModel> models = List.empty(growable: true);

    String marketId = "";
    List<int> excludeIds = List.empty(growable: true);
    if (filter.purchaseId.isNotEmpty) {
      // TODO - get market_id and exclude products from purchase
    }

    List<Product> products = (_mBox!.values.where((element) {
      if (filter.search.contains(element.name) ||
          element.tags.contains((tag) => filter.search.contains(tag))) {
        return true;
      }

      return false;
    }).toList())
      ..skip(filter.skip).take(filter.limit);

    for (Product product in products) {
      ProductModel model = await parseToProductModel(product);

      // TODO - add product market relation price to model

      models.add(model);
    }

    return models;
  }

  Future<ProductModel> get(int key) async {
    await _openBox();

    Product? product = _mBox!.get(key);

    if (product != null) {
      return parseToProductModel(product);
    }

    throw DatabaseError.notFoundError(AppErrors.PRODUCT_NOT_FOUND);
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
      marketPrice: product.marketPrice,
      marketPriceUpdatedAt: product.marketPriceUpdatedAt,
    );
  }
}
