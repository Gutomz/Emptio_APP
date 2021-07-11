import 'package:emptio/common/widgets/dismissible_background.widget.dart';
import 'package:emptio/common/widgets/simple_confirm_dialog.widget.dart';
import 'package:emptio/common/widgets/empty_placeholder.widget.dart';
import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/views/purchase_details/purchase_details.view.dart';
import 'package:emptio/views/purchases/store/purchases.store.dart';
import 'package:emptio/views/purchases/widgets/purchase_tile.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PurchaseList extends StatefulWidget {
  final PurchasesStore store;
  final bool canDelete;

  PurchaseList({
    Key? key,
    required this.store,
    this.canDelete = false,
  }) : super(key: key);

  @override
  _PurchaseListState createState() => _PurchaseListState();
}

class _PurchaseListState extends State<PurchaseList> {
  late PurchasesStore purchasesStore = widget.store;

  Future<bool> confirmDismiss(DismissDirection direction) async {
    final response = await showDialog<bool>(
        context: context,
        builder: (context) {
          return SimpleConfirmDialog(
            title: "Excluir Compra?",
            content: "Tem certeza que deseja excluir essa compra?",
            acceptText: "sim",
            rejectText: "cancelar",
          );
        });
    return Future.value(response ?? false);
  }

  Future<void> onPurchaseTap(
      BuildContext context, PurchaseModel purchase) async {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PurchaseDetailsView(purchase: purchase),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (purchasesStore.error.isNotEmpty) {
        return Center(
          child: Text(purchasesStore.error),
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
          asset: AppAssets.svgIcPurchasesEmpty,
          title: "Nenhuma compra foi encontrada!",
          subTitleBefore: "Clique em",
          subTitleAfter: "para adicionar uma nova!",
        );
      }

      return RefreshIndicator(
        backgroundColor: AppColors.lightBlue,
        color: Colors.white,
        onRefresh: purchasesStore.resetPage,
        child: ListView.separated(
          key:
              PageStorageKey<String>('purchases_list-${purchasesStore.status}'),
          padding: EdgeInsets.only(bottom: 50),
          separatorBuilder: (context, index) => Divider(
            height: 1,
            color: AppColors.grey,
          ),
          itemCount: purchasesStore.itemCount,
          itemBuilder: (context, index) {
            if (index < purchasesStore.purchaseList.length) {
              final purchase = purchasesStore.purchaseList[index];

              if (widget.canDelete) {
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
                  child: PurchaseTile(
                    purchase,
                    onTap: () => onPurchaseTap(context, purchase),
                  ),
                );
              }

              return PurchaseTile(
                purchase,
                onTap: () => onPurchaseTap(context, purchase),
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
