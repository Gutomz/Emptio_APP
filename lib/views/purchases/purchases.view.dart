import 'package:emptio/common/widgets/main_app_bar.widget.dart';
import 'package:emptio/common/widgets/notificationActionButton.widget.dart';
import 'package:emptio/views/purchases/widgets/closed_purchases.widget.dart';
import 'package:emptio/views/purchases/widgets/open_purchases.widget.dart';
import 'package:flutter/material.dart';

class PurchasesView extends StatelessWidget {
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
            OpenPurchases(),
            ClosedPurchases(),
          ],
        ),
      ),
    );
  }
}
