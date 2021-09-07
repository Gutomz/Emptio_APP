import 'package:emptio/common/widgets/post_preview.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/models/product_market.model.dart';
import 'package:flutter/material.dart';

class CreatePostConfirmDialog extends StatelessWidget {
  final String type;
  final String description;
  final ProductMarketModel? productMarket;
  final String? purchaseName;
  final BasePurchaseModel? purchase;

  CreatePostConfirmDialog({
    Key? key,
    required this.type,
    this.description = "",
    this.productMarket,
    this.purchaseName = "",
    this.purchase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        "Confirmar Publicação",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      children: [
        buildPostPreview(context),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(AppColors.grey),
                ),
                child: Text("cancelar"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.orange),
                ),
                child: Text("publicar"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPostPreview(BuildContext context) {
    return PostPreviewWidget(
      type: type,
      productMarket: productMarket,
      purchaseName: purchaseName,
      purchase: purchase,
      description: description,
      scale: 0.9,
    );
  }
}
