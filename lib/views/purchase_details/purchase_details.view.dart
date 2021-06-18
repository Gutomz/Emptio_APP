import 'package:emptio/stores/app.store.dart';
import 'package:emptio/views/purchase_details/store/purchase_details.store.dart';
import 'package:emptio/views/purchase_details/widgets/connected_market.widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PurchaseDetailsView extends StatefulWidget {
  PurchaseDetailsView({Key? key}) : super(key: key);

  @override
  _PurchaseDetailsViewState createState() => _PurchaseDetailsViewState();
}

class _PurchaseDetailsViewState extends State<PurchaseDetailsView> {
  final PurchaseDetailsStore _purchaseDetailsStore =
      GetIt.I<AppStore>().purchaseDetailsStore;

  @override
  void dispose() {
    _purchaseDetailsStore.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.filter_alt_outlined),
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
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            child: ConnectedMarketIndicator(),
          ),
          preferredSize: Size.fromHeight(70),
        ),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
      ),
    );
  }
}
