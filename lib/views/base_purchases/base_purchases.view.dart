import 'package:emptio/common/widgets/main_app_bar.widget.dart';
import 'package:emptio/common/widgets/notificationActionButton.widget.dart';
import 'package:emptio/common/widgets/search_dialog.widget.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/views/base_purchases/store/base_purchases.store.dart';
import 'package:emptio/views/base_purchases/widgets/base_purchase_list.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class BasePurchasesView extends StatelessWidget {
  BasePurchasesView({Key? key}) : super(key: key);

  final BasePurchasesStore _store = GetIt.I<AppStore>().basePurchasesStore;

  Future<void> openSearch(BuildContext context) async {
    final search = await showDialog(
      context: context,
      builder: (context) => SearchDialog(currentSearch: _store.search),
    );

    if (search != null) {
      _store.setSearch(search);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: Observer(builder: (_) {
          if (_store.search.isNotEmpty) {
            return GestureDetector(
              onTap: () => openSearch(context),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: constraints.biggest.width,
                    child: Text(_store.search),
                  );
                },
              ),
            );
          }

          return Text('Listas');
        }),
        drawerContext: context,
        actions: [
          Observer(builder: (_) {
            if (_store.search.isNotEmpty) {
              return IconButton(
                onPressed: () => _store.setSearch(""),
                icon: Icon(Icons.close),
              );
            }

            return IconButton(
              onPressed: () => openSearch(context),
              icon: Icon(Icons.search),
            );
          }),
          NotificationActionButton(),
        ],
      ),
      body: BasePurchaseList(),
    );
  }
}
