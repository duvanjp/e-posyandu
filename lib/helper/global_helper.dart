import 'dart:io';

import 'package:intl/intl.dart';

class GlobalHelper {
  static bool isEmpty(text) {
    if (text == "" || text == null || text == "null") {
      return true;
    } else {
      return false;
    }
  }

  static bool isEmptyList(List<dynamic>? list) {
    if (list == null) {
      return true;
    } else if (list.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  static String? formatNumberToString(String? text,
      {String? defaultValue = "0"}) {
    if (GlobalHelper.isEmpty(text)) {
      return defaultValue;
    }
    return int.parse(double.parse(text!).toStringAsFixed(0)).toString();
  }

  static int formatStringToNumber(String text, {int defaultValue = 0}) {
    if (GlobalHelper.isEmpty(text)) {
      return defaultValue;
    }
    return int.parse(double.parse(text).toStringAsFixed(0));
  }

  static String getInitials(String name) {
    List<String> names = name.split(" ");
    if (names.length == 1) {
      return names[0][0];
    }

    String initials = "";
    int numWords = 2;

    if (numWords < names.length) {
      numWords = names.length;
    }

    for (var i = 0; i < numWords; i++) {
      initials += '${names[i][0]}';
    }
    return initials;
  }

  static String formatPrice(price) {
    final formatCurrency = NumberFormat.simpleCurrency(
        locale: Platform.localeName, name: '', decimalDigits: 0);

    return formatCurrency.format(price);
  }

  static String displayDate(DateTime date) {
    String formattedDate = DateFormat('dd MMMM yyyy').format(date);

    return formattedDate;
  }

  static String displayDateRange(DateTime date) {
    String formattedDate = DateFormat('dd MMMM yyyy').format(date);

    return formattedDate;
  }
}
