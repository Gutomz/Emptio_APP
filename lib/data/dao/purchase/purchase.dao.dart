import 'package:emptio/core/app_errors.dart';
import 'package:emptio/data/dao/base_purchase/base_purchase.dao.dart';
import 'package:emptio/data/dao/base_purchase_item/base_purchase_item.dao.dart';
import 'package:emptio/data/dao/market/market.dao.dart';
import 'package:emptio/data/dao/product_market/product_market.dao.dart';
import 'package:emptio/data/dao/purchase_item/purchase_item.dao.dart';
import 'package:emptio/data/database.dart';
import 'package:emptio/data/database_errors.dart';
import 'package:emptio/data/models/purchase/purchase.dart';
import 'package:emptio/data/models/purchase_item/purchase_item.dart';
import 'package:emptio/models/market.model.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/models/purchase_item.model.dart';
import 'package:emptio/view-models/add_purchase_item.view-model.dart';
import 'package:emptio/view-models/create_purchase.view-model.dart';
import 'package:emptio/view-models/purchase_filter.view-model.dart';
import 'package:emptio/view-models/update_purchase_item.view-model.dart';
import 'package:hive/hive.dart';

class PurchaseDao {
  static Box<Purchase>? _mBox;

  static Future<void> _openBox() async {
    if (_mBox == null) {
      _mBox = await Hive.openBox<Purchase>(Database.purchaseBoxName);
    }
  }

  static Future<Purchase> create(CreatePurchaseViewModel model) async {
    await _openBox();

    final createdAt = DateTime.now().toIso8601String();
    int key = await _mBox!.add(Purchase(
      status: PurchaseStatusTypes.OPEN,
      limit: 0,
      marketKey: null,
      itemsKey: List.empty(growable: true),
      createdAt: createdAt,
      updatedAt: createdAt,
    ));

    if (model.basePurchaseId.isNotEmpty) {
      var purchase = _mBox!.get(key)!;

      var basePurchase =
          await BasePurchaseDao.get(int.parse(model.basePurchaseId));

      for (var baseItemKey in basePurchase.itemsKey) {
        var baseItem = await BasePurchaseItemDao.get(baseItemKey);
        var item = await PurchaseItemDao.create(AddPurchaseItemViewModel(
          productId: baseItem.productKey.toString(),
          price: 0,
          quantity: baseItem.quantity,
        ));

        purchase.itemsKey.add(item.key);
      }

      purchase.save();
    }

    return _mBox!.get(key)!;
  }

  static Future<void> delete(int key) async {
    await _openBox();
    Purchase? purchase = _mBox!.get(key);

    if (purchase != null) {
      for (int itemKey in purchase.itemsKey) {
        await PurchaseItemDao.deleteItem(itemKey);
      }
    }

    return await _mBox!.delete(key);
  }

  static Future<Purchase> get(int key) async {
    await _openBox();
    var purchase = _mBox!.get(key);

    if (purchase == null)
      throw DatabaseError.notFoundError(AppErrors.PURCHASE_NOT_FOUND);

    return purchase;
  }

  static Future<List<Purchase>> getAll(PurchasesFilterViewModel filter) async {
    await _openBox();

    List<Purchase> purchases = (_mBox!.values
            .where((element) => element.status
                .contains(filter.status ?? PurchaseStatusTypes.OPEN))
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

  static Future<Purchase> addItem(
      int key, AddPurchaseItemViewModel model) async {
    await _openBox();
    Purchase? purchase = _mBox!.get(key);

    if (purchase == null)
      throw DatabaseError.notFoundError(AppErrors.PURCHASE_NOT_FOUND);

    var item = await PurchaseItemDao.create(model);

    purchase.itemsKey.add(item.key);

    await purchase.save();

    return purchase;
  }

  static Future<Purchase> updateItem(
      int key, int itemKey, UpdatePurchaseItemViewModel model) async {
    await _openBox();

    Purchase? purchase = _mBox!.get(key);

    if (purchase == null)
      throw DatabaseError.notFoundError(AppErrors.PURCHASE_NOT_FOUND);

    if (!purchase.itemsKey.contains(itemKey))
      throw DatabaseError.notFoundError(AppErrors.PURCHASE_ITEM_NOT_FOUND);

    PurchaseItem item = await PurchaseItemDao.get(itemKey);

    item.price = model.price;
    item.quantity = model.quantity;
    item.checked = model.checked;

    await item.save();

    return purchase;
  }

  static Future<Purchase> removeItem(int key, int itemKey) async {
    await _openBox();

    Purchase? purchase = _mBox!.get(key);

    if (purchase == null)
      throw DatabaseError.notFoundError(AppErrors.PURCHASE_NOT_FOUND);

    await PurchaseItemDao.deleteItem(key);
    purchase.itemsKey.removeWhere((element) => element == itemKey);

    await purchase.save();

    return purchase;
  }

  static Future<Purchase> complete(int key) async {
    await _openBox();

    Purchase purchase = await get(key);

    purchase.status = PurchaseStatusTypes.CLOSED;
    purchase.updatedAt = DateTime.now().toIso8601String();

    await purchase.save();

    if (purchase.marketKey != null) {
      for (var itemKey in purchase.itemsKey) {
        var item = await PurchaseItemDao.get(itemKey);

        await ProductMarketDao.update(
          productKey: item.productKey,
          marketKey: purchase.marketKey!,
          price: item.price,
        );
      }
    }

    return _mBox!.get(key)!;
  }

  static Future<PurchaseModel> createParsed(
      CreatePurchaseViewModel model) async {
    var purchase = await create(model);
    return await parseToPurchaseModel(purchase);
  }

  static Future<PurchaseModel> getParsed(int key) async {
    var purchase = await get(key);
    return await parseToPurchaseModel(purchase);
  }

  static Future<List<PurchaseModel>> getAllParsed(
      PurchasesFilterViewModel filter) async {
    List<PurchaseModel> models = List.empty(growable: true);
    var purchases = await getAll(filter);

    for (var purchase in purchases) {
      var model = await parseToPurchaseModel(purchase);
      models.add(model);
    }

    return models;
  }

  static Future<PurchaseModel> addItemParsed(
      int key, AddPurchaseItemViewModel model) async {
    var purchase = await addItem(key, model);
    return await parseToPurchaseModel(purchase);
  }

  static Future<PurchaseModel> removeItemParsed(int key, int itemKey) async {
    var purchase = await removeItem(key, itemKey);
    return await parseToPurchaseModel(purchase);
  }

  static Future<PurchaseModel> updateItemParsed(
      int key, int itemKey, UpdatePurchaseItemViewModel model) async {
    var purchase = await updateItem(key, itemKey, model);
    return await parseToPurchaseModel(purchase);
  }

  static Future<PurchaseModel> completeParsed(int key) async {
    var purchase = await complete(key);
    return await parseToPurchaseModel(purchase);
  }

  static Future<PurchaseModel> parseToPurchaseModel(Purchase purchase) async {
    List<PurchaseItemModel> items = List.empty(growable: true);
    double cost = 0;
    double estimatedCost = 0;
    for (var itemKey in purchase.itemsKey) {
      var itemModel = await PurchaseItemDao.getParsed(itemKey);
      if (itemModel.checked) {
        cost += itemModel.price * itemModel.quantity;
      }
      estimatedCost += itemModel.price * itemModel.quantity;
      items.add(itemModel);
    }

    MarketModel? market;
    if (purchase.marketKey != null) {
      market = await MarketDao.getParsed(purchase.marketKey!);
    }

    return PurchaseModel(
      sId: purchase.key.toString(),
      status: purchase.status,
      cost: cost,
      estimatedCost: estimatedCost,
      limit: purchase.limit,
      items: items,
      market: market,
      createdAt: purchase.createdAt,
      updatedAt: purchase.updatedAt,
    );
  }
}
