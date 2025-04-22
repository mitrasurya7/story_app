import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DateFormatter {
  static String formatToLocalFullDate(BuildContext context, String rawDate) {
    try {
      final date = DateTime.parse(rawDate);
      final locale = Localizations.localeOf(context).languageCode;
      return DateFormat.yMMMMEEEEd(locale).format(date);
    } catch (_) {
      return rawDate; // fallback jika parsing gagal
    }
  }

  static String formatToLocalShortDate(BuildContext context, String rawDate) {
    try {
      final date = DateTime.parse(rawDate);
      final locale = Localizations.localeOf(context).languageCode;
      return DateFormat.yMMMd(locale).format(date);
    } catch (_) {
      return rawDate;
    }
  }
}
