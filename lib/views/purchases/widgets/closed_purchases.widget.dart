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

class ClosedPurchases extends StatefulWidget {
  ClosedPurchases({Key? key}) : super(key: key);

  @override
  _ClosedPurchasesState createState() => _ClosedPurchasesState();
}

class _ClosedPurchasesState extends State<ClosedPurchases>
    with AutomaticKeepAliveClientMixin<ClosedPurchases> {
  final PurchasesStore _purchasesStore =
      GetIt.I<AppStore>().closedPurchasesStore;

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

            return PurchaseTile(
              purchase,
              onTap: () {},
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
