import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

import '../translations/strings_enum.dart';
import '../utils/consts.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    super.key,
    this.image,
    this.title,
    this.message,
    this.buttonText,
    this.onTap,
  });
  final String? image;
  final String? title;
  final String? message;
  final String? buttonText;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off_rounded,
                  size: Get.height * 0.18,
                  color: theme.colorScheme.primary,
                ),
                Gap(Get.height * 0.04),
                Text(
                  title ?? Strings.oh_no.tr,
                  style: theme.textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(Get.height * 0.012),
                Text(
                  message ??
                      'May be bigfoot has broken this page.\nCome back to the homepage',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
                  ),
                ),
                Gap(Get.height * 0.04),
                SizedBox(
                  width: Get.width,
                  child: ElevatedButton(
                    onPressed:
                        onTap ??
                        () {
                          Get.back();
                        },
                    child: Text(
                      buttonText ?? Strings.back_to_homepage.tr,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
