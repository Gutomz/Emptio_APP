import 'package:emptio/core/app_errors.dart';
import 'package:emptio/data/dao/base_purchase.dao.dart';
import 'package:emptio/data/dao/base_purchase_item.dao.dart';
import 'package:emptio/data/dao/product_market.dao.dart';
import 'package:emptio/data/dao/purchase.dao.dart';
import 'package:emptio/data/dao/purchase_item.dao.dart';
import 'package:emptio/data/database.dart';
import 'package:emptio/data/database_errors.dart';
import 'package:emptio/data/models/measurement/measurement.dart';
import 'package:emptio/data/models/product/product.dart';
import 'package:emptio/data/models/purchase/purchase.dart';
import 'package:emptio/models/measurement.model.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/models/product_market.model.dart';
import 'package:emptio/view-models/product_create.view-model.dart';
import 'package:emptio/view-models/product_filter.view-model.dart';
import 'package:hive/hive.dart';
import 'package:emptio/helpers/extensions.dart';

class ProductDao {
  static Box<Product>? _mBox;

  static Future<void> _openBox() async {
    _mBox ??= await Hive.openBox<Product>(Database.productBoxName);
  }

  static Future<Box<Product>> get instance async {
    await _openBox();

    return _mBox!;
  }

  static Future<Product> create(ProductCreateViewModel model) async {
    await _openBox();

    final String createAt = DateTime.now().toIso8601String();
    final int key = await _mBox!.add(Product(
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

  static Future<void> delete(int key) async {
    await _openBox();

    final product = _mBox!.get(key);

    if (product == null) {
      throw DatabaseError.notFoundError(AppErrors.productNotFound);
    }

    product.deleted = true;
    await product.save();
  }

  static Future<List<Product>> getAll(ProductFilterViewModel filter) async {
    await _openBox();
    int? marketKey;
    final List<int> excludeIds = List.empty(growable: true);
    if (filter.purchaseId.isNotEmpty) {
      final Purchase purchase =
          await PurchaseDao.get(int.parse(filter.purchaseId));

      for (final itemKey in purchase.itemsKey) {
        final productKey = (await PurchaseItemDao.get(itemKey)).productKey;
        excludeIds.add(productKey);
      }
      marketKey = purchase.marketKey;
    } else if (filter.basePurchaseId.isNotEmpty) {
      final purchase =
          await BasePurchaseDao.get(int.parse(filter.basePurchaseId));

      for (final itemKey in purchase.itemsKey) {
        final productKey = (await BasePurchaseItemDao.get(itemKey)).productKey;
        excludeIds.add(productKey);
      }
    }

    final Iterable<Product> list = _mBox!.values;

    filter.search = filter.search.toLowerCase();

    final List<Product> products = (list.where((product) {
      if (product.deleted) {
        return false;
      }

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

    if (marketKey != null) {
      for (final product in products) {
        final productMarket = await ProductMarketDao.find(
          marketKey: marketKey,
          productKey: product.key as int,
        );

        product.marketDetails = productMarket;
      }
    }

    return products;
  }

  static Future<Product> get(int key) async {
    await _openBox();

    final Product? product = _mBox!.get(key);

    if (product != null) {
      return product;
    }

    throw DatabaseError.notFoundError(AppErrors.productNotFound);
  }

  static Future<ProductModel> createParsed(ProductCreateViewModel model) async {
    final Product product = await create(model);
    return parseToProductModel(product);
  }

  static Future<List<ProductModel>> getAllParsed(
      ProductFilterViewModel filter) async {
    final List<ProductModel> models = List.empty(growable: true);
    final List<Product> products = await getAll(filter);
    for (final product in products) {
      final ProductModel model = await parseToProductModel(product);
      models.add(model);
    }

    return models;
  }

  static Future<ProductModel> getParsed(int key, {int index = 0}) async {
    final Product product = await get(key);
    return parseToProductModel(product, index: index);
  }

  static Future<ProductModel> parseToProductModel(Product product,
      {int index = 0}) async {
    ProductMarketModel? marketDetails;
    if (index == 0) {
      marketDetails = await ProductMarketDao.parseToProductMarketModel(
        product.marketDetails,
        index: index + 1,
      );
    }

    return ProductModel(
      sId: product.key.toString(),
      brand: product.brand,
      name: product.name,
      variation: product.variation,
      tags: product.tags,
      weight: MeasurementModel(
        unit: product.weight.unit,
        value: product.weight.value,
      ),
      image: product.image,
      createdAt: product.createdAt,
      updatedAt: product.updatedAt,
      marketDetails: marketDetails,
    );
  }
}
