import 'package:emptio/common/widgets/empty_placeholder.widget.dart';
import 'package:emptio/common/widgets/main_app_bar.widget.dart';
import 'package:emptio/common/widgets/notificationActionButton.widget.dart';
import 'package:emptio/core/app_assets.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/views/purchases/store/purchases.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class PurchasesView extends StatelessWidget {
  PurchasesView({Key? key}) : super(key: key);

  final PurchasesStore _searchPurchaseStore =
      GetIt.I<AppStore>().searchPurchasesStore;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MainAppBar(
          title: "Compras",
          drawerContext: context,
          actions: [
            NotificationActionButton(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
          ],
          bottom: TabBar(
            onTap: (index) {
              _searchPurchaseStore.setStatus(index == 0
                  ? PurchaseStatusTypes.OPEN
                  : PurchaseStatusTypes.CLOSED);
            },
            tabs: [
              Tab(text: "Em Aberto"),
              Tab(text: "Finalizadas"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OpenPurchases(),
            Container(),
          ],
        ),
      ),
    );
  }
}

class OpenPurchases extends StatefulWidget {
  OpenPurchases({Key? key}) : super(key: key);

  @override
  _OpenPurchasesState createState() => _OpenPurchasesState();
}

class _OpenPurchasesState extends State<OpenPurchases>
    with AutomaticKeepAliveClientMixin<OpenPurchases> {
  final PurchasesStore _purchasesStore = GetIt.I<AppStore>().openPurchasesStore;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Observer(builder: (context) {
      if (_purchasesStore.loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (_purchasesStore.error.isNotEmpty) {
        return Center(
          child: Text(_purchasesStore.error),
        );
      }

      if (_purchasesStore.purchaseList.isEmpty) {
        return EmptyPlaceholder(
          asset: AppAssets.svgIcPurchasesEmpty,
          title: "Nenhuma compra foi encontrada!",
          subTitleBefore: "Clique em",
          subTitleAfter: "para adicionar uma nova!",
        );
      }

      return Text("Buildar lista");
    });
  }

  @override
  bool get wantKeepAlive => true;
}
