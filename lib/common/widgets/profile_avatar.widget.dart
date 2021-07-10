import 'package:emptio/core/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? image;
  final double radius;
  final double borderGap;
  final double iconSize;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? iconColor;
  final IconData? icon;

  ProfileAvatar({
    Key? key,
    required this.image,
    this.radius = 34,
    this.borderGap = 35,
    this.iconSize = 30,
    this.backgroundColor,
    this.foregroundColor,
    this.iconColor,
    this.icon,
  }) : super(key: key);

  Widget _buildImage(String? _image) {
    if (_image == null || _image.isEmpty) {
      return Icon(
        icon ?? Icons.person,
        size: iconSize,
        color: iconColor ?? Colors.white,
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.network(
          _image,
          width: (radius * 2) - borderGap,
          height: (radius * 2) - borderGap,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor ?? AppColors.darkOrange,
      foregroundColor: foregroundColor ?? AppColors.white,
      radius: radius,
      child: _buildImage(image),
    );
  }
}
