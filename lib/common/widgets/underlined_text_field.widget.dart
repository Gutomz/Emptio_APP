import 'package:emptio/core/app_colors.dart';
import 'package:flutter/material.dart';

class UnderlinedTextField extends StatelessWidget {
  final bool? enabled;
  final String label;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final TextCapitalization textCapitalization;

  final Function(String)? onChanged;
  final Function()? onEditingComplete;

  UnderlinedTextField({
    Key? key,
    this.enabled,
    required this.label,
    this.errorText,
    this.controller,
    this.keyboardType,
    this.suffix,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      textCapitalization: textCapitalization,
      style: enabled != false
          ? null
          : TextStyle(
              color: AppColors.grey,
            ),
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        labelStyle: TextStyle(
          color: enabled != false ? AppColors.blue : AppColors.grey,
        ),
        border: UnderlineInputBorder(),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrey),
        ),
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
