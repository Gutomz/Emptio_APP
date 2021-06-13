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
    if (purchase.status.contains(PurchaseStatusTypes.OPEN)) {
      return purchase.createdAt.formatDate();
    }

    return purchase.updatedAt.formatDate();
  }

  String getItemsCountText() {
    if (purchase.items.length == 0) {
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
    if (purchase.status.contains(PurchaseStatusTypes.OPEN)) {
      return purchase.estimatedCost.formatMoney();
    }

    return purchase.cost.formatMoney();
  }

  bool hasImage() {
    return purchase.market != null &&
        purchase.market!.image != null &&
        purchase.market!.image!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: AppColors.lightGrey,
            width: 1,
          ),
        )),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                image: hasImage()
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(purchase.market!.image!),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      getMarketName(),
                      style: TextStyle(
                          color: AppColors.darkBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                  ),
                  Container(
                    child: Row(
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

class SubtitleItem extends StatelessWidget {
  const SubtitleItem({
    Key? key,
    required this.icon,
    this.text,
  }) : super(key: key);

  final IconData icon;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.grey,
          size: 12,
        ),
        SizedBox(width: 5),
        Expanded(
          child: Container(
            child: Text(
              text ?? "-",
              maxLines: 1,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.grey,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
