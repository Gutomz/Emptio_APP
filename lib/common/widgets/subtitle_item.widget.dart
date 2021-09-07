import 'package:emptio/core/app_colors.dart';
import 'package:flutter/material.dart';

class SubtitleItem extends StatelessWidget {
  const SubtitleItem({
    Key? key,
    required this.icon,
    this.text,
    this.canWrap = false,
    this.iconSize = 12,
    this.textSize = 12,
  }) : super(key: key);

  final IconData icon;
  final String? text;
  final bool canWrap;
  final double iconSize;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.grey,
          size: iconSize,
        ),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            text ?? "-",
            maxLines: canWrap ? 2 : 1,
            style: TextStyle(
              fontSize: textSize,
              color: AppColors.grey,
            ),
            overflow: canWrap ? null : TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
