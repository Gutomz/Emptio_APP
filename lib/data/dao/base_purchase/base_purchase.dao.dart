import 'package:emptio/core/app_errors.dart';
import 'package:emptio/data/dao/base_purchase_item/base_purchase_item.dao.dart';
import 'package:emptio/data/database.dart';
import 'package:emptio/data/database_errors.dart';
import 'package:emptio/data/models/base_purchase/base_purchase.dart';
import 'package:emptio/data/models/base_purchase_item/base_purchase_item.dart';
import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/models/base_purchase_item.model.dart';
import 'package:emptio/view-models/add_base_purchase_item.view-model.dart';
import 'package:emptio/view-models/base_purchase_filter.view-model.dart';
import 'package:emptio/view-models/update_base_purchase_item.view-model.dart';
import 'package:hive/hive.dart';

class BasePurchaseDao {
  static Box<BasePurchase>? _mBox;

  static Future<void> _openBox() async {
    if (_mBox == null) {
      _mBox = await Hive.openBox<BasePurchase>(Database.basePurchaseBoxName);
    }
  }

  static Future<BasePurchase> create() async {
    await _openBox();

    final createdAt = DateTime.now().toIso8601String();
    int key = await _mBox!.add(BasePurchase(
      name: 'Unamed',
      itemsKey: List.empty(growable: true),
      createdAt: createdAt,
      updatedAt: createdAt,
    ));

    return _mBox!.get(key)!;
  }

  static Future<void> delete(int key) async {
    await _openBox();
    BasePurchase? purchase = _mBox!.get(key);

    if (purchase != null) {
      for (int itemKey in purchase.itemsKey) {
        await BasePurchaseItemDao.deleteItem(itemKey);
      }
    }

    return await _mBox!.delete(key);
  }

  static Future<BasePurchase> get(int key) async {
    await _openBox();
    var purchase = _mBox!.get(key);

    if (purchase == null)
      throw DatabaseError.notFoundError(AppErrors.PURCHASE_NOT_FOUND);

    return purchase;
  }

  static Future<List<BasePurchase>> getAll(
      BasePurchasesFilterViewModel filter) async {
    await _openBox();

    List<BasePurchase> purchases = (_mBox!.values
            .where((element) => element.name.contains(filter.search))
            .toList()
              ..sort((a, b) {
                if (filter.orderBy != null &&
                    filter.orderBy!.contains('updatedAt')) {
                  if (filter.isDesc) {
                    return b.updatedAt.compareTo(a.updatedAt);
                  }
                  return a.updatedAt.compareTo(b.updatedAt);
                }

                if (filter.isDesc) {
                  return b.createdAt.compareTo(a.createdAt);
                }

                return a.createdAt.compareTo(b.createdAt);
              }))
        .skip(filter.skip)
        .take(filter.limit)
        .toList();

    return purchases;
  }

  static Future<BasePurchase> addItem(
      int key, AddBasePurchaseItemViewModel model) async {
    await _openBox();
    BasePurchase? purchase = _mBox!.get(key);

    if (purchase == null)
      throw DatabaseError.notFoundError(AppErrors.PURCHASE_NOT_FOUND);

    var item = await BasePurchaseItemDao.create(model);

    purchase.itemsKey.add(item.key);

    await purchase.save();

    return purchase;
  }

  static Future<BasePurchase> updateItem(
      int key, int itemKey, UpdateBasePurchaseItemViewModel model) async {
    await _openBox();

    BasePurchase? purchase = _mBox!.get(key);

    if (purchase == null)
      throw DatabaseError.notFoundError(AppErrors.PURCHASE_NOT_FOUND);

    if (!purchase.itemsKey.contains(itemKey))
      throw DatabaseError.notFoundError(AppErrors.PURCHASE_ITEM_NOT_FOUND);

    BasePurchaseItem item = await BasePurchaseItemDao.get(itemKey);

    item.quantity = model.quantity;

    await item.save();

    return purchase;
  }

  static Future<BasePurchase> removeItem(int key, int itemKey) async {
    await _openBox();

    BasePurchase? purchase = _mBox!.get(key);

    if (purchase == null)
      throw DatabaseError.notFoundError(AppErrors.PURCHASE_NOT_FOUND);

    await BasePurchaseItemDao.deleteItem(key);
    purchase.itemsKey.removeWhere((element) => element == itemKey);

    await purchase.save();

    return purchase;
  }

  static Future<BasePurchaseModel> createParsed() async {
    var purchase = await create();
    return await parseToBasePurchaseModel(purchase);
  }

  static Future<BasePurchaseModel> getParsed(int key) async {
    var purchase = await get(key);
    return await parseToBasePurchaseModel(purchase);
  }

  static Future<List<BasePurchaseModel>> getAllParsed(
      BasePurchasesFilterViewModel filter) async {
    List<BasePurchaseModel> models = List.empty(growable: true);
    var purchases = await getAll(filter);

    for (var purchase in purchases) {
      var model = await parseToBasePurchaseModel(purchase);
      models.add(model);
    }

    return models;
  }

  static Future<BasePurchaseModel> addItemParsed(
      int key, AddBasePurchaseItemViewModel model) async {
    var purchase = await addItem(key, model);
    return await parseToBasePurchaseModel(purchase);
  }

  static Future<BasePurchaseModel> removeItemParsed(
      int key, int itemKey) async {
    var purchase = await removeItem(key, itemKey);
    return await parseToBasePurchaseModel(purchase);
  }

  static Future<BasePurchaseModel> updateItemParsed(
      int key, int itemKey, UpdateBasePurchaseItemViewModel model) async {
    var purchase = await updateItem(key, itemKey, model);
    return await parseToBasePurchaseModel(purchase);
  }

  static Future<BasePurchaseModel> parseToBasePurchaseModel(
      BasePurchase purchase) async {
    List<BasePurchaseItemModel> items = List.empty(growable: true);
    for (var itemKey in purchase.itemsKey) {
      var itemModel = await BasePurchaseItemDao.getParsed(itemKey);
      items.add(itemModel);
    }

    return BasePurchaseModel(
      sId: purchase.key.toString(),
      name: purchase.name,
      items: items,
      createdAt: purchase.createdAt,
      updatedAt: purchase.updatedAt,
    );
  }
}
