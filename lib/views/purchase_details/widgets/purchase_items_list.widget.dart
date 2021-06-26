import 'package:emptio/common/widgets/empty_placeholder.widget.dart';
import 'package:emptio/core/app_assets.dart';
import 'package:emptio/models/purchase_item.model.dart';
import 'package:emptio/views/purchase_details/store/purchase_details.store.dart';
import 'package:emptio/views/purchase_details/widgets/checked_purchase_item_tile.widget.dart';
import 'package:emptio/views/purchase_details/widgets/purchase_item_tile.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PurchaseItemsList extends StatelessWidget {
  final PurchaseDetailsStore store;

  PurchaseItemsList({
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
        key: PageStorageKey<String>('purchase_details_items_list'),
        itemCount: store.itemsCount,
        itemBuilder: (context, index) {
          PurchaseItemModel item = store.filtredItems[index];

          if (store.showChecked) {
            return CheckedPurchaseItemTile(
              item: item,
              purchaseStore: store,
            );
          }

          return PurchaseItemTile(
            item: item,
            purchaseStore: store,
          );
        },
      );
    });
  }
}
