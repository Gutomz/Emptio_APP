import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:mime_type/mime_type.dart';

extension StringExtension on String {
  bool isEmailValid() {
    final RegExp regex = RegExp(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
    return regex.hasMatch(this);
  }

  String formatDate() {
    final date = customFormatDate("dd/MM/yy");
    final time = customFormatDate("HH:mm");
    return "$date às $time";
  }

  String customFormatDate(String format, {String errorFormat = "-"}) {
    try {
      final DateFormat dateFormat = DateFormat(format);
      final DateTime date = toDate();
      return dateFormat.format(date);
    } catch (_) {
      return errorFormat;
    }
  }

  DateTime toDate() {
    return DateTime.parse(replaceFirst("-03:00", ""));
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
  String formatMoney({String symbol = ""}) {
    final NumberFormat numberFormat =
        NumberFormat.simpleCurrency(locale: 'pt_BR', name: symbol);
    return numberFormat.format(this);
  }

  String formatDistance() {
    return "$this metros";
  }
}

extension FileExtension on File {
  String parseToBase64() {
    final bytes = readAsBytesSync();

    final filename = path.split('/').last;
    final mimeType = mime(filename) ?? "image/jpeg";

    return "data:$mimeType;base64,${base64Encode(bytes)}";
  }
}

extension Uint8ListExtension on Uint8List {
  String parseToBase64() {
    return "data:image/jpeg;base64,${base64Encode(this)}";
  }
}
