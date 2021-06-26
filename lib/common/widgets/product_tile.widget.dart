import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/common/widgets/subtitle_item.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/product.model.dart';
import 'package:flutter/material.dart';
import 'package:emptio/helpers/extensions.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;
  final Function onTap;
  final bool hidePrice;

  const ProductTile(this.product,
      {Key? key, required this.onTap, this.hidePrice = false})
      : super(key: key);

  String getDateText() {
    if (product.marketPrice != null) {
      return product.marketPriceUpdatedAt!;
    }

    return "-";
  }

  String getPriceText() {
    return (product.marketPrice ?? 0).formatMoney();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Hero(
              tag: 'product${product.sId}',
              child: ImageBuilder.fromString(
                product.image,
                size: 60,
                iconSize: 22,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              product.getCombinedName(),
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
                            color: AppColors.grey,
                            size: 16,
                          )
                        ],
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
                                  icon: Icons.business_rounded,
                                  text: product.brand,
                                ),
                                SubtitleItem(
                                  icon: Icons.straighten_rounded,
                                  text: product.weight.toString(),
                                ),
                                SubtitleItem(
                                  icon: Icons.event,
                                  text: getDateText(),
                                ),
                              ],
                            ),
                          ),
                          if (!hidePrice)
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
            ),
          ],
        ),
      ),
    );
  }
}
