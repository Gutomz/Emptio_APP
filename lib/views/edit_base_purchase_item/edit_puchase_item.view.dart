import 'package:emptio/common/widgets/add_item_bottom_appbar.widget.dart';
import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/view-models/update_base_purchase_item.view-model.dart';
import 'package:emptio/views/edit_base_purchase_item/store/edit_base_purchase_item.store.dart';
import 'package:emptio/views/edit_purchase_item/widgets/product_header.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EditBasePurchaseItemView extends StatelessWidget {
  final EditBasePurchaseItemStore store;
  final BasePurchaseModel purchase;
  final ProductModel product;

  EditBasePurchaseItemView({
    required this.store,
    required this.purchase,
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 25),
          child: ProductHeader(product: product),
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
              UpdateBasePurchaseItemViewModel(
                quantity: store.quantity,
              ),
            );
          },
          quantity: store.quantity,
          hideTotal: true,
        );
      }),
    );
  }
}
