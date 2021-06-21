import 'package:emptio/core/app_colors.dart';
import 'package:flutter/material.dart';

class UnderlinedTextField extends StatelessWidget {
  final String label;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final TextInputAction? textInputAction;
  final int? maxLength;

  final Function(String)? onChanged;
  final Function()? onEditingComplete;

  UnderlinedTextField({
    Key? key,
    required this.label,
    this.errorText,
    this.controller,
    this.keyboardType,
    this.suffix,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        labelStyle: TextStyle(color: AppColors.blue),
        border: UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.orange),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.red),
        ),
        suffix: suffix,
        fillColor: Colors.transparent,
      ),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
    );
  }
}
