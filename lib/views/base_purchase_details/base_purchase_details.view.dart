import 'package:emptio/common/delegates/purchase_item_search/purchase_item_search.dart';
import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/models/base_purchase_item.model.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/view-models/add_base_purchase_item.view-model.dart';
import 'package:emptio/view-models/update_base_purchase_item.view-model.dart';
import 'package:emptio/views/base_purchase_details/store/base_purchase_details.store.dart';
import 'package:emptio/views/base_purchase_details/widgets/base_purchase_items_list.widget.dart';
import 'package:emptio/views/edit_purchase_item/edit_puchase_item.view.dart';
import 'package:emptio/views/new_purchase_item/new_purchase_item.view.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class BasePurchaseDetailsView extends StatefulWidget {
  final BasePurchaseModel purchase;

  BasePurchaseDetailsView({
    required this.purchase,
    Key? key,
  }) : super(key: key);

  @override
  _BasePurchaseDetailsViewState createState() =>
      _BasePurchaseDetailsViewState(purchase: purchase);
}

class _BasePurchaseDetailsViewState extends State<BasePurchaseDetailsView> {
  late BasePurchaseDetailsStore _store;

  _BasePurchaseDetailsViewState({required BasePurchaseModel purchase}) {
    _store = BasePurchaseDetailsStore(
      purchase: purchase,
      items: ObservableList<BasePurchaseItemModel>()..addAll(purchase.items),
    );
  }

  Future<void> searchProduct() async {
    ProductSearchResponse? response = await showSearch<ProductSearchResponse?>(
      context: context,
      delegate: ProductSearch(
        onQuickSelect: onQuickSelectProduct,
        basePurchaseId: _store.purchase.sId,
      ),
    );

    if (response != null) {
      if (response.addNew != null) {
        await createNewProductItem();
      } else if (response.product != null) {
        await createExitingProductItem(response.product!);
      }
    }
  }

  void onQuickSelectProduct(ProductModel product) {
    _store.addItem(AddBasePurchaseItemViewModel(
      productId: product.sId,
      quantity: 1,
    ));
  }

  Future<void> createNewProductItem() async {
    AddBasePurchaseItemViewModel? item = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewPurchaseItemView(isBaseItem: true),
      ),
    );

    if (item != null) {
      await _store.addItem(item);
    }
  }

  Future<void> createExitingProductItem(ProductModel product) async {
    UpdateBasePurchaseItemViewModel? update = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return EditPurchaseItemView(
          product: product,
          isBaseItem: true,
        );
      }),
    );

    if (update != null) {
      await _store.addItem(AddBasePurchaseItemViewModel(
        productId: product.sId,
        quantity: update.quantity,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Detalhes"),
      ),
      body: BasePurchaseItemsList(store: _store),
      floatingActionButton: FloatingActionButton(
        onPressed: searchProduct,
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
      ),
    );
  }
}
