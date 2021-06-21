import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:mime_type/mime_type.dart';

extension StringExtension on String {
  bool isEmailValid() {
    final RegExp regex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
    return regex.hasMatch(this);
  }

  String formatDate() {
    final DateFormat dateFormat = DateFormat("dd/MM/yy HH:mm");
    DateTime date = DateTime.parse(this.replaceFirst("-03:00", ""));
    return dateFormat.format(date);
  }

  String formatTag() {
    return this.trim().toLowerCase().replaceAll(" ", "-");
  }
}

extension IterableExtension on Iterable {
  bool containElement(bool Function(dynamic) checkFunction) {
    for (var element in this) {
      if (checkFunction(element)) {
        return true;
      }
    }

    return false;
  }
}

extension NumberExtension on num {
  String formatMoney() {
    final NumberFormat numberFormat =
        NumberFormat.simpleCurrency(locale: 'pt_BR', name: "");
    return numberFormat.format(this);
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
