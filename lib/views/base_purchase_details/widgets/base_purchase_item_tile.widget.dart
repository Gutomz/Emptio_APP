import 'package:emptio/common/widgets/dismissible_background.widget.dart';
import 'package:emptio/common/widgets/simple_confirm_dialog.widget.dart';
import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/common/widgets/subtitle_item.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/base_purchase_item.model.dart';
import 'package:emptio/view-models/update_base_purchase_item.view-model.dart';
import 'package:emptio/views/base_purchase_details/store/base_purchase_details.store.dart';
import 'package:emptio/views/base_purchase_details/store/base_purchase_item.store.dart';
import 'package:emptio/views/edit_purchase_item/edit_purchase_item.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class BasePurchaseItemTile extends StatelessWidget {
  final BasePurchaseItemStore store;
  final BasePurchaseItemModel item;

  BasePurchaseItemTile({
    required this.item,
    required BasePurchaseDetailsStore purchaseStore,
    Key? key,
  })  : store = BasePurchaseItemStore(
          purchaseStore: purchaseStore,
          itemId: item.sId,
          quantity: item.quantity,
        ),
        super(key: key);

  Future<void> onPressed(BuildContext context) async {
    final update =
        await Navigator.of(context).push<UpdateBasePurchaseItemViewModel>(
      MaterialPageRoute(
        builder: (context) => EditPurchaseItemView(
          product: item.product,
          initialQuantity: store.quantity,
          isBaseItem: true,
        ),
      ),
    );

    if (update != null) {
      store.setItem(update);
    }
  }

  Future<bool> confirmDismiss(
      BuildContext context, DismissDirection direction) async {
    if (direction == DismissDirection.endToStart) {
      final response = await showDialog<bool>(
          context: context,
          builder: (context) {
            return SimpleConfirmDialog(
              title: "Remover produto?",
              content:
                  "Tem certeza que deseja remover este produto da sua compra?",
              acceptText: "sim",
              rejectText: "cancelar",
            );
          });

      return Future.value(response ?? false);
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key("${DateTime.now().toIso8601String()}${item.sId}"),
      onDismissed: (direction) => store.deleteItem(),
      confirmDismiss: (direction) => confirmDismiss(context, direction),
      direction: DismissDirection.endToStart,
      background: DismissibleBackground(
        icon: Icons.delete,
        title: 'Remover',
        color: AppColors.red,
        secondary: true,
      ),
      child: InkWell(
        onTap: () => onPressed(context),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.lightGrey),
            ),
          ),
          child: Row(
            children: [
              Hero(
                tag: 'product${item.product.sId}',
                child: ImageBuilder.fromString(item.product.image),
              ),
              SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              item.product.getCombinedName(),
                              style: TextStyle(
                                color: AppColors.darkBlue,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.double_arrow_rounded,
                            color: AppColors.darkBlue,
                            size: 16,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Column(
                                children: [
                                  SubtitleItem(
                                    icon: Icons.business_rounded,
                                    text: item.product.brand,
                                  ),
                                  SubtitleItem(
                                    icon: Icons.straighten_rounded,
                                    text: item.product.weight.toString(),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Container(
                                      constraints:
                                          BoxConstraints.tight(Size(135, 35)),
                                      decoration: BoxDecoration(
                                        color: AppColors.blue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Observer(builder: (_) {
                                            return IconButton(
                                              onPressed: store.quantityMinLimit
                                                  ? null
                                                  : store.decrementQuantity,
                                              color: Colors.white,
                                              disabledColor: AppColors.grey,
                                              icon: Icon(Icons.remove),
                                              iconSize: 16,
                                              splashRadius: 16,
                                            );
                                          }),
                                          Observer(builder: (_) {
                                            return Text(
                                              store.quantity.toString(),
                                              style: TextStyle(
                                                color: AppColors.orange,
                                              ),
                                            );
                                          }),
                                          Observer(builder: (_) {
                                            return IconButton(
                                              onPressed: store.quantityMaxLimit
                                                  ? null
                                                  : store.incrementQuantity,
                                              color: Colors.white,
                                              disabledColor: AppColors.grey,
                                              icon: Icon(Icons.add),
                                              iconSize: 16,
                                              splashRadius: 16,
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
