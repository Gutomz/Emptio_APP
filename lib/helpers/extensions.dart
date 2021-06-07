import 'dart:convert';
import 'dart:io';

import 'package:mime_type/mime_type.dart';

extension StringExtension on String {
  bool isEmailValid() {
    final RegExp regex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
    return regex.hasMatch(this);
  }
}

extension FileExension on File {
  String parseToBase64() {
    final bytes = this.readAsBytesSync();

    String filename = this.path.split('/').last;
    String mimeType = mime(filename) ?? "image/png";

    return "data:" + mimeType + ";base64," + base64Encode(bytes);
  }
}
