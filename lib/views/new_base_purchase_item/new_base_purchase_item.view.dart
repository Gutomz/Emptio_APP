import 'package:emptio/common/widgets/add_item_bottom_appbar.widget.dart';
import 'package:emptio/common/widgets/input_new_tag_confirm_dialog.widget.dart';
import 'package:emptio/common/widgets/product_tag.widget.dart';
import 'package:emptio/common/widgets/underlined_text_field.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/models/base_purchase.model.dart';
import 'package:emptio/models/measurement.model.dart';
import 'package:emptio/views/new_base_purchase_item/store/new_base_purchase_item.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class NewBasePurchaseItemView extends StatelessWidget {
  NewBasePurchaseItemView({required this.purchase, Key? key}) : super(key: key);

  final BasePurchaseModel purchase;
  final NewBasePurchaseItemStore store = NewBasePurchaseItemStore();

  final weightFieldController = MoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
    initialValue: 0,
  );

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(title: Text("Novo Produto")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50, bottom: 25, right: 15, left: 15),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      border: Border.all(color: AppColors.grey),
                      color: AppColors.white,
                    ),
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.black,
                      size: 32,
                    ),
                  ),
                ),
              ),
              TextButton(onPressed: () {}, child: Text("Adicionar foto")),
              SizedBox(height: 25),
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
              Observer(builder: (_) {
                return UnderlinedTextField(
                  label: "Peso",
                  controller: weightFieldController,
                  keyboardType: TextInputType.numberWithOptions(),
                  textInputAction: TextInputAction.done,
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
                              child: Text(value),
                              value: value,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              }),
              SizedBox(height: 40),
              Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          onPressed: () async {
                            String? tag = await showDialog(
                              context: context,
                              builder: (context) => InputNewTagDialog(
                                excludeList: store.tags.toList(),
                              ),
                            );

                            if (tag != null) {
                              store.addTag(tag);
                            }
                          },
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

                      return Container(
                        width: double.infinity,
                        child: Wrap(
                          spacing: 10,
                          alignment: WrapAlignment.start,
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
          onDecrementPressed:
              store.minQuantityReached ? null : store.decrementQuantity,
          onIncrementPressed:
              store.maxQuantityReached ? null : store.incrementQuantity,
          onAddPressed: store.formValid
              ? () {
                  Navigator.of(context).pop(store.getModel());
                }
              : null,
          quantity: store.quantity,
          hideTotal: true,
        );
      }),
    );
  }
}
