import 'package:emptio/common/widgets/empty_placeholder.widget.dart';
import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/common/widgets/subtitle_item.widget.dart';
import 'package:emptio/core/app_assets.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/models/base_purchase_item.model.dart';
import 'package:emptio/stores/app.store.dart';
import 'package:emptio/view-models/copy_base_purchase.view_model.dart';
import 'package:emptio/views/base_purchases/store/base_purchases.store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class PostPurchaseDetailsView extends StatelessWidget {
  final BasePurchasesStore _basePurchasesStore =
      GetIt.I<AppStore>().basePurchasesStore;
  final BasePurchaseModel purchase;

  PostPurchaseDetailsView({
    Key? key,
    required this.purchase,
  }) : super(key: key);

  Future<void> copyPurchase(BuildContext context) async {
    await _basePurchasesStore.copyPurchase(
      CopyBasePurchaseViewModel(
        name: purchase.name,
        basePurchaseId: purchase.sId,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Lista copiada com sucesso"),
        backgroundColor: AppColors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(purchase.name),
        actions: [
          IconButton(
            onPressed: () => copyPurchase(context),
            icon: Icon(Icons.download_outlined),
          ),
        ],
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    if (purchase.items.isEmpty) {
      return EmptyPlaceholder(
        title: "Nenhum produto cadastrado na lista!",
        subTitle: "",
        asset: AppAssets.svgIcBasePurchasesEmpty,
        hideScrollIndicator: true,
      );
    }

    return ListView.builder(
      itemCount: purchase.items.length,
      itemBuilder: (context, index) {
        final item = purchase.items[index];

        return buildItem(context, item);
      },
    );
  }

  Widget buildItem(BuildContext context, BasePurchaseItemModel item) {
    return InkWell(
      onTap: () {},
      child: Container(
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
              child: ImageBuilder.fromString(item.product.image),
            ),
            SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            item.product.getCombinedName(),
                            style: TextStyle(
                              color: AppColors.darkBlue,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.double_arrow_rounded,
                          color: AppColors.darkBlue,
                          size: 16,
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
                                text: item.product.brand,
                              ),
                              SubtitleItem(
                                icon: Icons.straighten_rounded,
                                text: item.product.weight.toString(),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          item.quantity.toString(),
                          style: TextStyle(
                            color: AppColors.orange,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
