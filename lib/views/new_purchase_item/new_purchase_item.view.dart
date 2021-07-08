import 'dart:io';

import 'package:emptio/common/widgets/add_item_bottom_app_bar.widget.dart';
import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/common/widgets/input_new_tag_confirm_dialog.widget.dart';
import 'package:emptio/common/widgets/market_indicator.widget.dart';
import 'package:emptio/common/widgets/product_tag.widget.dart';
import 'package:emptio/common/widgets/underlined_text_field.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/helpers/pick_image.dart';
import 'package:emptio/models/market.model.dart';
import 'package:emptio/models/measurement.model.dart';
import 'package:emptio/views/new_purchase_item/store/new_purchase_item.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class NewPurchaseItemView extends StatelessWidget {
  NewPurchaseItemView({
    this.connectedMarket,
    this.isBaseItem = false,
    Key? key,
  }) : super(key: key);

  final MarketModel? connectedMarket;
  final NewPurchaseItemStore store = NewPurchaseItemStore();
  final PickImage picker = PickImage();
  final bool isBaseItem;

  final priceFieldController = MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final weightFieldController = MoneyMaskedTextController();

  Future<void> _selectImage(BuildContext context, File? _current) async {
    final image = await picker.showPicker(context, canRemove: _current != null);
    store.setImage(image);
  }

  void onAddPressed(BuildContext context) {
    if (isBaseItem) {
      return Navigator.of(context).pop(store.getBaseModel());
    }

    return Navigator.of(context).pop(store.getModel());
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Produto"),
        bottom: connectedMarket != null
            ? PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, bottom: 15),
                  child: MarketIndicator(market: connectedMarket!),
                ),
              )
            : null,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50, bottom: 25, right: 15, left: 15),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: ImageBuilder.fromFile(store.image),
              ),
              Observer(builder: (context) {
                return TextButton(
                  onPressed: () => _selectImage(context, store.image),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(AppColors.orange),
                    overlayColor: MaterialStateProperty.all(Colors.orange[50]),
                  ),
                  child: Text(
                    store.image != null
                        ? 'Alterar imagem'
                        : 'Selecionar imagem',
                  ),
                );
              }),
              Observer(builder: (_) {
                return UnderlinedTextField(
                  label: "Marca",
                  errorText: store.brandError,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => node.nextFocus(),
                  onChanged: store.setBrand,
                );
              }),
              SizedBox(height: 15),
              Observer(builder: (_) {
                return UnderlinedTextField(
                  label: "Nome",
                  errorText: store.nameError,
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () => node.nextFocus(),
                  onChanged: store.setName,
                );
              }),
              SizedBox(height: 15),
              UnderlinedTextField(
                label: "Variação",
                textInputAction: TextInputAction.next,
                onEditingComplete: () => node.nextFocus(),
                onChanged: store.setVariation,
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Flexible(
                    child: Observer(builder: (_) {
                      return UnderlinedTextField(
                        label: "Peso",
                        controller: weightFieldController,
                        keyboardType: TextInputType.numberWithOptions(),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          node.nextFocus();
                          node.nextFocus();
                        },
                        onChanged: (value) => store
                            .setWeightValue(weightFieldController.numberValue),
                        suffix: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isDense: true,
                            value: store.weightUnit,
                            onChanged: (value) {
                              if (value != null) {
                                store.setWeightUnit(value);
                              }
                            },
                            items: MeasurementTypes.list
                                .map<DropdownMenuItem<String>>(
                                  (value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      );
                    }),
                  ),
                  if (!isBaseItem) SizedBox(width: 25),
                  if (!isBaseItem)
                    Flexible(
                      child: UnderlinedTextField(
                        label: "Preço",
                        controller: priceFieldController,
                        keyboardType: TextInputType.numberWithOptions(),
                        textInputAction: TextInputAction.done,
                        onChanged: (value) =>
                            store.setPrice(priceFieldController.numberValue),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categorias",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: AppColors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          onPressed: () => _onNewCategoryPressed(context),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(AppColors.orange),
                            overlayColor:
                                MaterialStateProperty.all(Colors.orange[50]),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.add, size: 16),
                              Text('Adicionar'),
                            ],
                          ),
                        )
                      ],
                    ),
                    Observer(builder: (_) {
                      if (store.tags.isEmpty) {
                        return Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Nenhuma categoria adicionada.",
                          ),
                        );
                      }

                      return SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          spacing: 10,
                          children: store.tags
                              .map<Widget>(
                                (tag) => ProductTag(
                                  title: tag,
                                  canDelete: true,
                                  onDeleted: () => store.removeTag(tag),
                                  fontSize: 12,
                                ),
                              )
                              .toList(),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Observer(builder: (context) {
        return AddItemBottomAppBar(
          hideTotal: isBaseItem,
          onDecrementPressed:
              store.minQuantityReached ? null : store.decrementQuantity,
          onIncrementPressed:
              store.maxQuantityReached ? null : store.incrementQuantity,
          onAddPressed: store.formValid ? () => onAddPressed(context) : null,
          quantity: store.quantity,
          total: store.total,
        );
      }),
    );
  }

  Future<void> _onNewCategoryPressed(BuildContext context) async {
    final tag = await showDialog<String?>(
      context: context,
      builder: (context) => InputNewTagDialog(excludeList: store.tags.toList()),
    );

    if (tag != null) {
      store.addTag(tag);
    }
  }
}
