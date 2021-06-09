import 'package:emptio/core/app_colors.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class UserAvatar extends StatelessWidget {
  final AuthStore _authStore = GetIt.I<AuthStore>();

  final double radius;
  final double borderGap;
  final double iconSize;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? iconColor;
  final IconData? icon;

  UserAvatar({
    Key? key,
    this.radius = 34,
    this.borderGap = 35,
    this.iconSize = 30,
    this.backgroundColor,
    this.foregroundColor,
    this.iconColor,
    this.icon,
  }) : super(key: key);

  _buildImage(String? _image) {
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
      child: Observer(builder: (context){
        return _buildImage(_authStore.user?.photo);
      }),
    );
  }
}
