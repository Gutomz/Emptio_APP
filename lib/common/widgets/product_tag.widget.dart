import 'package:emptio/core/app_colors.dart';
import 'package:flutter/material.dart';

class ProductTag extends StatelessWidget {
  const ProductTag({
    required this.title,
    this.fontSize = 10,
    this.canDelete = false,
    this.onDeleted,
    Key? key,
  }) : super(key: key);

  final String title;
  final bool canDelete;
  final Function()? onDeleted;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      labelPadding: EdgeInsets.symmetric(horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          color: AppColors.orange,
        ),
      ),
      label: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          color: AppColors.orange,
          fontWeight: FontWeight.w600,
        ),
      ),
      deleteIcon: canDelete
          ? Icon(
              Icons.cancel_outlined,
              color: AppColors.red,
              size: fontSize + 4,
            )
          : null,
      onDeleted: canDelete ? onDeleted : null,
      deleteButtonTooltipMessage: "Deletar",
    );
  }
}
