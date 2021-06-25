import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/market.model.dart';
import 'package:flutter/material.dart';

class MarketIndicator extends StatelessWidget {
  final MarketModel market;

  MarketIndicator({required this.market, Key? key}) : super(key: key);

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
