import 'package:emptio/common/widgets/dismissible_background.widget.dart';
import 'package:emptio/common/widgets/dismissible_confirm_dialog.widget.dart';
import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/common/widgets/subtitle_item.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/purchase_item.model.dart';
import 'package:emptio/view-models/update_purchase_item.view-model.dart';
import 'package:emptio/views/edit_purchase_item/edit_purchase_item.view.dart';
import 'package:emptio/views/purchase_details/store/purchase_details.store.dart';
import 'package:emptio/views/purchase_details/store/purchase_item.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:emptio/helpers/extensions.dart';

class PurchaseItemTile extends StatelessWidget {
  final PurchaseItemStore store;
  final PurchaseItemModel item;

  PurchaseItemTile({
    required this.item,
    required PurchaseDetailsStore purchaseStore,
    Key? key,
  })  : store = PurchaseItemStore(
          purchaseStore: purchaseStore,
          itemId: item.sId,
          price: item.price,
          quantity: item.quantity,
          checked: item.checked,
        ),
        super(key: key);

  void onDismissed(DismissDirection direction) {
    if (direction == DismissDirection.startToEnd) {
      store.toggleChecked();
    } else {
      store.deleteItem();
    }
  }

  Future<void> onPressed(BuildContext context) async {
    final update =
        await Navigator.of(context).push<UpdatePurchaseItemViewModel>(
      MaterialPageRoute(
        builder: (context) => EditPurchaseItemView(
          connectedMarket: store.purchaseStore.purchase.market,
          product: item.product,
          initialPrice: store.price,
          initialChecked: store.checked,
          initialQuantity: store.quantity,
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
            return ConfirmDismissDialog(
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
      onDismissed: onDismissed,
      confirmDismiss: (direction) => confirmDismiss(context, direction),
      background: DismissibleBackground(
        icon: Icons.check_rounded,
        title: 'Concluir',
        color: AppColors.green,
      ),
      secondaryBackground: DismissibleBackground(
        icon: Icons.delete,
        title: "Remover",
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
          child: Column(
            children: [
              Row(
                children: [
                  Hero(
                    tag: 'product${item.product.sId}',
                    child: ImageBuilder.fromString(
                      item.product.image,
                      size: 60,
                      iconSize: 22,
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Column(
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
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Container(
                      constraints: BoxConstraints.tight(Size(135, 35)),
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  SizedBox(width: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "R\$",
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.lightGrey,
                        ),
                      ),
                      Observer(builder: (_) {
                        return Text(
                          store.totalPrice.formatMoney(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.orange,
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
