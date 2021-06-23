import 'package:emptio/common/widgets/user_avatar.widget.dart';
import 'package:flutter/material.dart';

class MainAppBar extends AppBar {
  MainAppBar({
    required Widget title,
    required BuildContext drawerContext,
    List<Widget>? actions,
    PreferredSizeWidget? bottom,
  }) : super(
          elevation: 10,
          title: title,
          leading: GestureDetector(
            onTap: () {
              Scaffold.of(drawerContext).openDrawer();
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: UserAvatar(),
            ),
          ),
          actions: actions,
          bottom: bottom,
        );
}
