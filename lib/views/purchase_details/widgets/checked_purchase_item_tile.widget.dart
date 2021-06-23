import 'package:emptio/common/widgets/dismissible_background.widget.dart';
import 'package:emptio/common/widgets/subtitle_item.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/purchase_item.model.dart';
import 'package:emptio/views/purchase_details/store/purchase_item.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:emptio/helpers/extensions.dart';

class CheckedPurchaseItemTile extends StatelessWidget {
  final PurchaseItemStore store;
  final PurchaseItemModel item;

  CheckedPurchaseItemTile({
    required this.item,
    required this.store,
    Key? key,
  }) : super(key: key);

  void onDismissed(DismissDirection direction) {
    store.toggleChecked();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.sId),
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: DismissibleBackground(
        icon: Icons.remove_done_rounded,
        title: 'Remover',
        color: AppColors.red,
        secondary: true,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.lightGrey,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 95,
              height: 95,
              decoration: BoxDecoration(
                image: hasImage()
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(item.product.image!),
                      )
                    : null,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                border: Border.all(color: AppColors.grey),
                color: AppColors.lightGrey.withOpacity(0.2),
              ),
              child: !hasImage()
                  ? Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.black,
                      size: 32,
                    )
                  : null,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 95,
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
                              fontSize: 14,
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
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
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
                                  SubtitleItem(
                                    icon: Icons.shopping_cart_outlined,
                                    text: item.quantity.toString(),
                                  ),
                                  SubtitleItem(
                                    icon: Icons.monetization_on_outlined,
                                    text: "R\$${item.price.formatMoney()}",
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool hasImage() {
    return item.product.image != null && item.product.image!.isNotEmpty;
  }
}
