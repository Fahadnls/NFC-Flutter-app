import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../translations/strings_enum.dart';

class OopsWidget extends StatelessWidget {
  const OopsWidget({
    super.key,
    this.errorMessage,
    this.errorTitle,
    this.iconData,
  });
  final String? errorMessage;
  final String? errorTitle;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedTitle = _localizedErrorTitle(errorTitle);
    final resolvedMessage = _localizedErrorMessage(errorMessage);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon(
          //   iconData ?? Icons.error_outline,
          //   color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
          // ),
          Center(
            child: Icon(
              iconData ?? Icons.error_outline_rounded,
              size: 72,
              color: theme.colorScheme.primary,
            ),
          ),
          const Gap(8),
          Text(
            resolvedTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(8),
          Text(
            resolvedMessage,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
            ),
          ),
        ],
      ),
    );
  }

  String _localizedErrorTitle(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty || text == 'Oops' || text == 'عذراً') {
      return Strings.oops.tr;
    }
    return text;
  }

  String _localizedErrorMessage(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty ||
        text == 'Something went wrong' ||
        text == 'حدث خطأ ما') {
      return Strings.something_went_wrong.tr;
    }
    if (text == 'Request timed out. Please try again.' ||
        text == 'انتهت مهلة الطلب. يرجى المحاولة مرة أخرى.') {
      return Strings.request_timed_out_try_again.tr;
    }
    if (text == 'An unexpected error occurred. Please try again.' ||
        text == 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.') {
      return Strings.unexpected_error_try_again.tr;
    }
    return text;
  }
}
