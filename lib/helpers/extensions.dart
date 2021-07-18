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
    final DateTime date = DateTime.parse(replaceFirst("-03:00", ""));
    return dateFormat.format(date);
  }

  String customFormatDate(String format) {
    final DateFormat dateFormat = DateFormat(format);
    final DateTime date = DateTime.parse(replaceFirst("-03:00", ""));
    return dateFormat.format(date);
  }

  String formatTag() {
    return trim().toLowerCase().replaceAll(" ", "-");
  }
}

extension IterableExtension<T> on Iterable<T> {
  bool containElement(bool Function(T) checkFunction) {
    for (final element in this) {
      if (checkFunction(element)) {
        return true;
      }
    }

    return false;
  }

  T? safeFirstWhere(bool Function(T) test) {
    final sublist = where(test);
    return sublist.isEmpty ? null : sublist.first;
  }
}

extension NumberExtension on num {
  String formatMoney() {
    final NumberFormat numberFormat =
        NumberFormat.simpleCurrency(locale: 'pt_BR', name: "");
    return numberFormat.format(this);
  }
}

extension FileExtension on File {
  String parseToBase64() {
    final bytes = readAsBytesSync();

    final filename = path.split('/').last;
    final mimeType = mime(filename) ?? "image/png";

    return "data:$mimeType;base64,${base64Encode(bytes)}";
  }
}
