import 'package:get/get.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static bool get _isArabic => Get.locale?.languageCode == 'ar';

  static String get symbol => _isArabic ? 'د.ع' : 'IQD';

  static String amount(num value, {int decimals = 0, bool trim = true}) {
    final formatted = decimals <= 0
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(decimals);
    final normalized = trim && decimals > 0
        ? formatted
              .replaceFirst(RegExp(r'0+$'), '')
              .replaceFirst(RegExp(r'\.$'), '')
        : formatted;
    return '$symbol $normalized';
  }
}
