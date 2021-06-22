import 'package:emptio/common/widgets/dismissible_background.widget.dart';
import 'package:emptio/common/widgets/dismissible_confirm_dialog.widget.dart';
import 'package:emptio/common/widgets/empty_placeholder.widget.dart';
import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/views/base_purchases/store/base_purchases.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class BasePurchaseList extends StatefulWidget {
  BasePurchaseList({Key? key}) : super(key: key);

  @override
  _BasePurchaseListState createState() => _BasePurchaseListState();
}

class _BasePurchaseListState extends State<BasePurchaseList> {
  final BasePurchasesStore purchasesStore =
      GetIt.I<AppStore>().basePurchasesStore;

  Future<bool> confirmDismiss(DismissDirection direction) async {
    bool? response = await showDialog(
        context: context,
        builder: (context) {
          return ConfirmDismissDialog(
            title: "Excluir Lista?",
            content: "Tem certeza que deseja excluir essa lista?",
            acceptText: "sim",
            rejectText: "cancelar",
          );
        });
    return Future.value(response ?? false);
  }

  Future<void> onPurchaseTap(
      BuildContext context, BasePurchaseModel purchase) async {
    print('navigate to base purchase details');
    // await Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => PurchaseDetailsView(
    //       purchase: purchase,
    //     ),
    //   ),
    // );

    // GetIt.I<AppStore>().dismissPurchaseDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (purchasesStore.error.isNotEmpty) {
        return Center(
          child: Text(
            purchasesStore.error,
            textAlign: TextAlign.center,
          ),
        );
      }

      if (purchasesStore.firstLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.darkOrange,
          ),
        );
      }

      if (purchasesStore.purchaseList.isEmpty) {
        return EmptyPlaceholder(
          asset: AppAssets.svgIcBasePurchasesEmpty,
          title: "Nenhuma lista foi encontrada!",
          subTitleBefore: "Clique em",
          subTitleAfter: "para adicionar uma nova!",
        );
      }

      return RefreshIndicator(
        backgroundColor: AppColors.lighBlue,
        color: Colors.white,
        onRefresh: purchasesStore.resetPage,
        child: ListView.separated(
          key: PageStorageKey<String>('base_purchases_list'),
          padding: EdgeInsets.only(bottom: 50),
          separatorBuilder: (context, index) => Divider(
            height: 1,
            color: AppColors.grey,
          ),
          itemCount: purchasesStore.itemCount,
          itemBuilder: (context, index) {
            if (index < purchasesStore.purchaseList.length) {
              BasePurchaseModel purchase = purchasesStore.purchaseList[index];

              return Dismissible(
                key: Key(purchase.sId),
                direction: DismissDirection.startToEnd,
                background: DismissibleBackground(
                  icon: Icons.delete,
                  title: "Excluir",
                  color: AppColors.red,
                ),
                onDismissed: (_) => purchasesStore.deletePurchase(index),
                confirmDismiss: confirmDismiss,
                child: ListTile(
                  onTap: () => onPurchaseTap(context, purchase),
                  title: Text(
                    purchase.name,
                    style: TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColors.grey,
                        size: 16,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "${purchase.items.length}",
                        style: TextStyle(
                          color: AppColors.orange,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.shopping_basket_outlined),
                    color: AppColors.darkGrey,
                    iconSize: 26,
                    tooltip: "Iniciar Compra",
                  ),
                ),
              );
            }

            purchasesStore.loadNextPage();
            return Container(
              height: 5,
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.darkOrange),
              ),
            );
          },
        ),
      );
    });
  }
}
