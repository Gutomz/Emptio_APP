import 'package:emptio/common/widgets/dismissible_background.widget.dart';
import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/common/widgets/subtitle_item.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/post_data.model.dart';
import 'package:emptio/models/purchase_item.model.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/views/create_post/create_post.view.dart';
import 'package:emptio/views/purchase_details/store/purchase_details.store.dart';
import 'package:emptio/views/purchase_details/store/purchase_item.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:emptio/helpers/extensions.dart';
import 'package:get_it/get_it.dart';

class CheckedPurchaseItemTile extends StatelessWidget {
  final AuthStore _authStore = GetIt.I<AuthStore>();
  final PurchaseItemStore store;
  final PurchaseItemModel item;

  CheckedPurchaseItemTile({
    required this.item,
    required PurchaseDetailsStore purchaseStore,
    Key? key,
  })  : store = PurchaseItemStore(
          purchaseStore: purchaseStore,
          itemId: item.sId,
          price: item.price,
          quantity: item.quantity,
          checked: item.checked,
        ),
        super(key: key);

  void onDismissed(DismissDirection direction) {
    store.toggleChecked();
  }

  Future<void> confirmShare(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreatePostView(
          type: PostDataTypes.productMarket,
          productMarket: item.completedProductMarket,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (store.purchaseStore.isClosed) {
        return Observer(builder: (_) {
          if (_authStore.isLogged) {
            return InkWell(
              onTap: item.completedProductMarket != null
                  ? () => confirmShare(context)
                  : null,
              child: buildItem(sharing: item.completedProductMarket != null),
            );
          }

          return buildItem();
        });
      }

      return Dismissible(
        key: Key(item.sId),
        onDismissed: onDismissed,
        direction: DismissDirection.endToStart,
        background: DismissibleBackground(
          icon: Icons.remove_done_rounded,
          title: 'Remover',
          color: AppColors.red,
          secondary: true,
        ),
        child: buildItem(),
      );
    });
  }

  Widget buildItem({bool sharing = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.lightGrey),
        ),
      ),
      child: Row(
        children: [
          Hero(
            tag: 'product${item.product.sId}',
            child: ImageBuilder.fromString(item.product.image, size: 95),
          ),
          SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: 95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          item.product.getCombinedName(),
                          style: TextStyle(
                            color: AppColors.darkBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        sharing
                            ? Icons.share_outlined
                            : Icons.double_arrow_rounded,
                        color: AppColors.darkBlue,
                        size: 16,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            SubtitleItem(
                              icon: Icons.business_rounded,
                              text: item.product.brand,
                            ),
                            SubtitleItem(
                              icon: Icons.straighten_rounded,
                              text: item.product.weight.toString(),
                            ),
                            SubtitleItem(
                              icon: Icons.shopping_cart_outlined,
                              text: item.quantity.toString(),
                            ),
                            SubtitleItem(
                              icon: Icons.monetization_on_outlined,
                              text: "R\$${item.price.formatMoney()}",
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "R\$",
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.lightGrey,
                            ),
                          ),
                          Observer(builder: (_) {
                            return Text(
                              store.totalPrice.formatMoney(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.orange,
                              ),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
