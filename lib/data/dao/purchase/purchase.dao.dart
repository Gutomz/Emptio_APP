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
    _mBox ??= await Hive.openBox<Purchase>(Database.purchaseBoxName);
  }

  static Future<Purchase> create(CreatePurchaseViewModel model) async {
    await _openBox();

    final createdAt = DateTime.now().toIso8601String();
    final int key = await _mBox!.add(Purchase(
      status: PurchaseStatusTypes.open,
      limit: 0,
      itemsKey: List.empty(growable: true),
      createdAt: createdAt,
      updatedAt: createdAt,
    ));

    if (model.basePurchaseId.isNotEmpty) {
      final purchase = _mBox!.get(key)!;

      final basePurchase =
          await BasePurchaseDao.get(int.parse(model.basePurchaseId));

      for (final baseItemKey in basePurchase.itemsKey) {
        final baseItem = await BasePurchaseItemDao.get(baseItemKey);
        final item = await PurchaseItemDao.create(AddPurchaseItemViewModel(
          productId: baseItem.productKey.toString(),
          price: 0,
          quantity: baseItem.quantity,
        ));

        purchase.itemsKey.add(item.key as int);
      }

      purchase.save();
    }

    return _mBox!.get(key)!;
  }

  static Future<void> delete(int key) async {
    await _openBox();
    final Purchase? purchase = _mBox!.get(key);

    if (purchase != null) {
      for (final int itemKey in purchase.itemsKey) {
        await PurchaseItemDao.deleteItem(itemKey);
      }
    }

    return _mBox!.delete(key);
  }

  static Future<Purchase> get(int key) async {
    await _openBox();
    final purchase = _mBox!.get(key);

    if (purchase == null) {
      throw DatabaseError.notFoundError(AppErrors.purchaseNotFound);
    }

    return purchase;
  }

  static Future<List<Purchase>> getAll(PurchasesFilterViewModel filter) async {
    await _openBox();

    final List<Purchase> purchases = (_mBox!.values
            .where((element) => element.status
                .contains(filter.status ?? PurchaseStatusTypes.open))
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
    final Purchase? purchase = _mBox!.get(key);

    if (purchase == null) {
      throw DatabaseError.notFoundError(AppErrors.purchaseNotFound);
    }

    final item = await PurchaseItemDao.create(model);

    purchase.itemsKey.add(item.key as int);

    await purchase.save();

    return purchase;
  }

  static Future<Purchase> updateItem(
      int key, int itemKey, UpdatePurchaseItemViewModel model) async {
    await _openBox();

    final Purchase? purchase = _mBox!.get(key);

    if (purchase == null) {
      throw DatabaseError.notFoundError(AppErrors.purchaseNotFound);
    }

    if (!purchase.itemsKey.contains(itemKey)) {
      throw DatabaseError.notFoundError(AppErrors.purchaseItemNotFound);
    }

    final PurchaseItem item = await PurchaseItemDao.get(itemKey);

    item.price = model.price;
    item.quantity = model.quantity;
    item.checked = model.checked;

    await item.save();

    return purchase;
  }

  static Future<Purchase> removeItem(int key, int itemKey) async {
    await _openBox();

    final Purchase? purchase = _mBox!.get(key);

    if (purchase == null) {
      throw DatabaseError.notFoundError(AppErrors.purchaseNotFound);
    }

    await PurchaseItemDao.deleteItem(key);
    purchase.itemsKey.removeWhere((element) => element == itemKey);

    await purchase.save();

    return purchase;
  }

  static Future<Purchase> complete(int key) async {
    await _openBox();

    final Purchase purchase = await get(key);

    purchase.status = PurchaseStatusTypes.closed;
    purchase.updatedAt = DateTime.now().toIso8601String();

    await purchase.save();

    if (purchase.marketKey != null) {
      for (final itemKey in purchase.itemsKey) {
        final item = await PurchaseItemDao.get(itemKey);

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
    final purchase = await create(model);
    return parseToPurchaseModel(purchase);
  }

  static Future<PurchaseModel> getParsed(int key) async {
    final purchase = await get(key);
    return parseToPurchaseModel(purchase);
  }

  static Future<List<PurchaseModel>> getAllParsed(
      PurchasesFilterViewModel filter) async {
    final List<PurchaseModel> models = List.empty(growable: true);
    final purchases = await getAll(filter);

    for (final purchase in purchases) {
      final model = await parseToPurchaseModel(purchase);
      models.add(model);
    }

    return models;
  }

  static Future<PurchaseModel> addItemParsed(
      int key, AddPurchaseItemViewModel model) async {
    final purchase = await addItem(key, model);
    return parseToPurchaseModel(purchase);
  }

  static Future<PurchaseModel> removeItemParsed(int key, int itemKey) async {
    final purchase = await removeItem(key, itemKey);
    return parseToPurchaseModel(purchase);
  }

  static Future<PurchaseModel> updateItemParsed(
      int key, int itemKey, UpdatePurchaseItemViewModel model) async {
    final purchase = await updateItem(key, itemKey, model);
    return parseToPurchaseModel(purchase);
  }

  static Future<PurchaseModel> completeParsed(int key) async {
    final purchase = await complete(key);
    return parseToPurchaseModel(purchase);
  }

  static Future<PurchaseModel> parseToPurchaseModel(Purchase purchase) async {
    final List<PurchaseItemModel> items = List.empty(growable: true);
    double cost = 0;
    double estimatedCost = 0;
    for (final itemKey in purchase.itemsKey) {
      final itemModel = await PurchaseItemDao.getParsed(itemKey);
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
