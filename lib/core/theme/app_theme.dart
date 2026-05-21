import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static TextTheme _getTextTheme(String languageCode, Color customColor) {
    final isArabic = languageCode == 'ar';

    TextStyle headingStyle(
      double size,
      FontWeight weight,
      double height,
      double spacing,
    ) {
      return isArabic
          ? GoogleFonts.tajawal(
              fontSize: size,
              fontWeight: weight,
              height: height,
              letterSpacing: spacing,
              color: customColor,
            )
          : GoogleFonts.bodoniModa(
              fontSize: size,
              fontWeight: weight,
              height: height,
              letterSpacing: spacing,
              color: customColor,
            );
    }

    TextStyle bodyStyle(
      double size,
      FontWeight weight,
      double height,
      double spacing,
    ) {
      return isArabic
          ? GoogleFonts.tajawal(
              fontSize: size,
              fontWeight: weight,
              height: height,
              letterSpacing: spacing,
              color: customColor,
            )
          : GoogleFonts.montserrat(
              fontSize: size,
              fontWeight: weight,
              height: height,
              letterSpacing: spacing,
              color: customColor,
            );
    }

    return TextTheme(
      displayLarge: headingStyle(32, FontWeight.w400, 30 / 32, 0),
      displayMedium: headingStyle(24, FontWeight.w400, 22 / 24, 0),
      displaySmall: headingStyle(20, FontWeight.w400, 22 / 20, 0),

      titleLarge: bodyStyle(18, FontWeight.w700, 26 / 18, 0),
      titleMedium: bodyStyle(16, FontWeight.w700, 24 / 16, 0),
      titleSmall: bodyStyle(14, FontWeight.w500, 17 / 14, 0),

      bodyLarge: bodyStyle(12, FontWeight.w500, 17 / 12, 0),
      bodyMedium: bodyStyle(14, FontWeight.w400, 20 / 14, 0),
      bodySmall: bodyStyle(12, FontWeight.w400, 18 / 12, 0),

      labelLarge: bodyStyle(14, FontWeight.w500, 20 / 14, 0),
      labelMedium: bodyStyle(12, FontWeight.w500, 18 / 12, 0),
      labelSmall: bodyStyle(12, FontWeight.w500, 1.2, 0),
    );
  }

  static ThemeData getLightTheme([String languageCode = 'en']) {
    const lightBackground = AppColors.offWhite;
    const lightSurface = Color(0xFFFFFCF8);
    const lightText = AppColors.blackEel;
    const lightMutedText = AppColors.softTaupe;
    const lightBorder = AppColors.gainsboro;
    final textTheme = _getTextTheme(languageCode, lightText);

    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColor,
        secondary: AppColors.primaryGold,
        surface: lightSurface,
        error: AppColors.red,
        onPrimary: AppColors.white,
        onSecondary: AppColors.blackEel,
        onSurface: lightText,
        onError: AppColors.white,
      ),
      scaffoldBackgroundColor: lightBackground,
      canvasColor: lightBackground,
      dividerColor: lightBorder,
      splashColor: AppColors.primaryColor.withAlpha(16),
      highlightColor: Colors.transparent,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      iconTheme: const IconThemeData(color: lightText),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          foregroundColor: lightText,
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: lightText),
        foregroundColor: lightText,
        elevation: 0,
      ),
      cardColor: lightSurface,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 18,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(color: lightMutedText),
        labelStyle: textTheme.labelSmall?.copyWith(color: AppColors.softTaupe),
        errorStyle: textTheme.labelSmall?.copyWith(color: AppColors.red),
        fillColor: AppColors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.4,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.red, width: 1.5),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(cursorColor: lightText),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: lightText,
          side: const BorderSide(color: lightBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: textTheme.bodyMedium,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        ),
      ),
    );
  }

  static ThemeData getDarkTheme([String languageCode = 'en']) {
    const darkBackground = Color(0xFF121614);
    const darkSurface = Color(0xFF18201D);
    const darkText = Color(0xFFF7F3EE);
    const darkMutedText = Color(0xFFB4A895);
    final darkBorder = AppColors.white.withAlpha(38);
    final textTheme = _getTextTheme(languageCode, darkText);

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primaryColor,
        secondary: AppColors.primaryGold,
        surface: darkSurface,
        error: AppColors.red,
        onPrimary: AppColors.white,
        onSecondary: AppColors.blackEel,
        onSurface: darkText,
        onError: AppColors.white,
      ),
      scaffoldBackgroundColor: darkBackground,
      canvasColor: darkBackground,
      dividerColor: darkBorder,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      iconTheme: const IconThemeData(color: darkText),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          foregroundColor: darkText,
          padding: EdgeInsets.zero,
          visualDensity: VisualDensity.compact,
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: darkText),
        foregroundColor: darkText,
        elevation: 0,
      ),
      cardColor: darkSurface,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        hintStyle: textTheme.bodyMedium?.copyWith(color: darkMutedText),
        labelStyle: textTheme.labelSmall?.copyWith(color: darkMutedText),
        errorStyle: textTheme.labelSmall?.copyWith(color: AppColors.red),
        fillColor: const Color(0xFF1D2522),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.4,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: AppColors.red, width: 1.5),
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(cursorColor: darkText),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: darkText,
          side: BorderSide(color: AppColors.white.withAlpha(160)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: textTheme.bodyMedium,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        ),
      ),
    );
  }

  static ThemeData get lightTheme => getLightTheme('en');
  static ThemeData get darkTheme => getDarkTheme('en');
}
