import 'package:emptio/common/delegates/product_search/product_search.dart';
import 'package:emptio/common/widgets/search_dialog.widget.dart';
import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/models/post_data.model.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/add_base_purchase_item.view-model.dart';
import 'package:emptio/view-models/update_base_purchase_item.view-model.dart';
import 'package:emptio/views/base_purchase_details/store/base_purchase_details.store.dart';
import 'package:emptio/views/base_purchase_details/widgets/base_purchase_items_list.widget.dart';
import 'package:emptio/views/create_post/create_post.view.dart';
import 'package:emptio/views/edit_purchase_item/edit_purchase_item.view.dart';
import 'package:emptio/views/new_purchase_item/new_purchase_item.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class BasePurchaseDetailsView extends StatelessWidget {
  final AuthStore _authStore = GetIt.I<AuthStore>();
  final BasePurchaseDetailsStore _store;

  BasePurchaseDetailsView({
    required BasePurchaseModel purchase,
    Key? key,
  })  : _store = BasePurchaseDetailsStore(purchase: purchase),
        super(key: key);

  Future<void> searchProduct(BuildContext context) async {
    final response = await showSearch<ProductSearchResponse?>(
      context: context,
      delegate: ProductSearch(
        onQuickSelect: onQuickSelectProduct,
        basePurchaseId: _store.purchase.sId,
      ),
    );

    if (response != null) {
      if (response.addNew != null) {
        await createNewProductItem(context);
      } else if (response.product != null) {
        await createExitingProductItem(context, response.product!);
      }
    }
  }

  void onQuickSelectProduct(ProductModel product) {
    _store.addItem(AddBasePurchaseItemViewModel(
      productId: product.sId,
      quantity: 1,
    ));
  }

  Future<void> createNewProductItem(BuildContext context) async {
    final item = await Navigator.of(context).push<AddBasePurchaseItemViewModel>(
      MaterialPageRoute(
        builder: (context) => NewPurchaseItemView(isBaseItem: true),
      ),
    );

    if (item != null) {
      await _store.addItem(item);
    }
  }

  Future<void> createExitingProductItem(
      BuildContext context, ProductModel product) async {
    final update =
        await Navigator.of(context).push<UpdateBasePurchaseItemViewModel>(
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

  Future<void> openEditPurchaseName(BuildContext context) async {
    final name = await showDialog<String?>(
      context: context,
      builder: (context) => SearchDialog(
        currentSearch: _store.name,
        textInputAction: TextInputAction.done,
      ),
    );

    if (name != null && name != _store.name) {
      if (name.isNotEmpty) {
        _store.changeName(name);
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Nome inválido!"),
          ),
        );
      }
    }
  }

  Future<void> sharePurchase(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreatePostView(
          type: PostDataTypes.purchase,
          purchase: _store.purchase,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: GestureDetector(
            onTap: () => openEditPurchaseName(context),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.biggest.width,
                  child: Observer(builder: (_) {
                    return Text(_store.name);
                  }),
                );
              },
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => openEditPurchaseName(context),
              icon: Icon(Icons.edit_outlined),
            ),
            if (_authStore.isLogged)
              IconButton(
                onPressed: () => sharePurchase(context),
                icon: Icon(Icons.share_outlined),
              ),
          ],
        ),
        body: BasePurchaseItemsList(store: _store),
        floatingActionButton: FloatingActionButton(
          onPressed: () => searchProduct(context),
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
        ),
      );
    });
  }
}
