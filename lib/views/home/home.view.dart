import 'package:emptio/common/widgets/main_bottom_navigator.widget.dart';
import 'package:emptio/common/widgets/main_drawer.widget.dart';
import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/views/base_purchases/base_purchases.view.dart';
import 'package:emptio/views/base_purchases/store/base_purchases.store.dart';
import 'package:emptio/views/favorites/favorites.view.dart';
import 'package:emptio/views/feed/feed.view.dart';
import 'package:emptio/views/home/store/home.store.dart';
import 'package:emptio/views/purchase_details/purchase_details.view.dart';
import 'package:emptio/views/purchases/purchases.view.dart';
import 'package:emptio/views/purchases/store/purchases.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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

  final List<Future<void> Function(BuildContext)> actions = [];

  final HomeStore _homeStore = GetIt.I<AppStore>().homeStore;

  void onFabPressed(BuildContext context, int currentTab) {
    Function(BuildContext) action = actions[currentTab];
    action(context);
  }

  @override
  void initState() {
    actions.addAll([
      purchasesViewAction,
      basePurchasesViewAction,
      favoritesViewAction,
      feedViewAction,
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        body: PageStorage(
          child: screens[_homeStore.currentTab],
          bucket: _homeStore.bucket,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => onFabPressed(context, _homeStore.currentTab),
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

  Future<void> purchasesViewAction(BuildContext context) async {
    PurchasesStore _purchasesStore = _appStore.openPurchasesStore;
    PurchaseModel? purchase = await _purchasesStore.createPurchase();

    if (purchase != null) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PurchaseDetailsView(
            purchase: purchase,
          ),
        ),
      );
    }
  }

  Future<void> basePurchasesViewAction(BuildContext context) async {
    BasePurchasesStore _basePurchasesStore = _appStore.basePurchasesStore;
    BasePurchaseModel? purchase = await _basePurchasesStore.createPurchase();

    if (purchase != null) {
      // TODO - navigate to BasePurchaseDetailsView
    }
  }

  Future<void> favoritesViewAction(BuildContext context) async {
    // TODO - Favorites View action
    print('Add favorite');
  }

  Future<void> feedViewAction(BuildContext context) async {
    // TODO - Feed View action
    print('Add post');
  }
}
