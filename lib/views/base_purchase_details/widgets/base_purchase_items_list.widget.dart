import 'package:emptio/common/widgets/empty_placeholder.widget.dart';
import 'package:emptio/core/app_assets.dart';
import 'package:emptio/models/base_purchase_item.model.dart';
import 'package:emptio/views/base_purchase_details/store/base_purchase_details.store.dart';
import 'package:emptio/views/base_purchase_details/store/base_purchase_item.store.dart';
import 'package:emptio/views/base_purchase_details/widgets/base_purchase_item_tile.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class BasePurchaseItemsList extends StatelessWidget {
  final BasePurchaseDetailsStore store;

  BasePurchaseItemsList({
    required this.store,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (store.filtredItems.isEmpty) {
        return EmptyPlaceholder(
          title: "Nenhum produto adicionado",
          subTitleBefore: "Clique em",
          subTitleAfter: "para adicionar um novo!",
          asset: AppAssets.svgIcPurchaseItemsEmpty,
        );
      }

      return ListView.builder(
        key: PageStorageKey<String>('base_purchase_details_items_list'),
        itemCount: store.itemsCount,
        itemBuilder: (context, index) {
          BasePurchaseItemModel item = store.filtredItems[index];

          return BasePurchaseItemTile(
            item: item,
            store: BasePurchaseItemStore(
              purchaseStore: store,
              itemId: item.sId,
              quantity: item.quantity,
            ),
          );
        },
      );
    });
  }
}
