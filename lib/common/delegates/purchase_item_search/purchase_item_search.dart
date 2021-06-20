import 'package:emptio/common/widgets/dismissible_background.widget.dart';
import 'package:emptio/common/widgets/market_indicator.widget.dart';
import 'package:emptio/common/widgets/product_tile.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/stores/product_search.store.dart';
import 'package:emptio/view-models/add_purchase_item.view-model.dart';
import 'package:emptio/views/purchase_details/store/purchase_details.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProductSearch extends SearchDelegate<ProductModel?> {
  late ProductSearchStore _store;
  final PurchaseDetailsStore detailsStore;

  ProductSearch({required this.detailsStore}) {
    _store = ProductSearchStore(
      purchaseId: this.detailsStore.purchase.sId,
      limit: 10,
    );
  }

  @override
  String? get searchFieldLabel => "Pesquisar produto";

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          decoration: TextDecoration.none,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white70),
      ),
      textSelectionTheme: TextSelectionThemeData(cursorColor: AppColors.orange),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear),
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  PreferredSizeWidget? buildBottom(BuildContext context) {
    if (detailsStore.isMarketConnected) {
      return PreferredSize(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 15),
          child: MarketIndicator(market: detailsStore.purchase.market!),
        ),
        preferredSize: Size.fromHeight(75),
      );
    }

    return super.buildBottom(context);
  }

  @override
  Widget buildResults(BuildContext context) {
    _store.resetPage(query);

    return Observer(builder: (context) {
      if (_store.error.isNotEmpty) {
        return Center(
          child: Text(_store.error),
        );
      }

      if (_store.firstLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (_store.productsList.isEmpty) {
        return Column(
          children: [
            AddProductTile(
              title: 'Adicionar novo produto',
              onTap: () {},
            ),
            Divider(height: 1, color: AppColors.lightGrey),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                'Nenhum produto encontrado.',
                style: TextStyle(color: AppColors.black),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      }

      return ListView.separated(
        itemCount: _store.itemCount + 1,
        separatorBuilder: (context, index) => Divider(
          height: 1,
          color: AppColors.lightGrey,
        ),
        itemBuilder: (context, index) {
          if (index == 0) {
            return AddProductTile(
              title: 'Adicionar novo produto',
              onTap: () {},
            );
          }

          if (index - 1 < _store.productsList.length) {
            ProductModel product = _store.productsList[index - 1];

            return Dismissible(
              key: Key(product.sId!),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) => onQuickSelect(product),
              background: DismissibleBackground(
                icon: Icons.check_rounded,
                title: "Adicionar",
                color: AppColors.green,
              ),
              child: ProductTile(
                product,
                onTap: () {},
              ),
            );
          }

          _store.loadNextPage();
          return Container(
            height: 5,
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AppColors.darkOrange),
            ),
          );
        },
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text(
        "Nenhuma sugestão encontrada!",
        style: TextStyle(
          color: AppColors.grey,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  void onQuickSelect(ProductModel product) {
    detailsStore.addItem(AddPurchaseItemViewModel(
      price: product.marketPrice ?? 0,
      quantity: 1,
      productId: product.sId,
    ));

    _store.removeProduct(product.sId!);
  }
}

class AddProductTile extends StatelessWidget {
  final String title;
  final Function() onTap;

  const AddProductTile({
    required this.title,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onTap(),
      tileColor: Colors.white,
      leading: Icon(
        Icons.add_circle_outline_outlined,
        color: AppColors.grey,
      ),
      minLeadingWidth: 55,
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.grey,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Icon(
        Icons.double_arrow_rounded,
        size: 16,
        color: AppColors.grey,
      ),
    );
  }
}
