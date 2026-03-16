import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaprikaFormatter {
  static String formatTimeOnly(BuildContext context, DateTime date) {
    DateFormat dateFormat =
        DateFormat.jm(Localizations.localeOf(context).languageCode);
    return dateFormat.format(date.toLocal());
  }

  static String formatDateOnly(BuildContext context, DateTime date) {
    DateFormat dateFormat =
        DateFormat.yMd(Localizations.localeOf(context).languageCode);
    return dateFormat.format(date.toLocal());
  }

  static String formatDateTime(BuildContext context, DateTime date) {
    DateFormat dateFormat =
        DateFormat.yMd(Localizations.localeOf(context).languageCode).add_jm();
    return dateFormat.format(date.toLocal());
  }

  static String formatNumber(number) {
    NumberFormat dateFormat = NumberFormat("#,###.#");
    return dateFormat.format(number);
  }
}
