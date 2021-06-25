import 'package:emptio/common/widgets/main_bottom_navigator.widget.dart';
import 'package:emptio/common/widgets/main_drawer.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/stores/connectivity.store.dart';
import 'package:emptio/view-models/create_purchase.view-model.dart';
import 'package:emptio/views/base_purchase_details/base_purchase_details.view.dart';
import 'package:emptio/views/base_purchases/base_purchases.view.dart';
import 'package:emptio/views/base_purchases/store/base_purchases.store.dart';
import 'package:emptio/views/favorites/favorites.view.dart';
import 'package:emptio/views/feed/feed.view.dart';
import 'package:emptio/views/purchase_details/purchase_details.view.dart';
import 'package:emptio/views/purchases/purchases.view.dart';
import 'package:emptio/views/purchases/store/purchases.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ConnectivityStore _connectivityStore = GetIt.I<ConnectivityStore>();
  AuthStore _authStore = GetIt.I<AuthStore>();
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

  late ReactionDisposer _disposer;

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

    _disposer = reaction(
      (_) => _connectivityStore.isConnected,
      (bool connected) {
        if (_authStore.isActive) {
          if (connected) {
            _authStore.initAuthenticated();
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                !connected
                    ? 'Sem conexão com a internet!'
                    : 'Conectado à internet!',
              ),
              backgroundColor: AppColors.darkGrey,
              duration: Duration(seconds: 5),
            ),
          );

          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(builder: (context) {
        return Scaffold(
          body: PageStorage(
            child: screens[_appStore.homeStore.currentTab],
            bucket: _appStore.homeStore.bucket,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                onFabPressed(context, _appStore.homeStore.currentTab),
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
          ),
        );
      }),
    );
  }

  Future<void> purchasesViewAction(BuildContext context) async {
    PurchasesStore _purchasesStore = _appStore.openPurchasesStore;
    PurchaseModel? purchase =
        await _purchasesStore.createPurchase(CreatePurchaseViewModel());

    if (purchase != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PurchaseDetailsView(purchase: purchase),
      ));
    }
  }

  Future<void> basePurchasesViewAction(BuildContext context) async {
    BasePurchasesStore _basePurchasesStore = _appStore.basePurchasesStore;
    BasePurchaseModel? purchase = await _basePurchasesStore.createPurchase();

    if (purchase != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BasePurchaseDetailsView(purchase: purchase),
      ));
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
