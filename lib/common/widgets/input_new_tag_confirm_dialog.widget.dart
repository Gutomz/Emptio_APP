import 'package:emptio/common/widgets/product_tag.widget.dart';
import 'package:emptio/common/widgets/underlined_text_field.widget.dart';
import 'package:emptio/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:emptio/helpers/extensions.dart';

class InputNewTagDialog extends StatefulWidget {
  const InputNewTagDialog({
    Key? key,
    required this.excludeList,
  }) : super(key: key);

  final List<String> excludeList;

  @override
  _InputNewTagDialogState createState() => _InputNewTagDialogState();
}

class _InputNewTagDialogState extends State<InputNewTagDialog> {
  String? text;

  bool get validText =>
      text != null &&
      text!.length > 1 &&
      !widget.excludeList.contains(text!.formatTag());

  String? get errorText {
    if (text == null || validText) {
      return null;
    }

    if (widget.excludeList.contains(text!.formatTag())) {
      return "Categoria já adicionada!";
    }

    if (text!.isEmpty) {
      return "Campo obrigatório!";
    }

    return "Muito curto.";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Nova Categoria"),
      content: Container(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UnderlinedTextField(
              label: "Categoria",
              onChanged: (value) {
                setState(() {
                  text = value;
                });
              },
              errorText: errorText,
              maxLength: 25,
            ),
            if (validText) ProductTag(title: text!.formatTag()),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text("cancelar"),
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(AppColors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: validText
              ? () => Navigator.of(context).pop(text!.formatTag())
              : null,
          child: Text("Concluir"),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.orange),
          ),
        ),
      ],
    );
  }
}
