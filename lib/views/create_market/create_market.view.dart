import 'dart:io';

import 'package:emptio/common/widgets/image_builder.widget.dart';
import 'package:emptio/common/widgets/underlined_text_field.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:emptio/helpers/pick_image.dart';
import 'package:emptio/views/create_market/store/create_market.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CreateMarketView extends StatelessWidget {
  final CreateMarketStore _store = CreateMarketStore();
  final PickImage picker = PickImage();

  CreateMarketView({Key? key}) : super(key: key);

  Future<void> _selectImage(BuildContext context, File? _current) async {
    final image = await picker.showPicker(context, canRemove: _current != null);
    _store.setImage(image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Mercado"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 25),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Observer(builder: (context) {
                  return ImageBuilder.fromFile(_store.image);
                }),
              ),
              Observer(builder: (context) {
                return TextButton(
                  onPressed: () => _selectImage(context, _store.image),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(AppColors.orange),
                    overlayColor: MaterialStateProperty.all(Colors.orange[50]),
                  ),
                  child: Text(
                    _store.image != null
                        ? 'Alterar imagem'
                        : 'Selecionar imagem',
                  ),
                );
              }),
              Observer(builder: (_) {
                return UnderlinedTextField(
                  label: "Nome",
                  errorText: _store.nameError,
                  onChanged: _store.setName,
                );
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Observer(builder: (context) {
        return BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Observer(builder: (context) {
              return ElevatedButton(
                onPressed:
                    _store.formValid ? () => createMarket(context) : null,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text("Cadastrar"),
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  Future<void> createMarket(BuildContext context) async {
    final market = await _store.create();

    if (market != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Mercado cadastrado com sucesso!"),
          backgroundColor: AppColors.green,
        ),
      );

      return Navigator.of(context).pop();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Ocorreu um erro ao cadastrar o mercado!"),
      ),
    );
  }
}
