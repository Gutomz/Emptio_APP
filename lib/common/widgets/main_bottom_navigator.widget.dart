import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/views/home/store/home.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class MainBottomNavigationBar extends StatelessWidget {
  MainBottomNavigationBar({
    Key? key,
    required this.icons,
    required this.labels,
  }) : super(key: key);

  final List<IconData> icons;
  final List<String> labels;
  final HomeStore _homeStore = GetIt.I<AppStore>().homeStore;
  final AuthStore _authStore = GetIt.I<AuthStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return AnimatedBottomNavigationBar.builder(
        itemCount: _authStore.isLogged ? icons.length : icons.length - 2,
        tabBuilder: (index, active) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icons[index],
                color: active ? AppColors.orange : Colors.white,
              ),
              Text(
                labels[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: active ? AppColors.orange : Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        },
        activeIndex: _homeStore.currentTab,
        onTap: _homeStore.changeTab,
        elevation: 15,
        backgroundColor: AppColors.blue,
      );
    });
  }
}
