import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/common/widgets/subtitle_item.widget.dart';
import 'package:emptio/common/widgets/user_avatar.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/models/post_data.model.dart';
import 'package:emptio/models/product_market.model.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:emptio/helpers/extensions.dart';

class PostPreviewWidget extends StatelessWidget {
  final AuthStore _authStore = GetIt.I<AuthStore>();
  final String type;
  final ProductMarketModel? productMarket;
  final String? purchaseName;
  final BasePurchaseModel? purchase;
  final String description;
  final double scale;

  PostPreviewWidget({
    Key? key,
    required this.type,
    this.purchaseName,
    this.purchase,
    this.productMarket,
    this.description = "",
    this.scale = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(25),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildPostHeader(context),
            if (type == PostDataTypes.productMarket)
              buildBodyProductMarket(context, productMarket!),
            if (type == PostDataTypes.purchase)
              buildBodyPurchase(context, purchase!, purchaseName),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                description.isNotEmpty ? description : "Descrição",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: 10),
            Divider(height: 1, color: AppColors.lightGrey),
            buildPostBottom(context),
          ],
        ),
      ),
    );
  }

  Widget buildPostHeader(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: [
            UserAvatar(
              radius: 16,
              iconSize: 18,
              backgroundColor: AppColors.orange,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                _authStore.user?.name ?? "Nome do usuário",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPostBottom(BuildContext context) {
    return SizedBox(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: buildPostRateButton(
              context,
              icon: Icons.thumb_down_outlined,
              selectedIcon: Icons.thumb_down,
            ),
          ),
          VerticalDivider(
            color: AppColors.lightGrey,
            width: 1,
          ),
          Expanded(
            child: buildPostRateButton(
              context,
              icon: Icons.thumb_up_outlined,
              selectedIcon: Icons.thumb_up,
              selected: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPostRateButton(
    BuildContext context, {
    required IconData icon,
    required IconData selectedIcon,
    bool selected = false,
  }) {
    final foregroundColor = selected ? AppColors.blue : AppColors.grey;

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Material(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              selected ? selectedIcon : icon,
              color: foregroundColor,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBodyProductMarket(
      BuildContext context, ProductMarketModel productMarket) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Column(
                children: [
                  ImageBuilder.fromString(
                    productMarket.market.image,
                    size: 45,
                    iconSize: 18,
                    borderRadius: 25,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    productMarket.market.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          buildProduct(context, productMarket),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget buildProduct(BuildContext context, ProductMarketModel productMarket) {
    final product = productMarket.product;
    final price = productMarket.price;
    final updatedAt = product.updatedAt;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          ImageBuilder.fromString(
            product.image,
            size: 55,
            iconSize: 22,
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        product.getCombinedName(),
                        style: TextStyle(
                          color: AppColors.darkBlue,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Column(
                        children: [
                          SubtitleItem(
                            icon: Icons.business_rounded,
                            text: product.brand,
                            iconSize: 10,
                            textSize: 10,
                          ),
                          SubtitleItem(
                            icon: Icons.straighten_rounded,
                            text: product.weight.toString(),
                            iconSize: 10,
                            textSize: 10,
                          ),
                          SubtitleItem(
                            icon: Icons.event,
                            text: updatedAt.formatDate(),
                            iconSize: 10,
                            textSize: 10,
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
                        Text(
                          price.formatMoney(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBodyPurchase(
      BuildContext context, BasePurchaseModel purchase, String? purchaseName) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    purchaseName ?? "Nome da Lista",
                    style: TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.double_arrow_rounded,
                  color: AppColors.grey,
                  size: 14,
                )
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: AppColors.grey,
                  size: 14,
                ),
                SizedBox(width: 5),
                RichText(
                  text: TextSpan(
                    text: "${purchase.items.length}",
                    style: TextStyle(
                      color: AppColors.orange,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text:
                            " produto${purchase.items.length == 1 ? "" : "s"}",
                        style: TextStyle(
                          color: AppColors.orange,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
