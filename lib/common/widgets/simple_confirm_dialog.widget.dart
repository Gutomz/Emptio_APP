import 'package:emptio/core/app_colors.dart';
import 'package:flutter/material.dart';

class SimpleConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final String rejectText;
  final String acceptText;

  const SimpleConfirmDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.acceptText,
    required this.rejectText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
      content: Text(content, style: TextStyle(fontSize: 14)),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(AppColors.grey),
          ),
          child: Text(rejectText),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(AppColors.red),
          ),
          child: Text(acceptText),
        ),
      ],
    );
  }
}
