import 'package:emptio/common/widgets/dismissible_background.widget.dart';
import 'package:emptio/common/widgets/empty_placeholder.widget.dart';
import 'package:emptio/common/widgets/error_placeholder.widget.dart';
import 'package:emptio/common/widgets/product_tile.widget.dart';
import 'package:emptio/common/widgets/search_dialog.widget.dart';
import 'package:emptio/common/widgets/simple_confirm_dialog.widget.dart';
import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/views/product_details/product_details.view.dart';
import 'package:emptio/views/products_list/store/products_list.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProductsListView extends StatelessWidget {
  final ProductsListStore _store = ProductsListStore();

  ProductsListView({Key? key}) : super(key: key);

  Future<void> openSearch(BuildContext context) async {
    final search = await showDialog<String?>(
      context: context,
      builder: (context) => SearchDialog(currentSearch: _store.search),
    );

    if (search != null) {
      _store.setSearch(search);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => openSearch(context),
          child: LayoutBuilder(
            builder: (context, constraints) => SizedBox(
              width: constraints.biggest.width,
              child: Observer(builder: (_) {
                return Text(
                  _store.search.isNotEmpty
                      ? _store.search
                      : "Lista de Produtos",
                );
              }),
            ),
          ),
        ),
        actions: [
          Observer(builder: (_) {
            if (_store.search.isNotEmpty) {
              return IconButton(
                onPressed: () => _store.setSearch(""),
                icon: Icon(Icons.close),
              );
            }

            return IconButton(
              onPressed: () => openSearch(context),
              icon: Icon(Icons.search),
            );
          }),
        ],
      ),
      body: Observer(builder: (context) {
        if (_store.firstLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.orange,
              strokeWidth: 2,
            ),
          );
        }

        if (_store.hasError) {
          return Center(
            child: ErrorPlaceholder(
              error: _store.error,
              retry: _store.reset,
            ),
          );
        }

        return RefreshIndicator(
          backgroundColor: AppColors.lightBlue,
          color: Colors.white,
          onRefresh: _store.reset,
          child: _store.list.isEmpty
              ? Center(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Center(
                      child: EmptyPlaceholder(
                        title: "Nenhum produto cadastrado!",
                        subTitle: "Arraste para recarregar.",
                        asset: AppAssets.svgIcPurchaseItemsEmpty,
                      ),
                    ),
                  ),
                )
              : ListView.separated(
                  itemCount: _store.listCount,
                  separatorBuilder: (context, index) => Divider(
                    height: 1,
                    color: AppColors.lightGrey,
                  ),
                  itemBuilder: (context, index) {
                    if (index < _store.list.length) {
                      final product = _store.list[index];

                      return Dismissible(
                        key: Key(product.sId),
                        onDismissed: (direction) =>
                            _store.deleteProduct(product.sId),
                        confirmDismiss: (direction) =>
                            _confirmDismiss(context, direction, product),
                        direction: DismissDirection.endToStart,
                        background: DismissibleBackground(
                          title: "Excluir",
                          icon: Icons.delete_forever_rounded,
                          color: AppColors.red,
                          secondary: true,
                        ),
                        child: ProductTile(
                          product,
                          onTap: () =>
                              _navigateToProductDetails(context, product),
                          hidePrice: true,
                        ),
                      );
                    }

                    _store.loadNextPage();
                    return SizedBox(
                      height: 5,
                      child: LinearProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation(AppColors.darkOrange),
                      ),
                    );
                  },
                ),
        );
      }),
    );
  }

  Future<bool> _confirmDismiss(BuildContext context, DismissDirection direction,
      ProductModel model) async {
    final response = await showDialog(
      context: context,
      builder: (context) => SimpleConfirmDialog(
        title: "Excluir produto?",
        content:
            "Tem certeza que deseja remover este produto? (${model.getCombinedName()})",
        acceptText: "excluir",
        rejectText: "cancelar",
      ),
    );

    return response != null && response == true;
  }

  void _navigateToProductDetails(BuildContext context, ProductModel model) {
    Navigator.push<ProductModel>(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsView(
          product: model,
        ),
      ),
    );

    _store.getById(model.sId);
  }
}
