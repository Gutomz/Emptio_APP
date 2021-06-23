import 'package:emptio/common/widgets/product_tag.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/product.model.dart';
import 'package:flutter/material.dart';

class ProductHeader extends StatelessWidget {
  const ProductHeader({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  bool hasImage() {
    return product.image != null && product.image!.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: 'product${product.sId}',
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  image: hasImage()
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(product.image!),
                        )
                      : null,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(color: AppColors.grey),
                  color: AppColors.white,
                ),
                child: !hasImage()
                    ? Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.black,
                        size: 32,
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 25,
              left: 25,
              top: 10,
              bottom: 5,
            ),
            child: Text(
              product.getCombinedName(),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            children: [
              Chip(
                labelPadding: EdgeInsets.all(0),
                backgroundColor: Colors.transparent,
                avatar: Icon(
                  Icons.business_rounded,
                  size: 12,
                  color: AppColors.grey,
                ),
                label: Text(
                  product.brand,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.grey,
                  ),
                ),
              ),
              Chip(
                labelPadding: EdgeInsets.all(0),
                backgroundColor: Colors.transparent,
                avatar: Icon(
                  Icons.straighten_rounded,
                  size: 12,
                  color: AppColors.grey,
                ),
                label: Text(
                  product.weight.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            children: product.tags
                .map<Widget>(
                  (tag) => ProductTag(
                    title: tag,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
