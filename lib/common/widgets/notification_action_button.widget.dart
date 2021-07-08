import 'package:badges/badges.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class NotificationActionButton extends StatelessWidget {
  NotificationActionButton({Key? key}) : super(key: key);

  final AuthStore _authStore = GetIt.I<AuthStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (_authStore.isLogged) {
        return Badge(
          badgeContent: Text(
            "${_authStore.user!.notificationCount}",
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          showBadge: _authStore.user!.notificationCount > 0,
          position: BadgePosition.topEnd(top: 7, end: 7),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_outlined),
          ),
        );
      }

      return Container();
    });
  }
}
