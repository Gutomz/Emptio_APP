import 'package:emptio/core/app_colors.dart';
import 'package:flutter/material.dart';

class SubtitleItem extends StatelessWidget {
  const SubtitleItem({
    Key? key,
    required this.icon,
    this.text,
    this.canWrap = false,
  }) : super(key: key);

  final IconData icon;
  final String? text;
  final bool canWrap;

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
          child: Text(
            text ?? "-",
            maxLines: canWrap ? 2 : 1,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.grey,
            ),
            overflow: canWrap ? null : TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
