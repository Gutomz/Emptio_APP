import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/purchase.model.dart';
import 'package:emptio/views/purchase_details/store/purchase_details.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ConnectedMarketIndicator extends StatelessWidget {
  final PurchaseDetailsStore detailsStore;

  ConnectedMarketIndicator({
    required this.detailsStore,
    Key? key,
  }) : super(key: key);

  bool hasImage() {
    PurchaseModel? purchase = detailsStore.purchase;

    return purchase.market != null &&
        purchase.market!.image != null &&
        purchase.market!.image!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (detailsStore.isMarketConnected) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    image: hasImage()
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              detailsStore.purchase.market!.image!,
                            ),
                          )
                        : null,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: !hasImage()
                      ? Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.black,
                          size: 18,
                        )
                      : null,
                ),
                SizedBox(width: 20),
                Text(
                  detailsStore.purchase.market!.name,
                  style: TextStyle(
                    color: AppColors.orange,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit_location_outlined),
                  tooltip: "Editar mercado",
                  color: Colors.white,
                  iconSize: 18,
                  splashRadius: 20,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.remove_circle_outline),
                  tooltip: "Desconectar mercado",
                  color: AppColors.red,
                  iconSize: 18,
                  splashRadius: 20,
                ),
              ],
            ),
          ],
        );
      }

      return Container(
        width: double.infinity,
        padding: EdgeInsets.only(right: 15),
        child: OutlinedButton(
          onPressed: () {},
          child: Text("Conectar Mercado"),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(AppColors.orange),
            side: MaterialStateProperty.all(
              BorderSide(color: AppColors.orange),
            ),
          ),
        ),
      );
    });
  }
}
