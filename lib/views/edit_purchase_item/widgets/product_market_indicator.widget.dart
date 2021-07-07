import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/market.model.dart';
import 'package:emptio/models/product.model.dart';
import 'package:flutter/material.dart';
import 'package:emptio/helpers/extensions.dart';

class ProductMarketIndicator extends StatelessWidget {
  const ProductMarketIndicator({
    Key? key,
    required this.market,
    required this.product,
  }) : super(key: key);

  final MarketModel market;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageBuilder.fromString(
          market.image,
          size: 35,
          iconSize: 18,
          borderRadius: 20,
          backgroundColor: Colors.white,
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                market.name,
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
      ],
    );
  }
}
