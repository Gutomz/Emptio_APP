import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:flutter/material.dart';
import 'package:emptio/helpers/extensions.dart';

class ProductMarketIndicator extends StatelessWidget {
  const ProductMarketIndicator({
    Key? key,
    required this.purchase,
    required this.product,
  }) : super(key: key);

  final PurchaseModel purchase;
  final ProductModel product;

  bool hasImage() {
    return purchase.market != null &&
        purchase.market!.image != null &&
        purchase.market!.image!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            image: hasImage()
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      purchase.market!.image!,
                    ),
                  )
                : null,
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: !hasImage()
              ? Icon(
                  Icons.image_not_supported_outlined,
                  color: AppColors.black,
                  size: 18,
                )
              : null,
        ),
        SizedBox(width: 20),
        Expanded(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  purchase.market!.name,
                  style: TextStyle(
                    color: AppColors.orange,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (product.marketPrice != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.event_available_rounded,
                            color: Colors.white,
                            size: 12,
                          ),
                          SizedBox(width: 5),
                          Text(
                            product.marketPriceUpdatedAt!.formatDate(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
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
                            product.marketPrice!.formatMoney(),
                            style: TextStyle(
                              fontSize: 14,
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
        ),
      ],
    );
  }
}