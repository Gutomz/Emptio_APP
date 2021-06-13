import 'package:emptio/common/widgets/main_bottom_navigator.widget.dart';
import 'package:emptio/common/widgets/main_drawer.widget.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/views/base_purchases/base_purchases.view.dart';
import 'package:emptio/views/favorites/favorites.view.dart';
import 'package:emptio/views/feed/feed.view.dart';
import 'package:emptio/views/home/store/home.store.dart';
import 'package:emptio/views/purchases/purchases.view.dart';
import 'package:emptio/views/purchases/store/purchases.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class HomeView extends StatelessWidget {
  final AppStore _appStore = GetIt.I<AppStore>();

  final List<IconData> icons = [
    Icons.local_grocery_store_rounded,
    Icons.library_books,
    Icons.favorite,
    Icons.sensors,
  ];

  final List<String> labels = [
    "Compras",
    "Listas",
    "Favoritos",
    "Notícias",
  ];

  final List<Widget> screens = [
    PurchasesView(),
    BasePurchasesView(),
    FavoritesView(),
    FeedView(),
  ];

  final List<Future<void> Function()> actions = [];

  final PageStorageBucket _bucket = PageStorageBucket();

  late final HomeStore _homeStore;

  HomeView({Key? key}) {
    _homeStore = HomeStore(screens);
    actions.addAll([
      purchasesViewAction,
      basePurchasesViewAction,
      favoritesViewAction,
      feedViewAction,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        body: PageStorage(
          child: _homeStore.currentView,
          bucket: _bucket,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: actions[_homeStore.currentTab],
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        drawer: MainDrawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: MainBottomNavigationBar(
          icons: icons,
          labels: labels,
          homeStore: _homeStore,
        ),
      );
    });
  }

  // * Purchases View action
  Future<void> purchasesViewAction() async {
    PurchasesStore _purchasesStore = _appStore.openPurchasesStore;
    await _purchasesStore.createPurchase();
  }

  Future<void> basePurchasesViewAction() async {
    // TODO - Base Purchases View action
    print('Create Base Purchase');
  }

  Future<void> favoritesViewAction() async {
    // TODO - Favorites View action
    print('Add favorite');
  }

  Future<void> feedViewAction() async {
    // TODO - Feed View action
    print('Add post');
  }
}
