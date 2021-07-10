import 'package:emptio/common/widgets/profile_avatar.widget.dart';
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

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return ProfileAvatar(
        image: _authStore.isLogged ? _authStore.user?.photo : null,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        borderGap: borderGap,
        icon: icon,
        iconColor: iconColor,
        iconSize: iconSize,
        radius: radius,
      );
    });
  }
}
