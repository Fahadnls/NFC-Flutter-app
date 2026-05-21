import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/providers/storage_provider.dart';
import 'ar_AR/ar_ar_translation.dart';
import 'en_US/en_us_translation.dart';

class LocalizationService extends Translations {
  // default language
  // todo change the default language
  static Locale defaultLanguage = supportedLanguages['en']!;

  // supported languages
  static Map<String, Locale> supportedLanguages = {
    'en': const Locale('en', 'US'),
    'ar': const Locale('ar', 'AR'),
  };

  // supported languages fonts family (must be in assets & pubspec yaml) or you can use google fonts
  static Map<String, TextStyle> supportedLanguagesFontsFamilies = {
    'en': GoogleFonts.inter(),
    'ar': GoogleFonts.cairo(),
  };

  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUs, 'ar_AR': arAR};

  /// check if the language is supported
  static bool isLanguageSupported(String languageCode) =>
      supportedLanguages.keys.contains(languageCode);

  /// update app language by code language for example (en,ar..etc)
  static Future<void> updateLanguage(String languageCode) async {
    // check if the language is supported
    if (!isLanguageSupported(languageCode)) return;
    // update current language in shared pref
    StorageProvider.setCurrentLanguage(languageCode);
    await Get.updateLocale(supportedLanguages[languageCode]!);
  }

  /// check if the language is english
  static Future<bool> isItEnglish() async {
    final code = await StorageProvider.getCurrentLanguageCode();
    return (code ?? 'en').toLowerCase().contains('en');
  }

  /// get current locale
  static Future<Locale> getCurrentLocal() async {
    if (kDebugMode) {
      return supportedLanguages['en']!;
    }
    final code = await StorageProvider.getCurrentLanguageCode() ?? 'en';
    return supportedLanguages[code] ?? supportedLanguages['en']!;
  }
}
