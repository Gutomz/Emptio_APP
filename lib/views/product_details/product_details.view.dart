import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/common/widgets/product_tag.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/views/product_details/store/product_details.store.dart';
import 'package:flutter/material.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductDetailsStore _store;

  ProductDetailsView({Key? key, required ProductModel product})
      : _store = ProductDetailsStore(product),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_store.product.name),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 25),
        child: Column(
          children: [
            _buildHeader(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Column(
          children: [
            Hero(
              tag: Key("product${_store.product.sId}"),
              child: ImageBuilder.fromString(
                _store.product.image,
                size: 90,
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
                _store.product.getCombinedName(),
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
                    _store.product.brand,
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
                    _store.product.weight.toString(),
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
              children: _store.product.tags
                  .map<Widget>(
                    (tag) => ProductTag(title: tag),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
