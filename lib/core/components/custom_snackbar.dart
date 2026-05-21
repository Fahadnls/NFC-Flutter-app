import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../translations/strings_enum.dart';
import '../theme/app_colors.dart';
import '../utils/consts.dart';

enum SnackbarType { success, danger, warning }

class CustomSnackBar {
  static final List<_ToastItem> _activeToasts = [];

  static void showCustomSnackBar({
    required String title,
    required String message,
    Duration? duration,
    SnackPosition? snackPosition,
    SnackbarType? snackbarType,
    Color? color,
    IconData? icon,
    Color? iconColor,
    bool isButton = false,
    String buttonText = '',
    VoidCallback? onButtonPressed,
  }) {
    Get.snackbar(
      title,
      message,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      colorText: Colors.white,
      backgroundColor:
          color ??
          (snackbarType == SnackbarType.success
              ? AppColors.success
              : snackbarType == SnackbarType.danger
              ? AppColors.danger
              : snackbarType == SnackbarType.warning
              ? AppColors.warning
              : Get.theme.primaryColor),
      snackPosition: snackPosition ?? SnackPosition.TOP,
      icon: Icon(
        icon ??
            (snackbarType == SnackbarType.success
                ? Icons.check_circle
                : snackbarType == SnackbarType.danger
                ? Icons.error
                : snackbarType == SnackbarType.warning
                ? Icons.warning_amber_rounded
                : null),
        color: iconColor ?? Colors.white,
      ),
      mainButton: isButton
          ? TextButton(
              onPressed: onButtonPressed ?? () => Get.closeAllSnackbars(),
              child: Text(
                buttonText,
                style: Get.textTheme.labelSmall?.copyWith(color: Colors.white),
              ),
            )
          : null,
    );
  }

  static void showCustomToast({
    String? title,
    required String message,
    Duration? duration,
    SnackPosition? snackPosition,
    SnackbarType? snackbarType,
    bool isButton = false,
    String buttonText = '',
    VoidCallback? onButtonPressed,
    Color? color,
    IconData? icon,
    Color? iconColor,
  }) {
    Get.rawSnackbar(
      title: title,
      message: message,
      onTap: (snack) {
        Get.closeAllSnackbars();
      },
      duration: duration ?? const Duration(seconds: 3),
      snackStyle: SnackStyle.GROUNDED,
      snackPosition: snackPosition ?? SnackPosition.BOTTOM,
      backgroundColor:
          color ??
          (snackbarType == SnackbarType.success
              ? AppColors.success
              : snackbarType == SnackbarType.danger
              ? AppColors.dangerDark
              : snackbarType == SnackbarType.warning
              ? AppColors.warning
              : Get.theme.primaryColor),
      icon: Icon(
        icon ??
            (snackbarType == SnackbarType.success
                ? Icons.check_circle
                : snackbarType == SnackbarType.danger
                ? Icons.error
                : snackbarType == SnackbarType.warning
                ? Icons.warning
                : null),
        color: iconColor ?? Colors.white,
      ),
      mainButton: isButton
          ? TextButton(
              onPressed: onButtonPressed ?? () => Get.closeAllSnackbars(),
              child: Text(
                buttonText,
                style: const TextStyle(color: Colors.white),
              ),
            )
          : null,
    );
  }

  static void showAppCustomToast({
    String? title,
    required String message,
    Duration? duration,
    SnackPosition? snackPosition,
    SnackbarType? snackbarType,
    bool isButton = false,
    String buttonText = '',
    VoidCallback? onButtonPressed,
    Color? color,
    IconData? icon,
    Color? iconColor,
  }) {
    final overlayContext = Get.overlayContext;
    if (overlayContext == null) return;
    final resolvedTitle = _localizedToastText(title);
    final resolvedMessage = _localizedToastText(message) ?? message;

    final overlay = Overlay.of(overlayContext);
    final toastId = UniqueKey();

    final activeColor =
        color ??
        (snackbarType == SnackbarType.success
            ? AppColors.success
            : snackbarType == SnackbarType.danger
            ? AppColors.dangerDark
            : snackbarType == SnackbarType.warning
            ? AppColors.warning
            : Get.theme.primaryColor);

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) {
        final index = _activeToasts.indexWhere((e) => e.id == toastId);
        final bottomSafeArea = MediaQuery.of(context).padding.bottom;

        const double stackOffset = 2;

        final double bottom = bottomSafeArea + 12 + (index * stackOffset);

        return Positioned(
          left: Get.width * 0.02,
          right: Get.width * 0.02,
          bottom: bottom,
          child: Material(
            color: Colors.transparent,
            child: _ToastView(
              title: resolvedTitle,
              message: resolvedMessage,
              activeColor: activeColor,
              snackbarType: snackbarType,
              onClose: () => _removeToast(toastId),
              isButton: isButton,
              buttonText: buttonText,
              onButtonPressed: onButtonPressed,
            ),
          ),
        );
      },
    );

    _activeToasts.add(_ToastItem(id: toastId, entry: entry));
    overlay.insert(entry);

    Future.delayed(duration ?? const Duration(seconds: 3), () {
      _removeToast(toastId);
    });
  }

  static void _removeToast(Key id) {
    final index = _activeToasts.indexWhere((e) => e.id == id);
    if (index == -1) return;

    _activeToasts[index].entry.remove();
    _activeToasts.removeAt(index);

    for (final toast in _activeToasts) {
      toast.entry.markNeedsBuild();
    }
  }

  static String? _localizedToastText(String? value) {
    final text = value?.trim();
    if (text == null || text.isEmpty) {
      return value;
    }

    switch (text) {
      case 'Cart updated successfully':
      case 'تم تحديث السلة بنجاح':
        return Strings.cart_updated_successfully.tr;
      case 'Product added to wishlist':
      case 'تمت إضافة المنتج إلى المفضلة':
      case 'تم إضافة المنتج إلى قائمة الأمنيات':
        return Strings.product_added_to_wishlist.tr;
      case 'Product removed from wishlist':
      case 'تمت إزالة المنتج من المفضلة':
        return Strings.product_removed_from_wishlist.tr;
      case 'Added to cart':
      case 'تمت الإضافة إلى السلة':
        return Strings.added_to_cart.tr;
      case 'Address updated successfully':
      case 'تم تحديث العنوان بنجاح':
        return Strings.address_updated_successfully.tr;
      case 'Review submitted successfully':
      case 'تم إرسال التقييم بنجاح':
        return Strings.review_submitted_successfully.tr;
      default:
        return value;
    }
  }
}

class _ToastItem {
  final Key id;
  final OverlayEntry entry;

  _ToastItem({required this.id, required this.entry});
}

class _ToastView extends StatelessWidget {
  final String? title;
  final String message;
  final Color activeColor;
  final SnackbarType? snackbarType;
  final VoidCallback onClose;
  final bool isButton;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  const _ToastView({
    required this.title,
    required this.message,
    required this.activeColor,
    required this.snackbarType,
    required this.onClose,
    required this.isButton,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kSpacing, vertical: kSpacing),
      decoration: BoxDecoration(
        color: const Color(0xFF5E564D),
        borderRadius: BorderRadius.circular(Get.width * 0.04),
        border: Border(left: BorderSide(color: activeColor, width: 6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width * (Get.width >= 700 ? 0.018 : 0.05),
              height: Get.width * (Get.width >= 700 ? 0.018 : 0.05),
              decoration: BoxDecoration(
                color: activeColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                snackbarType == SnackbarType.success
                    ? Icons.check
                    : snackbarType == SnackbarType.danger
                    ? Icons.close
                    : snackbarType == SnackbarType.warning
                    ? Icons.warning
                    : Icons.info_outline,
                color: Get.theme.cardColor,
                size: Get.width * (Get.width >= 700 ? 0.011 : 0.03),
              ),
            ),
            SizedBox(width: Get.width * 0.018),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      message,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Get.width * (Get.width >= 700 ? 0.012 : 0.04),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (title != null && title!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      title!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            Get.width * (Get.width >= 700 ? 0.011 : 0.036),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                  if (isButton) ...[
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: onButtonPressed ?? onClose,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        buttonText,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            GestureDetector(
              onTap: onClose,
              child: Container(
                width: Get.width * (Get.width >= 700 ? 0.018 : 0.05),
                height: Get.width * (Get.width >= 700 ? 0.018 : 0.05),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(46),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: Get.width * (Get.width >= 700 ? 0.01 : 0.026),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
