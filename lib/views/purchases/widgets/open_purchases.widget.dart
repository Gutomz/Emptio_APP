import 'package:emptio/common/widgets/empty_placeholder.widget.dart';
import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/views/purchases/store/purchases.store.dart';
import 'package:emptio/views/purchases/widgets/purchase_tile.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class OpenPurchases extends StatefulWidget {
  OpenPurchases({Key? key}) : super(key: key);

  @override
  _OpenPurchasesState createState() => _OpenPurchasesState();
}

class _OpenPurchasesState extends State<OpenPurchases>
    with AutomaticKeepAliveClientMixin<OpenPurchases> {
  final PurchasesStore _purchasesStore = GetIt.I<AppStore>().openPurchasesStore;

  Future<bool> confirmDismiss(DismissDirection direction) async {
    bool? response = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Excluir Compra!"),
            content: Text("Tem certeza que deseja excluir essa compra?"),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("cancelar"),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(AppColors.grey),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("sim"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.red),
                ),
              ),
            ],
          );
        });
    return Future.value(response ?? false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Observer(builder: (context) {
      if (_purchasesStore.error.isNotEmpty) {
        return Center(
          child: Text(_purchasesStore.error),
        );
      }

      if (_purchasesStore.firstLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.darkOrange,
          ),
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

      return ListView.builder(
        itemCount: _purchasesStore.itemCount,
        itemBuilder: (context, index) {
          if (index < _purchasesStore.purchaseList.length) {
            PurchaseModel purchase = _purchasesStore.purchaseList[index];

            return Dismissible(
              key: Key(purchase.sId),
              direction: DismissDirection.startToEnd,
              background: Container(
                color: AppColors.red,
                child: Align(
                  alignment: Alignment(-0.85, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                      Text(
                        "Excluir",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              onDismissed: (_) => _purchasesStore.deletePurchase(index),
              confirmDismiss: confirmDismiss,
              child: PurchaseTile(
                purchase,
                onTap: () {},
              ),
            );
          }

          _purchasesStore.loadNextPage();
          return Container(
            height: 5,
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AppColors.darkOrange),
            ),
          );
        },
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}