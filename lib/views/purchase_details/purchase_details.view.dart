import 'package:emptio/common/delegates/purchase_item_search/purchase_item_search.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/models/purchase_item.model.dart';
import 'package:emptio/view-models/add_purchase_item.view-model.dart';
import 'package:emptio/view-models/update_purchase_item.view-model.dart';
import 'package:emptio/views/edit_purchase_item/edit_puchase_item.view.dart';
import 'package:emptio/views/new_purchase_item/new_purchase_item.view.dart';
import 'package:emptio/views/purchase_details/store/purchase_details.store.dart';
import 'package:emptio/views/purchase_details/widgets/connected_market.widget.dart';
import 'package:emptio/views/purchase_details/widgets/purchase_items_list.widget.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class PurchaseDetailsView extends StatefulWidget {
  final PurchaseModel purchase;

  PurchaseDetailsView({
    required this.purchase,
    Key? key,
  }) : super(key: key);

  @override
  _PurchaseDetailsViewState createState() =>
      _PurchaseDetailsViewState(purchase: purchase);
}

class _PurchaseDetailsViewState extends State<PurchaseDetailsView> {
  late PurchaseDetailsStore _store;

  _PurchaseDetailsViewState({required PurchaseModel purchase}) {
    _store = PurchaseDetailsStore(
      purchase: purchase,
      items: ObservableList<PurchaseItemModel>()
        ..addAll(purchase.items.where((v) => !v.checked)),
      checkedItems: ObservableList<PurchaseItemModel>()
        ..addAll(purchase.items.where((v) => v.checked)),
    );
  }

  Future<void> selectFilter(BuildContext context) async {
    bool? checked = await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.list_rounded),
                  title: Text('Restantes'),
                  onTap: () async {
                    Navigator.of(context).pop(false);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.checklist),
                  title: Text('Concluidas'),
                  onTap: () async {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    if (checked != null) {
      _store.changeFilter(checked);
    }
  }

  Future<void> searchProduct() async {
    ProductSearchResponse? response = await showSearch<ProductSearchResponse?>(
      context: context,
      delegate: ProductSearch(
        onQuickSelect: onQuickSelectProduct,
        purchaseId: _store.purchase.sId,
        connectedMarket: _store.purchase.market,
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
    _store.addItem(AddPurchaseItemViewModel(
      price: product.marketPrice ?? 0,
      quantity: 1,
      productId: product.sId,
    ));
  }

  Future<void> createNewProductItem() async {
    AddPurchaseItemViewModel? item = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewPurchaseItemView(
          connectedMarket: _store.purchase.market,
        ),
      ),
    );

    if (item != null) {
      await _store.addItem(item);
    }
  }

  Future<void> createExitingProductItem(ProductModel product) async {
    UpdatePurchaseItemViewModel? update = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditPurchaseItemView(
          connectedMarket: _store.purchase.market,
          product: product,
          initialPrice: product.marketPrice,
        ),
      ),
    );

    if (update != null) {
      await _store.addItem(AddPurchaseItemViewModel(
        price: update.price,
        quantity: update.quantity,
        productId: product.sId,
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
        actions: [
          IconButton(
            onPressed: () => selectFilter(context),
            icon: Icon(Icons.filter_list_rounded),
            tooltip: "Alterar Filtro",
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings_outlined),
            tooltip: "Configurações",
          ),
        ],
        bottom: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              bottom: 10,
            ),
            child: ConnectedMarketIndicator(
              detailsStore: _store,
            ),
          ),
          preferredSize: Size.fromHeight(70),
        ),
      ),
      body: PurchaseItemsList(store: _store),
      floatingActionButton: FloatingActionButton(
        onPressed: searchProduct,
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
      ),
    );
  }
}
