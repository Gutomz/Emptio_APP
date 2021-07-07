import 'package:emptio/core/app_errors.dart';
import 'package:emptio/data/dao/product/product.dao.dart';
import 'package:emptio/data/database.dart';
import 'package:emptio/data/database_errors.dart';
import 'package:emptio/data/models/product/product.dart';
import 'package:emptio/data/models/purchase_item/purchase_item.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/models/purchase_item.model.dart';
import 'package:emptio/view-models/add_purchase_item.view-model.dart';
import 'package:hive/hive.dart';

class PurchaseItemDao {
  static Box<PurchaseItem>? _mBox;

  static Future<void> _openBox() async {
    _mBox ??= await Hive.openBox<PurchaseItem>(Database.purchaseItemsBoxName);
  }

  static Future<Box<PurchaseItem>> get instance async {
    await _openBox();

    return _mBox!;
  }

  static Future<PurchaseItem> create(AddPurchaseItemViewModel model) async {
    await _openBox();
    final Box<Product> productBox = await ProductDao.instance;

    Product? product;
    if (model.productId != null) {
      product = productBox.get(int.parse(model.productId!));
    } else {
      final productKey = (await ProductDao.create(model.productModel!)).key;
      product = productBox.get(productKey);
    }

    if (product == null) {
      throw DatabaseError.notFoundError(AppErrors.productNotFound);
    }

    final itemKey = await _mBox!.add(PurchaseItem(
      productKey: product.key as int,
      price: model.price,
      quantity: model.quantity,
    ));

    return _mBox!.get(itemKey)!;
  }

  static Future<void> deleteItem(int key) async {
    await _openBox();
    return _mBox!.delete(key);
  }

  static Future<PurchaseItem> get(int key) async {
    await _openBox();
    final PurchaseItem? item = _mBox!.get(key);

    if (item == null) {
      throw DatabaseError.notFoundError(AppErrors.purchaseItemNotFound);
    }

    return item;
  }

  static Future<PurchaseItemModel> getParsed(int key) async {
    final item = await get(key);
    return parseToPurchaseItemModel(item);
  }

  static Future<PurchaseItemModel> parseToPurchaseItemModel(
      PurchaseItem item) async {
    final ProductModel product = await ProductDao.getParsed(item.productKey);

    return PurchaseItemModel(
      sId: item.key.toString(),
      price: item.price,
      quantity: item.quantity,
      checked: item.checked,
      product: product,
    );
  }
}
