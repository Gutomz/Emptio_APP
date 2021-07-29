import 'package:emptio/common/delegates/market_search/market_search.dart';
import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/common/widgets/simple_confirm_dialog.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/views/purchase_details/store/purchase_details.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ConnectedMarketIndicator extends StatelessWidget {
  final PurchaseDetailsStore store;

  ConnectedMarketIndicator({
    required this.store,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (store.isMarketConnected) {
        return ListTile(
          contentPadding: EdgeInsets.symmetric(),
          leading: ImageBuilder.fromString(
            store.purchase.market != null ? store.purchase.market!.image : null,
            size: 35,
            iconSize: 16,
            borderRadius: 20,
            backgroundColor: Colors.white,
          ),
          title: Text(
            store.purchase.market!.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.orange,
            ),
          ),
          trailing: store.isClosed
              ? null
              : IconButton(
                  onPressed: () => _onPressedDisconnectMarket(context),
                  icon: Icon(Icons.remove_circle_outline),
                  tooltip: "Desconectar mercado",
                  color: AppColors.red,
                  iconSize: 18,
                  splashRadius: 20,
                ),
        );
      }

      return Container(
        width: double.infinity,
        padding: EdgeInsets.only(right: 15),
        child: OutlinedButton(
          onPressed: () => _onPressedConnectMarket(context),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(AppColors.orange),
            side: MaterialStateProperty.all(
              BorderSide(color: AppColors.orange),
            ),
          ),
          child: Text("Conectar Mercado"),
        ),
      );
    });
  }

  Future<void> _onPressedConnectMarket(BuildContext context) async {
    final response =
        await showSearch(context: context, delegate: MarketSearch());

    if (response == null) return;

    if (response.isNew) {
      // TODO - create and connect to a new market
    } else if (response.isSuggestion) {
      store.connectMarket(placeId: response.sId);
    } else {
      store.connectMarket(marketId: response.sId);
    }
  }

  Future<void> _onPressedDisconnectMarket(BuildContext context) async {
    final response = await showDialog<bool>(
      context: context,
      builder: (context) => SimpleConfirmDialog(
        title: "Desconectar Mercado?",
        content: "Tem certeza que deseja desconectar o mercado desta compra?",
        acceptText: "sim",
        rejectText: "cancelar",
      ),
    );

    if (response != null && response) {
      store.connectMarket();
    }
  }
}
