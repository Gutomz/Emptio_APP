import 'package:emptio/common/delegates/product_search/product_search.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/models/post_data.model.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/add_purchase_item.view-model.dart';
import 'package:emptio/view-models/copy_base_purchase.view_model.dart';
import 'package:emptio/view-models/update_purchase_item.view-model.dart';
import 'package:emptio/views/base_purchases/store/base_purchases.store.dart';
import 'package:emptio/views/create_post/create_post.view.dart';
import 'package:emptio/views/edit_purchase_item/edit_purchase_item.view.dart';
import 'package:emptio/views/new_purchase_item/new_purchase_item.view.dart';
import 'package:emptio/views/purchase_details/store/purchase_details.store.dart';
import 'package:emptio/views/purchase_details/widgets/connected_market.widget.dart';
import 'package:emptio/views/purchase_details/widgets/purchase_details_bottom_app_bar.widget.dart';
import 'package:emptio/views/purchase_details/widgets/purchase_details_end_drawer.widget.dart';
import 'package:emptio/views/purchase_details/widgets/purchase_items_list.widget.dart';
import 'package:emptio/views/recognize_product/recognize_product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:emptio/helpers/extensions.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';

class PurchaseDetailsView extends StatelessWidget {
  final BasePurchasesStore _basePurchasesStore =
      GetIt.I<AppStore>().basePurchasesStore;
  final AuthStore _authStore = GetIt.I<AuthStore>();
  final PurchaseDetailsStore _store;
  final ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  PurchaseDetailsView({
    required PurchaseModel purchase,
    Key? key,
  })  : _store = PurchaseDetailsStore(purchase: purchase),
        super(key: key);

  Future<void> searchProduct(BuildContext context) async {
    final response = await showSearch<ProductSearchResponse?>(
      context: context,
      delegate: ProductSearch(
        onQuickSelect: onQuickSelectProduct,
        purchaseId: _store.purchase.sId,
        connectedMarket: _store.purchase.market,
      ),
    );

    _store.setFilter(false);

    if (response != null) {
      if (response.addNew != null) {
        await createNewProductItem(context);
      } else if (response.product != null) {
        await createExitingProductItem(context, response.product!);
      }
    }
  }

  Future<void> recognizeProduct(BuildContext context) async {
    final response = await Navigator.of(context).push<ProductSearchResponse>(
      MaterialPageRoute(
        builder: (context) => RecognizeProductView(
          connectedMarket: _store.purchase.market,
          purchaseId: _store.purchase.sId,
        ),
      ),
    );

    _store.setFilter(false);

    if (response != null) {
      if (response.addNew != null) {
        await createNewProductItem(context);
      } else if (response.product != null) {
        await createExitingProductItem(context, response.product!);
      }
    }
  }

  void onQuickSelectProduct(ProductModel product) {
    _store.addItem(AddPurchaseItemViewModel(
      price: product.marketDetails?.price ?? 0,
      quantity: 1,
      productId: product.sId,
    ));
  }

  Future<void> createNewProductItem(BuildContext context) async {
    final item = await Navigator.of(context).push<AddPurchaseItemViewModel>(
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

  Future<void> createExitingProductItem(
      BuildContext context, ProductModel product) async {
    final update =
        await Navigator.of(context).push<UpdatePurchaseItemViewModel>(
      MaterialPageRoute(
        builder: (context) => EditPurchaseItemView(
          connectedMarket: _store.purchase.market,
          product: product,
          initialPrice: product.marketDetails?.price,
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

  Future<void> sharePurchase(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreatePostView(
          type: PostDataTypes.purchase,
          isPurchase: true,
          purchase: BasePurchaseModel.fromPurchase(_store.purchase),
        ),
      ),
    );
  }

  Future<void> copyPurchase(BuildContext context) async {
    await _basePurchasesStore.copyPurchase(
      CopyBasePurchaseViewModel(
        purchaseId: _store.purchase.sId,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Lista copiada com sucesso"),
        backgroundColor: AppColors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (rootContext) {
          return Observer(builder: (context) {
            return WillPopScope(
              onWillPop: () async {
                if (isDialOpen.value) {
                  isDialOpen.value = false;
                  return false;
                }

                return true;
              },
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  title: Observer(builder: (_) {
                    if (_store.isClosed) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Concluído em:",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            _store.purchase.updatedAt.formatDate(),
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.orange,
                            ),
                          ),
                        ],
                      );
                    }

                    return Text(
                        _store.showChecked ? "Concluídos" : "Pendentes");
                  }),
                  actions: [
                    if (!_store.isClosed)
                      Observer(builder: (context) {
                        return IconButton(
                          onPressed: () => _store.toggleFilter(),
                          icon: Icon(_store.showChecked
                              ? Icons.checklist_rounded
                              : Icons.list_rounded),
                          tooltip: "Alterar Filtro",
                        );
                      }),
                    if (_store.isClosed)
                      IconButton(
                        onPressed: () => sharePurchase(context),
                        icon: Icon(Icons.share_outlined),
                        tooltip: "Compartilhar",
                      ),
                    Builder(
                      builder: (context) => IconButton(
                        onPressed: () => Scaffold.of(context).openEndDrawer(),
                        icon: Icon(Icons.settings_outlined),
                        tooltip: "Configurações",
                      ),
                    ),
                  ],
                  bottom: _store.isClosed && !_store.isMarketConnected
                      ? null
                      : PreferredSize(
                          preferredSize: Size.fromHeight(70),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              bottom: 10,
                            ),
                            child: ConnectedMarketIndicator(
                              store: _store,
                            ),
                          ),
                        ),
                ),
                body: PurchaseItemsList(store: _store),
                endDrawer: PurchaseDetailsEndDrawer(store: _store),
                bottomNavigationBar: PurchaseDetailsBottomAppBar(store: _store),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: getFloatingActionButton(rootContext),
              ),
            );
          });
        },
      ),
    );
  }

  Widget getFloatingActionButton(BuildContext rootContext) {
    return Observer(builder: (context) {
      if (!_authStore.isLogged) {
        return FloatingActionButton(
          onPressed: () => searchProduct(context),
          tooltip: "Buscar Produto",
          child: Icon(Icons.search_outlined, color: Colors.white),
        );
      }

      if (_store.isClosed) {
        return FloatingActionButton(
          onPressed: () => copyPurchase(rootContext),
          tooltip: "Salvar lista",
          child: Icon(Icons.download_outlined, color: Colors.white),
        );
      } else {
        return SpeedDial(
          openCloseDial: isDialOpen,
          curve: Curves.bounceInOut,
          animatedIcon: AnimatedIcons.search_ellipsis,
          foregroundColor: Colors.white,
          spaceBetweenChildren: 10,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild(
              backgroundColor: AppColors.lightBlue,
              foregroundColor: Colors.white,
              onTap: () => searchProduct(context),
              label: "Texto",
              child: Icon(Icons.search_outlined),
            ),
            SpeedDialChild(
              backgroundColor: AppColors.lightBlue,
              foregroundColor: Colors.white,
              onTap: () => recognizeProduct(context),
              label: "Imagem",
              child: Icon(Icons.camera_alt_outlined),
            ),
          ],
        );
      }
    });
  }
}
