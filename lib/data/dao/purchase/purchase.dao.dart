import 'package:emptio/data/dao/market/market.dao.dart';
import 'package:emptio/data/dao/product/product.dao.dart';
import 'package:emptio/data/database.dart';
import 'package:emptio/data/database_errors.dart';
import 'package:emptio/data/models/product/product.dart';
import 'package:emptio/data/models/purchase/purchase.dart';
import 'package:emptio/data/models/purchase_item/purchase_item.dart';
import 'package:emptio/models/market.model.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/models/purchase_item.model.dart';
import 'package:emptio/view-models/add_purchase_item.view-model.dart';
import 'package:emptio/view-models/purchase_filter.view-model.dart';
import 'package:emptio/view-models/update_purchase_item.view-model.dart';
import 'package:hive/hive.dart';

class PurchaseDao {
  Box<Purchase>? _mBox;

  Future<void> _openBox() async {
    if (_mBox == null) {
      _mBox = await Hive.openBox<Purchase>(Database.purchaseBoxName);
    }
  }

  Future<List<PurchaseModel>> getPurchases(
      PurchasesFilterViewModel filter) async {
    await _openBox();
    List<PurchaseModel> models = List.empty(growable: true);

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

    for (Purchase _purchase in purchases) {
      PurchaseModel model = await parseToPurchaseModel(_purchase);
      models.add(model);
    }

    return models;
  }

  Future<PurchaseModel> create() async {
    await _openBox();

    final createdAt = DateTime.now().toIso8601String();
    int key = await _mBox!.add(Purchase(
      status: PurchaseStatusTypes.OPEN,
      limit: 0,
      marketKey: null,
      items: List.empty(growable: true),
      createdAt: createdAt,
      updatedAt: createdAt,
    ));

    PurchaseModel model = await parseToPurchaseModel(_mBox!.get(key)!);

    return model;
  }

  Future<void> delete(int key) async {
    await _openBox();

    return await _mBox!.delete(key);
  }

  Future<PurchaseModel> addItem(int key, AddPurchaseItemViewModel model) async {
    await _openBox();
    Box<Product> productBox = await ProductDao().instance;

    Purchase? purchase = _mBox!.get(key);

    if (purchase == null)
      throw DatabaseError.notFoundError('purchase_not_found');

    Product? product;
    if (model.productId != null) {
      product = productBox.get(int.parse(model.productId!));
    } else {
      var productKey = (await ProductDao().create(model.productModel!)).sId!;
      product = productBox.get(int.parse(productKey));
    }

    if (product == null) throw DatabaseError.notFoundError('product_not_found');

    purchase.items.add(PurchaseItem(
      productKey: product.key,
      price: model.price,
      quantity: model.quantity,
    ));

    await purchase.save();

    return parseToPurchaseModel(purchase);
  }

  Future<PurchaseModel> updateItem(
      int key, int itemKey, UpdatePurchaseItemViewModel model) async {
    await _openBox();

    Purchase? purchase = _mBox!.get(key);

    if (purchase == null)
      throw DatabaseError.notFoundError('purchase_not_found');

    PurchaseItem item =
        purchase.items.firstWhere((element) => element.key == itemKey);

    item.price = model.price;
    item.quantity = model.quantity;
    item.checked = model.checked;

    await purchase.save();

    return parseToPurchaseModel(purchase);
  }

  Future<PurchaseModel> removeItem(int key, int itemKey) async {
    await _openBox();

    Purchase? purchase = _mBox!.get(key);

    if (purchase == null)
      throw DatabaseError.notFoundError('purchase_not_found');

    purchase.items.removeWhere((element) => element.key == itemKey);

    await purchase.save();

    return parseToPurchaseModel(purchase);
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
