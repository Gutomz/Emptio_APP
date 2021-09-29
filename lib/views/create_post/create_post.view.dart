import 'package:emptio/common/widgets/create_post_confirm_dialog.widget.dart';
import 'package:emptio/common/widgets/post_preview.widget.dart';
import 'package:emptio/common/widgets/underlined_text_field.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/models/post_data.model.dart';
import 'package:emptio/models/product_market.model.dart';
import 'package:emptio/view-models/create_post.view-model.dart';
import 'package:emptio/views/create_post/store/create_post.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CreatePostView extends StatelessWidget {
  final CreatePostStore _store;

  final String type;
  final ProductMarketModel? productMarket;
  final BasePurchaseModel? purchase;
  final bool isPurchase;

  CreatePostView({
    Key? key,
    required this.type,
    this.productMarket,
    this.purchase,
    this.isPurchase = false,
  })  : _store = CreatePostStore(type),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova Publicação"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Observer(builder: (context) {
              return PostPreviewWidget(
                type: type,
                productMarket: productMarket,
                purchaseName: _store.purchaseName,
                purchase: purchase,
                description: _store.description,
                scale: 0.75,
              );
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  if (type == PostDataTypes.purchase)
                    UnderlinedTextField(
                      label: "Nome da Lista",
                      onChanged: (value) => _store.setPurchaseName(value),
                    ),
                  SizedBox(height: 25),
                  TextField(
                    onChanged: (value) => _store.setDescription(value),
                    maxLength: 200,
                    minLines: 5,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: "Descrição",
                      labelStyle: TextStyle(color: AppColors.blue),
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Observer(builder: (context) {
            return ElevatedButton(
              onPressed: _store.loading ? null : () => confirmPublish(context),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text("Publicar"),
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<void> confirmPublish(BuildContext context) async {
    if (!_store.canCreate) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_store.canCreateError),
        ),
      );

      return;
    }

    final response = await showDialog<bool>(
      context: context,
      builder: (context) => CreatePostConfirmDialog(
        type: type,
        productMarket: productMarket,
        purchaseName: _store.purchaseName,
        purchase: purchase,
        description: _store.description,
      ),
    );

    if (response == true) {
      final model = CreatePostViewModel(
        type: type,
        productMarket: productMarket?.sId,
        purchase: isPurchase ? purchase?.sId : null,
        basePurchase: !isPurchase ? purchase?.sId : null,
        name: _store.purchaseName,
        description: _store.description,
      );

      await _store.create(model);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Publicação criada com sucesso!"),
          backgroundColor: AppColors.green,
        ),
      );

      Navigator.of(context).pop();
    }
  }
}
