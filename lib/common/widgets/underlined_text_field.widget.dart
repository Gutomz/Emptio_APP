import 'package:emptio/core/app_colors.dart';
import 'package:flutter/material.dart';

class UnderlinedTextField extends StatelessWidget {
  final bool? enabled;
  final String label;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final bool obscureText;

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
    this.suffixIcon,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
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
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
    );
  }
}

class UnderlinedPasswordTextField extends StatefulWidget {
  final bool? enabled;
  final String label;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final Color? iconColor;

  final Function(String)? onChanged;
  final Function()? onEditingComplete;

  const UnderlinedPasswordTextField({
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
    this.iconColor,
  }) : super(key: key);

  @override
  _UnderlinedPasswordTextFieldState createState() =>
      _UnderlinedPasswordTextFieldState();
}

class _UnderlinedPasswordTextFieldState
    extends State<UnderlinedPasswordTextField> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return UnderlinedTextField(
      label: widget.label,
      enabled: widget.enabled,
      errorText: widget.errorText,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      suffix: widget.suffix,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      maxLength: widget.maxLength,
      textCapitalization: widget.textCapitalization,
      obscureText: !visible,
      suffixIcon: IconButton(
        onPressed: () => setState(() {
          visible = !visible;
        }),
        icon: Icon(
          visible ? Icons.visibility_off : Icons.visibility,
          color: widget.iconColor ?? AppColors.grey,
        ),
      ),
    );
  }
}
