import 'package:emptio/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class InputPriceConfirmDialog extends StatelessWidget {
  final String title;
  final MoneyMaskedTextController _controller;

  InputPriceConfirmDialog({
    Key? key,
    required this.title,
    double initialPrice = 0,
  })  : _controller = MoneyMaskedTextController(
          leftSymbol: 'R\$ ',
          initialValue: initialPrice,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.numberWithOptions(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(null),
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(AppColors.grey),
          ),
          child: Text('cancelar'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(_controller.numberValue),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.orange),
          ),
          child: Text('concluir'),
        ),
      ],
    );
  }
}
