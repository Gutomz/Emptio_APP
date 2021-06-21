import 'package:emptio/common/widgets/add_item_bottom_appbar.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/view-models/update_purchase_item.view-model.dart';
import 'package:emptio/views/edit_purchase_item/store/edit_purchase_item.store.dart';
import 'package:emptio/views/edit_purchase_item/widgets/product_header.widget.dart';
import 'package:emptio/views/edit_purchase_item/widgets/product_market_indicator.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:emptio/helpers/extensions.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EditPurchaseItemView extends StatelessWidget {
  late final MoneyMaskedTextController controller;

  final EditPurchaseItemStore store;
  final PurchaseModel purchase;
  final ProductModel product;

  EditPurchaseItemView({
    required this.store,
    required this.purchase,
    required this.product,
    Key? key,
  }) {
    controller = MoneyMaskedTextController(
      decimalSeparator: ',',
      thousandSeparator: '.',
      leftSymbol: 'R\$ ',
      initialValue: store.price,
      precision: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        bottom: purchase.market != null
            ? PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 10,
                  ),
                  child: ProductMarketIndicator(
                    purchase: purchase,
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
              SizedBox(height: 25),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                    keyboardType: TextInputType.numberWithOptions(
                      signed: false,
                      decimal: false,
                    ),
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
          onDecrementPressed:
              store.minQuantityReached ? null : store.decrementQuantity,
          onIncrementPressed:
              store.maxQuantityReached ? null : store.incrementQuantity,
          onAddPressed: () {
            Navigator.of(context).pop(
              UpdatePurchaseItemViewModel(
                price: store.price,
                quantity: store.quantity,
                checked: store.checked,
              ),
            );
          },
          quantity: store.quantity,
          total: store.total,
        );
      }),
    );
  }
}
