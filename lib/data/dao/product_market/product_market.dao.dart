import 'package:emptio/data/database.dart';
import 'package:emptio/data/models/product_market/product_market.dart';
import 'package:hive/hive.dart';
import 'package:emptio/helpers/extensions.dart';

class ProductMarketDao {
  static Box<ProductMarket>? _mBox;

  static Future<void> _openBox() async {
    _mBox ??= await Hive.openBox<ProductMarket>(Database.productMarketBoxName);
  }

  static Future<Box<ProductMarket>> get instance async {
    await _openBox();

    return _mBox!;
  }

  static Future<ProductMarket> create({
    required int productKey,
    required int marketKey,
    required double price,
  }) async {
    await _openBox();

    final key = _mBox!.add(ProductMarket(
      marketKey: marketKey,
      productKey: productKey,
      price: price,
      updatedAt: DateTime.now().toIso8601String(),
    ));

    return _mBox!.get(key)!;
  }

  static Future<ProductMarket> update({
    required int productKey,
    required int marketKey,
    required double price,
  }) async {
    await _openBox();

    final productMarket = await find(
      marketKey: marketKey,
      productKey: productKey,
    );

    int key;
    if (productMarket != null) {
      if (productMarket.price != price) {
        productMarket.price = price;
        productMarket.updatedAt = DateTime.now().toIso8601String();

        await productMarket.save();
      }

      key = productMarket.key as int;
    } else {
      key = (await create(
        productKey: productKey,
        marketKey: marketKey,
        price: price,
      ))
          .key as int;
    }

    return _mBox!.get(key)!;
  }

  static Future<ProductMarket?> find({
    required int marketKey,
    required int productKey,
  }) async {
    await _openBox();

    return _mBox!.values.safeFirstWhere(
        (e) => e.productKey == productKey && e.marketKey == marketKey);
  }
}
