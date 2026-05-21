// ignore_for_file: must_be_immutable, deprecated_member_use, unnecessary_this, use_super_parameters, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:like_button/like_button.dart';

import '../theme/app_colors.dart';
import '../utils/consts.dart';

extension _NumSizer on num {
  double get h => toDouble();
  double get w => toDouble();
}

enum IconPosition { leading, trailing }

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPress,
    this.color,
    this.isOutlined = false,
    this.isDisabled = false,
    this.icon,
    this.width,
    this.fontSize,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.isSmallText = false,
    this.showSkeleton = false,
    this.iconPosition = IconPosition.leading,
    this.height,
    this.padding,
  });

  const CustomButton.primary({
    Key? key,
    required this.text,
    this.onPress,
    this.isOutlined = false,
    this.isDisabled = false,
    this.icon,
    this.width = double.infinity,
    this.fontSize,
    this.textColor,
    this.borderRadius,
    this.borderColor,
    this.isSmallText = false,
    this.showSkeleton = false,
    this.iconPosition = IconPosition.leading,
    this.height,
    this.padding,
  }) : color = AppColors.primaryColor,
       super(key: key);

  final String text;
  final VoidCallback? onPress;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final bool isOutlined;
  final bool isDisabled;
  final double? width;
  final double? fontSize;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final IconData? icon;
  final bool isSmallText;
  final bool showSkeleton;
  final IconPosition iconPosition;

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    final resolvedColor = color ?? theme.colorScheme.primary;
    final resolvedRadius = borderRadius ?? BorderRadius.circular(kBorderRadius);
    final resolvedTextColor = isOutlined
        ? textColor ?? resolvedColor
        : textColor ?? AppColors.white;
    final buttonHeight = height ?? (isSmallText ? 48 : 52.h);

    final buttonPadding =
        padding ??
        EdgeInsets.symmetric(
          vertical: isSmallText ? kSpacing : kPadding * 0.7,
          horizontal: kPadding,
        );

    return SizedBox(
      width: width,
      height: buttonHeight,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(isDisabled ? 0 : 0),
          padding: WidgetStateProperty.all(buttonPadding),
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.disabled)) {
              return theme.disabledColor.withAlpha(51);
            }
            return isOutlined ? Colors.transparent : resolvedColor;
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.disabled)) {
              return theme.disabledColor;
            }
            return resolvedTextColor;
          }),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: resolvedRadius,
              side: BorderSide(
                color: isOutlined
                    ? (borderColor ?? resolvedColor)
                    : (borderColor ?? Colors.transparent),
              ),
            ),
          ),
          overlayColor: WidgetStateProperty.all(
            resolvedColor.withOpacity(isOutlined ? 0.08 : 0.18),
          ),
        ),
        onPressed: isDisabled ? null : onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null && iconPosition == IconPosition.leading) ...[
              Icon(icon, color: resolvedTextColor, size: isSmallText ? 16 : 18),
              Gap(isSmallText ? 6 : 8),
            ],
            Flexible(
              child: Text(
                text,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: resolvedTextColor,
                  fontSize: fontSize ?? (isSmallText ? 14 : 16),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (icon != null && iconPosition == IconPosition.trailing) ...[
              Gap(isSmallText ? 6 : 8),
              Icon(icon, color: resolvedTextColor, size: isSmallText ? 16 : 18),
            ],
          ],
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    Key? key,
    required this.text,
    this.color,
    this.iconColor,
    this.textWidget,
    required this.onPress,
    this.background,
    this.enable = true,
    this.icon,
    this.borderRadius,
    this.showUnderline = false,
    this.iconPosition = IconPosition.trailing,
    this.showSkeleton = false,
    this.isSmall = false,
    this.spaceBetween,
    this.horizontalSpace,
    this.borderWidth,
    this.borderColor,
    this.isOutlined = false,
    this.isSolid = false,
    this.alignment = Alignment.center, // Default alignment is center
  }) : super(key: key);

  // Additional constructor for outlined buttons
  const CustomTextButton.outline({
    super.key,
    required this.text,
    required this.onPress,
    this.color,
    this.iconColor,
    this.borderRadius,
    this.textWidget,
    this.isSmall = false,
    this.icon,
    this.iconPosition = IconPosition.trailing,
    this.showUnderline = false,
    this.spaceBetween,
    this.horizontalSpace,
    this.borderWidth,
    this.borderColor,
    this.alignment = Alignment.center, // Default to center
  }) : background = Colors.transparent,
       enable = true,
       isOutlined = true,
       isSolid = false,
       showSkeleton = false;

  final String text;
  final Color? color;
  final Widget? textWidget;
  final Color? iconColor;
  final Color? background;
  final Function() onPress;
  final bool enable;
  final bool isOutlined;
  final bool isSolid;
  final bool isSmall;
  final bool showUnderline;
  final IconPosition iconPosition;
  final bool showSkeleton;
  final IconData? icon;
  final double? borderRadius;
  final double? spaceBetween;
  final double? horizontalSpace;
  final double? borderWidth;
  final Color? borderColor;
  final Alignment alignment; // Alignment property

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double height = isSmall ? 30.h : 35.h;

    return Align(
      alignment: alignment, // Use the alignment property
      child: SizedBox(
        height: height,
        // Only stretch if alignment is not center
        width:
            alignment == Alignment.centerLeft || alignment == Alignment.center
            ? null
            : double.infinity,
        child: TextButton(
          onPressed: enable ? onPress : null,
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.zero),

            minimumSize: WidgetStateProperty.all(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            backgroundColor: WidgetStateProperty.all(
              _getBackgroundColor(theme),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  borderRadius ?? kBorderRadius / 2,
                ),
                side: BorderSide(
                  color:
                      borderColor ??
                      (isOutlined
                          ? color ?? theme.splashColor
                          : Colors.transparent),
                  width: borderWidth ?? 1,
                ),
              ),
            ),
            overlayColor: WidgetStateProperty.all(_getOverlayColor(theme)),
          ),
          child: _buildButtonContent(theme),
        ),
      ),
    );
  }

  // Helper methods for better readability
  Color _getBackgroundColor(ThemeData theme) {
    if (!enable) {
      return theme.scaffoldBackgroundColor.withOpacity(.1);
    }
    if (isSolid) {
      return background ?? theme.primaryColor;
    }
    if (isOutlined) {
      return Colors.transparent;
    }
    return background ??
        (color == null ? theme.cardColor : color!.withOpacity(.2));
  }

  Color _getOverlayColor(ThemeData theme) {
    if (!enable) {
      return theme.disabledColor.withOpacity(.1);
    }
    if (isSolid) {
      return theme.splashColor;
    }
    return color?.withOpacity(.1) ??
        (theme.textTheme.bodyLarge?.color ?? Colors.black).withOpacity(.1);
  }

  Widget _buildButtonContent(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Gap(horizontalSpace ?? 0),
        if (icon != null && iconPosition == IconPosition.leading) ...[
          Icon(icon, size: isSmall ? 15 : 20, color: _getIconColor(theme)),
          _buildGap(),
        ],
        textWidget ??
            Text(
              text,
              style: TextStyle(
                fontSize: isSmall ? 12 : 14,
                color: _getTextColor(theme),
                decoration: showUnderline ? TextDecoration.underline : null,
                decorationColor: _getTextColor(theme),
                decorationThickness: 2,
              ),
            ),
        if (icon != null && iconPosition == IconPosition.trailing) ...[
          _buildGap(),
          Icon(icon, size: isSmall ? 15 : 20, color: _getIconColor(theme)),
        ],
        Gap(horizontalSpace ?? 0),
      ],
    );
  }

  Widget _buildGap() {
    return spaceBetween == null
        ? (isSmall ? const Gap(2) : const Gap(8))
        : SizedBox(width: spaceBetween);
  }

  Color _getIconColor(ThemeData theme) {
    return iconColor ??
        (color ?? (theme.textTheme.bodyLarge?.color ?? Colors.black));
  }

  Color _getTextColor(ThemeData theme) {
    if (!enable) {
      return Colors.black.withOpacity(.5);
    }
    if (isSolid) {
      return theme.cardColor;
    }
    return color ?? (theme.textTheme.bodyLarge?.color ?? Colors.black);
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData? iconData;
  final Widget? iconWidget;
  final Function()? onTap;
  final Color? backgroundColor;
  final String? tooltip;
  final bool isOutlined;
  final bool isRounded;
  final bool showShadow;
  final bool isSmall;
  final Color? color;
  final int? badge;
  final double? size, iconSize;

  // Default solid constructor
  CustomIconButton({
    Key? key,
    this.iconData,
    this.size,
    this.iconSize,
    this.iconWidget,
    this.onTap,
    this.backgroundColor,
    this.isRounded = true,
    this.showShadow = false,
    this.isSmall = false,
    this.color,
    this.tooltip,
    this.badge,
  }) : isOutlined = false, // Solid button by default
       super(key: key);

  // Outline constructor
  CustomIconButton.outline({
    Key? key,
    this.iconData,
    this.iconWidget,
    this.size,
    this.onTap,
    this.backgroundColor,
    this.isRounded = true,
    this.showShadow = false,
    this.isSmall = false,
    this.color,
    this.tooltip,
    this.badge,
    this.iconSize,
  }) : isOutlined = true, // Outline button
       super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    double height = size ?? (isSmall ? 35 : 45);
    double width = size ?? (isSmall ? 35 : 45);

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: isRounded ? BoxShape.circle : BoxShape.rectangle,
        color: isOutlined
            ? Colors.transparent
            : backgroundColor ?? theme.cardColor,
        borderRadius: isRounded ? null : BorderRadius.circular(12),
        border: Border.all(
          color: isOutlined
              ? color ?? backgroundColor ?? theme.primaryColor
              : Colors.transparent,
          width: 1,
        ),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 1,
                  color: theme.disabledColor.withOpacity(.3),
                ),
              ]
            : [],
      ),
      child: Tooltip(
        message: tooltip ?? "",
        child: Material(
          color: Colors.transparent,
          shape: isRounded ? const CircleBorder() : null,
          child: InkWell(
            customBorder: isRounded ? const CircleBorder() : null,
            splashColor:
                color?.withOpacity(.1) ?? theme.primaryColor.withOpacity(.1),
            highlightColor: Colors.black.withOpacity(.1),
            borderRadius: isRounded ? null : BorderRadius.circular(12),
            onTap: onTap,
            child: Align(
              alignment: Alignment.center,
              child: Badge(
                isLabelVisible: badge != null,
                smallSize: 7,
                alignment: const AlignmentDirectional(1.1, -1),
                backgroundColor: Colors.red,
                textColor: color,
                child:
                    iconWidget ??
                    Icon(
                      iconData,
                      color: color ?? theme.primaryColor,
                      size: iconSize ?? (isSmall ? 20 : null),
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomLikeButton extends StatelessWidget {
  const CustomLikeButton({
    super.key,
    this.onTap,
    this.color,
    this.outlineIcon,
    this.solidIcon,
    this.isLike,
    this.iconSize,
  });
  final Future<bool?> Function(bool)? onTap;
  final Color? color;
  final IconData? outlineIcon;
  final IconData? solidIcon;
  final bool? isLike;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Get.theme;
    final isEnglish = Get.locale.toString() == "en_US";
    // final buttonColor = color ?? theme.primaryColor;
    final buttonColor = AppColors.red;

    return Center(
      child: LikeButton(
        padding: EdgeInsets.only(
          left: isEnglish ? 3 : 0,
          right: isEnglish ? 0 : 3,
        ),
        circleColor: CircleColor(
          start: buttonColor.withValues(alpha: 0.7),
          end: buttonColor.withValues(alpha: 0.2),
        ),
        bubblesColor: BubblesColor(
          dotPrimaryColor: buttonColor.withValues(alpha: 0.7),
          dotSecondaryColor: buttonColor.withValues(alpha: 0.2),
        ),
        isLiked: isLike ?? false,
        likeBuilder: (val) {
          return Icon(
            val
                ? solidIcon ?? Icons.favorite
                : outlineIcon ?? Icons.favorite_outline,
            color: val ? buttonColor : theme.colorScheme.onSurface,
            size: iconSize ?? 16,
          );
        },
        onTap: onTap,
      ),
    );
  }
}

// =================================================================
// Custom
// =================================================================

class CustomSavedIcon extends StatelessWidget {
  const CustomSavedIcon({super.key, required this.value, this.tooltip});

  final String value;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      // iconData: getSavedIconData(value),
      tooltip: tooltip ?? value,
      color: value.toLowerCase() == 'home'
          ? Colors.teal
          : value.toLowerCase() == 'office' || value.toLowerCase() == 'work'
          ? Colors.indigo
          : value.toLowerCase() == 'school' || value.toLowerCase() == 'college'
          ? Colors.green
          : value.toLowerCase() == 'coffee' ||
                value.toLowerCase() == 'restaurant'
          ? Colors.amber
          : value.toLowerCase() == 'airport'
          ? Colors.purple
          : value.toLowerCase() == 'hospital'
          ? const Color(0xFF87CEEB)
          : Get.theme.primaryColor,
      backgroundColor: value.toLowerCase() == 'home'
          ? Colors.teal.withOpacity(.2)
          : value.toLowerCase() == 'office' || value.toLowerCase() == 'work'
          ? Colors.indigo.withOpacity(.2)
          : value.toLowerCase() == 'school' || value.toLowerCase() == 'college'
          ? Colors.green.withOpacity(.2)
          : value.toLowerCase() == 'coffee' ||
                value.toLowerCase() == 'restaurant'
          ? Colors.amber.withOpacity(.2)
          : value.toLowerCase() == 'airport'
          ? Colors.purple.withOpacity(.2)
          : value.toLowerCase() == 'hospital'
          ? const Color(0xFF87CEEB).withOpacity(.2)
          : Get.theme.primaryColor.withOpacity(.2),
    );
  }
}

// IconData getSavedIconData(
//   value, {
//   bool isBold = true,
// }) {
//   return value.toLowerCase() == 'home'
//       ? isBold
//           ? EneftyIcons.house_bold
//           : EneftyIcons.house_outline
//       : value.toLowerCase() == 'office' || value.toLowerCase() == 'work'
//           ? isBold
//               ? EneftyIcons.briefcase_bold
//               : EneftyIcons.briefcase_outline
//           : value.toLowerCase() == 'school' || value.toLowerCase() == 'college'
//               ? isBold
//                   ? EneftyIcons.book_bold
//                   : EneftyIcons.book_outline
//               : value.toLowerCase() == 'coffee' ||
//                       value.toLowerCase() == 'restaurant'
//                   ? isBold
//                       ? EneftyIcons.shop_bold
//                       : EneftyIcons.shop_outline
//                   : value.toLowerCase() == 'airport'
//                       ? isBold
//                           ? EneftyIcons.airplane_bold
//                           : EneftyIcons.airplane_outline
//                       : value.toLowerCase() == 'hospital'
//                           ? isBold
//                               ? EneftyIcons.hospital_bold
//                               : EneftyIcons.hospital_outline
//                           : isBold
//                               ? EneftyIcons.location_bold
//                               : EneftyIcons.location_outline;
// }

class CustomAuthButton extends StatelessWidget {
  CustomAuthButton({
    Key? key,
    required this.text,
    this.onPress,
    this.color,
    this.isOutlined = false,
    this.isDisabled = false,
    this.icon,
    this.width,
    this.fontSize,
    this.textColor,
    this.borderRadius,
    this.isSmallText = false,
    this.showSkeleton = false,
    this.iconPosition = IconPosition.leading,
  }) : super(key: key) {
    this.color ??= Get.theme.progressIndicatorTheme.color;
  }

  CustomAuthButton.primary({
    Key? key,
    required this.text,
    this.onPress,
    this.isOutlined = false,
    this.isDisabled = false,
    this.icon,
    this.width,
    this.fontSize,
    this.textColor,
    this.borderRadius,
    this.isSmallText = false,
    this.showSkeleton = false,
    this.iconPosition = IconPosition.leading,
  }) : super(key: key) {
    color = Get.theme.primaryColor;
  }

  String text;
  VoidCallback? onPress;
  Color? color;
  Color? textColor;
  BorderRadiusGeometry? borderRadius;
  bool? isOutlined;
  bool? isDisabled = false;
  double? width;
  double? fontSize;
  IconData? icon;
  bool? isSmallText;
  bool? showSkeleton;
  IconPosition iconPosition;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    // double height = isSmallText == true ? 35 : 50;

    return Container(
      width: width,
      height: 50.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            isDisabled == true
                ? theme.disabledColor
                : isOutlined != true
                ? (color ?? theme.primaryColor)
                : Colors.transparent,
            isDisabled == true
                ? theme.disabledColor
                : isOutlined != true
                ? (color?.withOpacity(.8) ?? theme.primaryColor.withOpacity(.8))
                : Colors.transparent,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(kBorderRadius),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 0)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius:
                  borderRadius ?? BorderRadius.circular(kBorderRadius),
              side: BorderSide(
                color: isDisabled == true
                    ? theme.disabledColor.withOpacity(.1)
                    : (isOutlined == true
                          ? AppColors.primaryOutlinedColor
                          : color ?? theme.primaryColor),
              ),
            ),
          ),
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          overlayColor: WidgetStateProperty.all(
            isOutlined == true
                ? (color?.withOpacity(.2) ?? AppColors.primaryOutlinedColor)
                : textColor == null
                ? AppColors.white.withOpacity(.2)
                : null,
          ),
        ),
        onPressed: isDisabled == true ? null : onPress,
        child: Row(
          children: [
            SizedBox(width: 50.w),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isOutlined == true
                        ? color ?? AppColors.white
                        : textColor ?? AppColors.white,
                    fontSize: fontSize ?? (isSmallText == true ? 14 : 18),
                  ),
                ),
              ),
            ),
            Container(
              height: 50.h,
              width: 50.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(
                    -1.5,
                    -0.5,
                  ), // Approximation for 205.23 degrees
                  end: Alignment(1.0, 1.0),
                  colors: [
                    Color.fromRGBO(255, 255, 255, 0.5),
                    Color.fromRGBO(255, 255, 255, 0.2),
                    Color.fromRGBO(255, 255, 255, 0.0),
                  ],
                  stops: [0.1068, 0.3744, 0.8399],
                ),
                borderRadius:
                    borderRadius ??
                    BorderRadius.horizontal(
                      // left: Radius.circular(0),
                      // right: Radius.circular(kBorderRadius)
                      right: Get.locale.toString() != "en_US"
                          ? Radius.circular(kBorderRadius)
                          : Radius.circular(0),
                      left: Get.locale.toString() != "en_US"
                          ? Radius.circular(kBorderRadius)
                          : Radius.circular(0),
                    ),
              ),
              child: Icon(Icons.arrow_forward, color: Get.theme.canvasColor),
            ),
          ],
        ),
      ),
    );
  }
}
