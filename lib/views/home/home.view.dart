import 'package:emptio/common/delegates/product_search/product_search.dart';
import 'package:emptio/common/widgets/main_bottom_navigator.widget.dart';
import 'package:emptio/common/widgets/main_drawer.widget.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/create_purchase.view-model.dart';
import 'package:emptio/views/base_purchase_details/base_purchase_details.view.dart';
import 'package:emptio/views/base_purchases/base_purchases.view.dart';
import 'package:emptio/views/favorite_details/favorite_details.view.dart';
import 'package:emptio/views/favorites/favorites.view.dart';
import 'package:emptio/views/feed/feed.view.dart';
import 'package:emptio/views/purchase_details/purchase_details.view.dart';
import 'package:emptio/views/purchases/purchases.view.dart';
import 'package:emptio/views/search_profile/profile_search.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _authStore = GetIt.I<AuthStore>();
  final _appStore = GetIt.I<AppStore>();

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
  ];

  final List<Future<void> Function(BuildContext)> actions = [];

  void onFabPressed(BuildContext context, int currentTab) {
    actions[currentTab](context);
  }

  @override
  void initState() {
    actions.addAll([
      purchasesViewAction,
      basePurchasesViewAction,
      favoritesViewAction,
      feedViewAction,
    ]);

    if (_authStore.isLogged) {
      screens.addAll([
        FavoritesView(),
        FeedView(),
      ]);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        return Scaffold(
          body: PageStorage(
            bucket: _appStore.homeStore.bucket,
            child: screens[_appStore.homeStore.currentTab],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                onFabPressed(context, _appStore.homeStore.currentTab),
            child: Observer(builder: (_) {
              return Icon(
                getScreenFABIcon(),
                color: Colors.white,
              );
            }),
          ),
          drawer: MainDrawer(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: MainBottomNavigationBar(
            icons: icons,
            labels: labels,
          ),
        );
      }),
    );
  }

  IconData getScreenFABIcon() {
    switch (_appStore.homeStore.currentTab) {
      case 0:
        return Icons.add_shopping_cart_rounded;
      case 1:
        return Icons.post_add_outlined;
      case 2:
        return Icons.favorite_border_rounded;
      case 3:
        return Icons.group_add_outlined;
      default:
        return Icons.add;
    }
  }

  Future<void> purchasesViewAction(BuildContext context) async {
    final _purchasesStore = _appStore.openPurchasesStore;
    final purchase =
        await _purchasesStore.createPurchase(CreatePurchaseViewModel());

    if (purchase != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PurchaseDetailsView(purchase: purchase),
      ));
    }
  }

  Future<void> basePurchasesViewAction(BuildContext context) async {
    final _basePurchasesStore = _appStore.basePurchasesStore;
    final purchase = await _basePurchasesStore.createPurchase();

    if (purchase != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BasePurchaseDetailsView(purchase: purchase),
      ));
    }
  }

  Future<void> favoritesViewAction(BuildContext context) async {
    final _favoritesStore = _appStore.favoritesStore;
    final response = await showSearch(
      context: context,
      delegate: ProductSearch(
        canAddNew: false,
        isFavorite: true,
      ),
    );

    if (response != null) {
      final favorite = await _favoritesStore.create(response.product!.sId);

      if (favorite != null) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                FavoriteDetailsView(favoriteId: favorite.sId)));
      }
    }
  }

  Future<void> feedViewAction(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfileSearchView(),
      ),
    );
  }
}
