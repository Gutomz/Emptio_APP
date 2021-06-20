import 'package:emptio/common/delegates/purchase_item_search/purchase_item_search.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/models/purchase_item.model.dart';
import 'package:emptio/views/purchase_details/store/purchase_details.store.dart';
import 'package:emptio/views/purchase_details/widgets/connected_market.widget.dart';
import 'package:emptio/views/purchase_details/widgets/purchase_items_list.widget.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class PurchaseDetailsView extends StatefulWidget {
  final PurchaseModel purchase;

  PurchaseDetailsView({
    required this.purchase,
    Key? key,
  }) : super(key: key);

  @override
  _PurchaseDetailsViewState createState() =>
      _PurchaseDetailsViewState(purchase: purchase);
}

class _PurchaseDetailsViewState extends State<PurchaseDetailsView> {
  late PurchaseDetailsStore _store;

  _PurchaseDetailsViewState({required PurchaseModel purchase}) {
    _store = PurchaseDetailsStore(
      purchase: purchase,
      items: ObservableList<PurchaseItemModel>()..addAll(purchase.items),
    );
  }

  Future<void> selectFilter(BuildContext context) async {
    bool? checked = await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.list_rounded),
                  title: Text('Restantes'),
                  onTap: () async {
                    Navigator.of(context).pop(false);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.checklist),
                  title: Text('Concluidas'),
                  onTap: () async {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    if(checked != null) {
      _store.changeFilter(checked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Detalhes"),
        actions: [
          IconButton(
            onPressed: () => selectFilter(context),
            icon: Icon(Icons.filter_list_rounded),
            tooltip: "Alterar Filtro",
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings_outlined),
            tooltip: "Configurações",
          ),
        ],
        bottom: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              bottom: 10,
            ),
            child: ConnectedMarketIndicator(
              detailsStore: _store,
            ),
          ),
          preferredSize: Size.fromHeight(70),
        ),
      ),
      body: PurchaseItemsList(store: _store),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showSearch(
            context: context,
            delegate: ProductSearch(detailsStore: _store),
          );

          _store.refreshItems();
        },
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
      ),
    );
  }
}
