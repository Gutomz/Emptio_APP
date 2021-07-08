import 'package:emptio/core/app_colors.dart';
import 'package:emptio/views/purchase_details/store/purchase_details.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:emptio/helpers/extensions.dart';

class PurchaseDetailsBottomAppBar extends StatelessWidget {
  const PurchaseDetailsBottomAppBar({
    Key? key,
    required PurchaseDetailsStore store,
  })  : _store = store,
        super(key: key);

  final PurchaseDetailsStore _store;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 8,
      notchMargin: 8,
      shape: CircularNotchedRectangle(),
      color: AppColors.blue,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 55,
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.42,
              height: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(width: 5),
                  Tooltip(
                    message: 'Quantidade de produtos',
                    child: Observer(builder: (_) {
                      return RichText(
                        text: TextSpan(
                          text: _store.productsCount.toString(),
                          children: [
                            TextSpan(
                              text: _store.productsCount == 1
                                  ? ' produto'
                                  : ' produtos',
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.42,
              height: double.infinity,
              child: Observer(builder: (_) {
                return Tooltip(
                  message:
                      _store.showChecked ? 'Valor Calculado' : 'Valor Estimado',
                  child: RichText(
                    text: TextSpan(
                      text: 'R\$',
                      children: [
                        TextSpan(
                          text: _store.showChecked
                              ? _store.purchase.cost.formatMoney()
                              : _store.purchase.estimatedCost.formatMoney(),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
