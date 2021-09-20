import 'package:emptio/common/widgets/dismissible_background.widget.dart';
import 'package:emptio/common/widgets/error_placeholder.widget.dart';
import 'package:emptio/common/widgets/simple_confirm_dialog.widget.dart';
import 'package:emptio/common/widgets/empty_placeholder.widget.dart';
import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/views/base_purchase_details/base_purchase_details.view.dart';
import 'package:emptio/views/base_purchases/store/base_purchases.store.dart';
import 'package:emptio/views/purchase_details/purchase_details.view.dart';
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
    final response = await showDialog<bool>(
        context: context,
        builder: (context) {
          return SimpleConfirmDialog(
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
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => BasePurchaseDetailsView(purchase: purchase),
    ));
  }

  Future<void> onCreatePurchaseTap(
      BuildContext context, BasePurchaseModel model) async {
    final purchase = await purchasesStore.createPurchaseWithBaseModel(model);

    if (purchase != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PurchaseDetailsView(
            purchase: purchase,
          ),
        ),
      );

      await Future.delayed(Duration(seconds: 1));

      GetIt.I<AppStore>().homeStore.changeTab(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (purchasesStore.firstLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.darkOrange,
          ),
        );
      }

      if (purchasesStore.error.isNotEmpty) {
        return Center(
          child: ErrorPlaceholder(
            error: purchasesStore.error,
            retry: purchasesStore.resetPage,
          ),
        );
      }

      return RefreshIndicator(
        backgroundColor: AppColors.lightBlue,
        color: Colors.white,
        onRefresh: purchasesStore.resetPage,
        child: purchasesStore.purchaseList.isEmpty
            ? Center(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Center(
                    child: EmptyPlaceholderCreation(
                      asset: AppAssets.svgIcPurchasesEmpty,
                      title: "Nenhuma compra foi encontrada!",
                      subTitleBefore: "Clique em",
                      subTitleAfter: "para adicionar uma nova!",
                      icon: Icons.post_add_outlined,
                    ),
                  ),
                ),
              )
            : ListView.separated(
                key: PageStorageKey<String>('base_purchases_list'),
                padding: EdgeInsets.only(bottom: 50),
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  color: AppColors.grey,
                ),
                itemCount: purchasesStore.itemCount,
                itemBuilder: (context, index) {
                  if (index < purchasesStore.purchaseList.length) {
                    final purchase = purchasesStore.purchaseList[index];

                    return Dismissible(
                      key: Key(purchase.sId),
                      direction: DismissDirection.endToStart,
                      background: DismissibleBackground(
                        icon: Icons.delete,
                        title: "Excluir",
                        color: AppColors.red,
                        secondary: true,
                      ),
                      onDismissed: (_) => purchasesStore.deletePurchase(index),
                      confirmDismiss: confirmDismiss,
                      child: Observer(builder: (_) {
                        return ListTile(
                            onTap: purchasesStore.isLoadingTile
                                ? null
                                : () => onPurchaseTap(context, purchase),
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
                            trailing: Observer(builder: (context) {
                              if (purchasesStore.loadingTile == purchase.sId) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: AppColors.darkOrange,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                );
                              }

                              return IconButton(
                                onPressed: purchasesStore.isLoadingTile
                                    ? null
                                    : () =>
                                        onCreatePurchaseTap(context, purchase),
                                icon: Icon(Icons.shopping_basket_outlined),
                                color: AppColors.darkGrey,
                                iconSize: 26,
                                tooltip: "Iniciar Compra",
                              );
                            }));
                      }),
                    );
                  }

                  purchasesStore.loadNextPage();
                  return SizedBox(
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
