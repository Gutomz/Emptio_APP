import 'dart:math';

import 'package:emptio/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyPlaceholderCreation extends StatelessWidget {
  final TextStyle _spanStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  final String title;
  final String subTitleBefore;
  final String subTitleAfter;
  final String asset;
  final IconData icon;

  EmptyPlaceholderCreation({
    Key? key,
    required this.title,
    required this.subTitleBefore,
    required this.subTitleAfter,
    required this.asset,
    this.icon = Icons.add,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(asset),
        SizedBox(height: 15),
        Text(title, style: _spanStyle),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(subTitleBefore, style: _spanStyle),
            SizedBox(width: 5),
            SizedBox(
              width: 25,
              height: 25,
              child: FloatingActionButton(
                heroTag: 'none',
                onPressed: null,
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 14,
                ),
              ),
            ),
            SizedBox(width: 5),
            Text(subTitleAfter, style: _spanStyle),
          ],
        ),
      ],
    );
  }
}

class EmptyPlaceholder extends StatelessWidget {
  final TextStyle _spanStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  final String title;
  final String subTitle;
  final String asset;
  final bool hideScrollIndicator;

  EmptyPlaceholder({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.asset,
    this.hideScrollIndicator = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(asset),
        SizedBox(height: 15),
        Text(title, style: _spanStyle),
        Text(subTitle, style: _spanStyle),
        if (!hideScrollIndicator) ...[
          SizedBox(height: 15),
          Transform.rotate(
            angle: 90 * (pi / 180),
            child: Icon(
              Icons.double_arrow_rounded,
              color: AppColors.grey,
            ),
          ),
        ]
      ],
    );
  }
}
