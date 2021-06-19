import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/market.model.dart';
import 'package:flutter/material.dart';

class MarketIndicator extends StatelessWidget {
  final MarketModel market;

  MarketIndicator({required this.market, Key? key}) : super(key: key);

  bool hasImage() {
    return market.image != null && market.image!.isNotEmpty;
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
                    image: NetworkImage(market.image!),
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
        Text(
          market.name,
          style: TextStyle(
            color: AppColors.orange,
          ),
        ),
      ],
    );
  }
}
