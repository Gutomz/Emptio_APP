import 'package:emptio/common/widgets/main_app_bar.widget.dart';
import 'package:emptio/common/widgets/notificationActionButton.widget.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/views/purchases/store/purchases.store.dart';
import 'package:emptio/views/purchases/widgets/purchase_list.widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PurchasesView extends StatelessWidget {
  final PurchasesStore _openPurchasesStore =
      GetIt.I<AppStore>().openPurchasesStore;

  final PurchasesStore _closedPurchasesStore =
      GetIt.I<AppStore>().closedPurchasesStore;

  PurchasesView({Key? key}) : super(key: key);

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
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: "Em Aberto"),
              Tab(text: "Finalizadas"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PurchaseList(
              store: _openPurchasesStore,
              canDelete: true,
            ),
            PurchaseList(
              store: _closedPurchasesStore,
            ),
          ],
        ),
      ),
    );
  }
}
