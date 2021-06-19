import 'package:emptio/common/delegates/purchase_item_search/purchase_item_search.dart';
import 'package:emptio/views/purchase_details/widgets/connected_market.widget.dart';
import 'package:flutter/material.dart';

class PurchaseDetailsView extends StatefulWidget {
  PurchaseDetailsView({Key? key}) : super(key: key);

  @override
  _PurchaseDetailsViewState createState() => _PurchaseDetailsViewState();
}

class _PurchaseDetailsViewState extends State<PurchaseDetailsView> {


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
            child: ConnectedMarketIndicator(),
          ),
          preferredSize: Size.fromHeight(70),
        ),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: ProductSearch(),
          );
        },
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
      ),
    );
  }
}
