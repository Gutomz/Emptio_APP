import 'package:emptio/common/widgets/main_app_bar.widget.dart';
import 'package:emptio/common/widgets/notificationActionButton.widget.dart';
import 'package:emptio/views/base_purchases/widgets/base_purchase_list.widget.dart';
import 'package:flutter/material.dart';

class BasePurchasesView extends StatelessWidget {
  const BasePurchasesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: "Listas",
        drawerContext: context,
        actions: [
          NotificationActionButton(),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: BasePurchaseList(),
    );
  }
}
