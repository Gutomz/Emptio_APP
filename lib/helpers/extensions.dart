import 'dart:convert';
import 'dart:io';

extension StringExtension on String {
  bool isEmailValid() {
    final RegExp regex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
    return regex.hasMatch(this);
  }
}

extension FileExension on File {
  String parseToBase64() {
    final bytes = this.readAsBytesSync();
    return base64Encode(bytes);
  }
}
