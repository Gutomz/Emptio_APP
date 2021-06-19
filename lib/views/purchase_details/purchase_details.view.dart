import 'package:emptio/common/delegates/purchase_item_search/purchase_item_search.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/views/purchase_details/store/purchase_details.store.dart';
import 'package:emptio/views/purchase_details/widgets/connected_market.widget.dart';
import 'package:flutter/material.dart';

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
    _store = PurchaseDetailsStore(purchase: purchase);
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
            onPressed: () {},
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
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: ProductSearch(detailsStore: _store),
          );
        },
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
      ),
    );
  }
}
