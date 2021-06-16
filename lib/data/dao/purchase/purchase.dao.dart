import 'package:emptio/data/dao/market/market.dao.dart';
import 'package:emptio/data/dao/product/product.dao.dart';
import 'package:emptio/data/database.dart';
import 'package:emptio/data/models/purchase/purchase.dart';
import 'package:emptio/data/models/purchase_item/purchase_item.dart';
import 'package:emptio/models/market.model.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/models/purchase_item.model.dart';
import 'package:emptio/view-models/purchase_filter.view-model.dart';
import 'package:hive/hive.dart';

class PurchaseDao {
  Box<Purchase>? _mBox;

  Future<void> openBox() async {
    if (_mBox == null) {
      _mBox = await Hive.openBox<Purchase>(Database.purchaseBoxName);
    }
  }

  Future<List<PurchaseModel>> getPurchases(
      PurchasesFilterViewModel filter) async {
    await openBox();
    List<PurchaseModel> models = List.empty(growable: true);

    List<Purchase> purchases = (_mBox!.values.toList()
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
        .where((element) =>
            element.status.contains(filter.status ?? PurchaseStatusTypes.OPEN))
        .skip(filter.skip)
        .take(filter.limit)
        .toList();

    for (Purchase _purchase in purchases) {
      PurchaseModel model = await parseToPurchaseModel(_purchase);
      models.add(model);
    }

    return models;
  }

  Future<PurchaseModel> create() async {
    await openBox();

    final createdAt = DateTime.now().toIso8601String();
    int key = await _mBox!.add(Purchase(
      status: PurchaseStatusTypes.OPEN,
      limit: 0,
      marketKey: null,
      items: [],
      createdAt: createdAt,
      updatedAt: createdAt,
    ));

    PurchaseModel model = await parseToPurchaseModel(_mBox!.get(key)!);

    return model;
  }

  Future<void> delete(int key) async {
    await openBox();

    return await _mBox!.delete(key);
  }

  Future<PurchaseModel> parseToPurchaseModel(Purchase purchase) async {
    List<PurchaseItemModel> items = List.empty(growable: true);
    double cost = 0;
    double estimatedCost = 0;
    for (var purchaseItem in purchase.items) {
      var itemModel = await parseToPurchaseItemModel(purchaseItem);
      if (itemModel.checked) {
        cost += itemModel.price;
      }
      estimatedCost += itemModel.price;
      items.add(itemModel);
    }

    MarketModel? market;
    if (purchase.marketKey != null) {
      market = await MarketDao().get(purchase.marketKey!);
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

  Future<PurchaseItemModel> parseToPurchaseItemModel(
      PurchaseItem purchaseItem) async {
    ProductModel product = await ProductDao().get(purchaseItem.productKey);

    return PurchaseItemModel(
      sId: purchaseItem.key.toString(),
      product: product,
      price: purchaseItem.price,
      quantity: purchaseItem.quantity,
      checked: purchaseItem.checked,
    );
  }
}
