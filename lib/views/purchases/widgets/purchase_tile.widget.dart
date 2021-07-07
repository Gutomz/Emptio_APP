import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/common/widgets/subtitle_item.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:flutter/material.dart';
import 'package:emptio/helpers/extensions.dart';

class PurchaseTile extends StatelessWidget {
  final PurchaseModel purchase;
  final Function onTap;

  const PurchaseTile(
    this.purchase, {
    Key? key,
    required this.onTap,
  }) : super(key: key);

  String getDateText() {
    if (purchase.status.contains(PurchaseStatusTypes.open)) {
      return purchase.createdAt.formatDate();
    }

    return purchase.updatedAt.formatDate();
  }

  String getItemsCountText() {
    if (purchase.items.isEmpty) {
      return "Nenhum prduto";
    }

    if (purchase.items.length == 1) {
      return "1 produto";
    }

    return "${purchase.items.length} produtos";
  }

  String getMarketName() {
    if (purchase.market == null) {
      return "Nenhum mercado conectado";
    }

    return purchase.market!.name;
  }

  String getPriceText() {
    if (purchase.status.contains(PurchaseStatusTypes.open)) {
      return purchase.estimatedCost.formatMoney();
    }

    return purchase.cost.formatMoney();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            ImageBuilder.fromString(
                purchase.market != null ? purchase.market!.image : null),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getMarketName(),
                    style: TextStyle(
                        color: AppColors.darkBlue,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            SubtitleItem(
                              icon: Icons.location_on_outlined,
                              text: purchase.market?.address,
                            ),
                            SubtitleItem(
                              icon: Icons.shopping_cart_outlined,
                              text: getItemsCountText(),
                            ),
                            SubtitleItem(
                              icon: Icons.event,
                              text: getDateText(),
                            ),
                          ],
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
                          Text(
                            getPriceText(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
