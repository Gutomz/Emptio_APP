import 'package:emptio/core/app_errors.dart';
import 'package:emptio/data/dao/purchase/purchase.dao.dart';
import 'package:emptio/data/dao/purchase_item/purchase_item.dao.dart';
import 'package:emptio/data/database.dart';
import 'package:emptio/data/database_errors.dart';
import 'package:emptio/data/models/measurement/measurement.dart';
import 'package:emptio/data/models/product/product.dart';
import 'package:emptio/data/models/purchase/purchase.dart';
import 'package:emptio/models/measurement.model.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/view-models/product_create.view-model.dart';
import 'package:emptio/view-models/product_filter.view-model.dart';
import 'package:hive/hive.dart';
import 'package:emptio/helpers/extensions.dart';

class ProductDao {
  static Box<Product>? _mBox;

  static Future<void> _openBox() async {
    if (_mBox == null) {
      _mBox = await Hive.openBox<Product>(Database.productBoxName);
    }
  }

  static Future<Box<Product>> get instance async {
    await _openBox();

    return _mBox!;
  }

  static Future<Product> create(ProductCreateViewModel model) async {
    await _openBox();

    String createAt = DateTime.now().toIso8601String();
    int key = await _mBox!.add(Product(
      brand: model.brand,
      name: model.name,
      variation: model.variation,
      image: model.image,
      tags: model.tags,
      weight: Measurement(value: model.weight.value, unit: model.weight.unit),
      createdAt: createAt,
      updatedAt: createAt,
    ));

    return _mBox!.get(key)!;
  }

  static Future<List<Product>> getAll(ProductFilterViewModel filter) async {
    await _openBox();
    // String marketId = "";
    List<int> excludeIds = List.empty(growable: true);
    if (filter.purchaseId.isNotEmpty) {
      Purchase purchase = await PurchaseDao.get(int.parse(filter.purchaseId));
      for (var itemKey in purchase.itemsKey) {
        var productKey = (await PurchaseItemDao.get(itemKey)).productKey;
        excludeIds.add(productKey);
      }
      // TODO - get market_id from purchase to get market product relation
    }

    print(_mBox!.values);

    Iterable<Product> list = _mBox!.values;

    filter.search = filter.search.toLowerCase();

    List<Product> products = (list.where((product) {
      if (excludeIds.contains(product.key)) {
        return false;
      }

      if (product.name.toLowerCase().contains(filter.search) ||
          product.tags.containElement(
              (tag) => tag.replaceAll("-", " ").contains(filter.search)) ||
          product.brand.toLowerCase().contains(filter.search)) {
        return true;
      }

      return false;
    }).toList())
      ..skip(filter.skip).take(filter.limit);

    // TODO - add product market relation price to each product

    return products;
  }

  static Future<Product> get(int key) async {
    await _openBox();

    Product? product = _mBox!.get(key);

    if (product != null) {
      return product;
    }

    throw DatabaseError.notFoundError(AppErrors.PRODUCT_NOT_FOUND);
  }

  static Future<ProductModel> createParsed(ProductCreateViewModel model) async {
    Product product = await create(model);

    return await parseToProductModel(product);
  }

  static Future<List<ProductModel>> getAllParsed(
      ProductFilterViewModel filter) async {
    List<ProductModel> models = List.empty(growable: true);
    List<Product> products = await getAll(filter);
    for (Product product in products) {
      ProductModel model = await parseToProductModel(product);
      models.add(model);
    }

    return models;
  }

  static Future<ProductModel> getParsed(int key) async {
    Product product = await get(key);

    return await parseToProductModel(product);
  }

  static Future<ProductModel> parseToProductModel(Product product) async {
    return ProductModel(
      sId: product.key.toString(),
      brand: product.brand,
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
