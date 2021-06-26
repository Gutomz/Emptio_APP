import 'package:emptio/core/app_errors.dart';
import 'package:emptio/data/dao/product/product.dao.dart';
import 'package:emptio/data/database.dart';
import 'package:emptio/data/database_errors.dart';
import 'package:emptio/data/models/base_purchase_item/base_purchase_item.dart';
import 'package:emptio/data/models/product/product.dart';
import 'package:emptio/models/base_purchase_item.model.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/view-models/add_base_purchase_item.view-model.dart';
import 'package:hive/hive.dart';

class BasePurchaseItemDao {
  static Box<BasePurchaseItem>? _mBox;

  static Future<void> _openBox() async {
    if (_mBox == null) {
      _mBox = await Hive.openBox<BasePurchaseItem>(
          Database.basePurchaseItemsBoxName);
    }
  }

  static Future<Box<BasePurchaseItem>> get instance async {
    await _openBox();

    return _mBox!;
  }

  static Future<BasePurchaseItem> create(
      AddBasePurchaseItemViewModel model) async {
    await _openBox();
    Box<Product> productBox = await ProductDao.instance;

    Product? product;
    if (model.productId != null) {
      product = productBox.get(int.parse(model.productId!));
    } else {
      var productKey = (await ProductDao.create(model.productModel!)).key;
      product = productBox.get(productKey);
    }

    if (product == null)
      throw DatabaseError.notFoundError(AppErrors.PRODUCT_NOT_FOUND);

    var itemKey = await _mBox!.add(BasePurchaseItem(
      productKey: product.key,
      quantity: model.quantity,
    ));

    return _mBox!.get(itemKey)!;
  }

  static Future<void> deleteItem(int key) async {
    await _openBox();
    return _mBox!.delete(key);
  }

  static Future<BasePurchaseItem> get(int key) async {
    await _openBox();
    BasePurchaseItem? item = _mBox!.get(key);

    if (item == null)
      throw DatabaseError.notFoundError(AppErrors.PURCHASE_ITEM_NOT_FOUND);

    return item;
  }

  static Future<BasePurchaseItemModel> getParsed(int key) async {
    var item = await get(key);
    return await parseToBasePurchaseItemModel(item);
  }

  static Future<BasePurchaseItemModel> parseToBasePurchaseItemModel(
      BasePurchaseItem item) async {
    ProductModel product = await ProductDao.getParsed(item.productKey);

    return BasePurchaseItemModel(
      sId: item.key.toString(),
      quantity: item.quantity,
      product: product,
    );
  }
}
