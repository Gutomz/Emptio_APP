import 'package:emptio/common/widgets/add_item_bottom_appbar.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/market.model.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/views/edit_purchase_item/store/edit_purchase_item.store.dart';
import 'package:emptio/views/edit_purchase_item/widgets/product_header.widget.dart';
import 'package:emptio/views/edit_purchase_item/widgets/product_market_indicator.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:emptio/helpers/extensions.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EditPurchaseItemView extends StatelessWidget {
  final EditPurchaseItemStore store;
  final MarketModel? connectedMarket;
  final ProductModel product;
  final bool isBaseItem;

  final MoneyMaskedTextController controller;

  EditPurchaseItemView({
    Key? key,
    required this.product,
    this.connectedMarket,
    double? initialPrice,
    int? initialQuantity,
    bool? initialChecked,
    this.isBaseItem = false,
  })  : store = EditPurchaseItemStore(
          price: initialPrice ?? 0,
          quantity: initialQuantity ?? 1,
          checked: initialChecked ?? false,
        ),
        controller = MoneyMaskedTextController(
          leftSymbol: 'R\$ ',
          initialValue: initialPrice ?? 0,
        ),
        super(key: key);

  void onAddPressed(BuildContext context) {
    if (isBaseItem) {
      return Navigator.of(context).pop(store.itemBaseModel);
    }

    return Navigator.of(context).pop(store.itemModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        bottom: connectedMarket != null
            ? PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 10,
                  ),
                  child: ProductMarketIndicator(
                    market: connectedMarket!,
                    product: product,
                  ),
                ),
              )
            : null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 25),
          child: Column(
            children: [
              ProductHeader(product: product),
              if (!isBaseItem) SizedBox(height: 25),
              if (!isBaseItem)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Preço",
                      style: TextStyle(
                        color: AppColors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: controller,
                      keyboardType: TextInputType.numberWithOptions(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                      onChanged: (value) {
                        store.setPrice(controller.numberValue);
                      },
                    ),
                    SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (product.marketPrice != null)
                          RichText(
                            text: TextSpan(
                              text: 'O valor encontrado foi de ',
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      'R\$ ${product.marketPrice!.formatMoney()}',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        RichText(
                          text: TextSpan(
                            text: 'Altere o valor caso necessário.',
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Observer(builder: (context) {
        return AddItemBottomAppBar(
          hideTotal: isBaseItem,
          onDecrementPressed:
              store.minQuantityReached ? null : store.decrementQuantity,
          onIncrementPressed:
              store.maxQuantityReached ? null : store.incrementQuantity,
          onAddPressed: () => onAddPressed(context),
          quantity: store.quantity,
          total: store.total,
        );
      }),
    );
  }
}
