// import 'package:awesome_select/awesome_select.dart';
// import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:icons_plus/icons_plus.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../utils/consts.dart';

/// ================================================================
/// Custom Input
/// ================================================================

enum InputDecorationType { outlined, underlined }

class CustomInput extends StatefulWidget {
  const CustomInput({
    super.key,
    this.icon,
    this.iconBackground,
    this.iconColor,
    this.isObscure = false,
    this.title,
    this.hint,
    this.hintColor,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.controller,
    this.formValidator,
    this.isEnabled = true,
    this.minLines = 1,
    this.maxLines,
    this.onTap,
    this.autoFocus = false,
    this.isUpperTitle = false,
    this.backgroundColor,
    this.onChange,
    this.suffixIcon,
    this.maxLength,
    this.readOnly = false,
    this.inputFormatters,
    this.borderColor,
    this.isBoldHint,
    this.contentPadding,
    this.borderRadius,
    this.margin = const EdgeInsets.symmetric(vertical: 10),
    this.onSubmitted,
  });

  final IconData? icon;
  final Color? iconBackground;
  final bool? isBoldHint;
  final Color? borderColor;
  final Color? iconColor;
  final bool isObscure;

  final String? title;
  final String? hint;
  final Color? hintColor;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final FormFieldValidator<String>? formValidator;
  final bool isEnabled;
  final bool autoFocus;
  final bool isUpperTitle;
  final int minLines;
  final int? maxLines;
  final int? maxLength;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChange;
  final Color? backgroundColor;
  final Widget? suffixIcon;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;
  final EdgeInsetsGeometry margin;
  final ValueChanged<String>? onSubmitted;

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool isPasswordShow = true;

  void showOrHidePassword() => setState(() => isPasswordShow = !isPasswordShow);

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;

    return Padding(
      padding: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title?.isNotEmpty ?? false)
            if (widget.isUpperTitle)
              Text(
                widget.title.toString(),
                textAlign: TextAlign.left,
                style: theme.textTheme.bodyMedium?.copyWith(),
              ),
          if (widget.title?.isNotEmpty ?? false)
            if (widget.isUpperTitle) const Gap(4),
          TextFormField(
            inputFormatters: widget.inputFormatters,
            readOnly: widget.readOnly,
            onChanged: widget.onChange,

            onFieldSubmitted: widget.onSubmitted,
            maxLength: widget.maxLength,
            autofocus: widget.autoFocus,
            onTap: widget.onTap,
            minLines: widget.isObscure ? 1 : widget.minLines,
            maxLines: widget.isObscure
                ? 1
                : widget.minLines == 1
                ? 1
                : widget.maxLines ?? widget.minLines + 1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.formValidator,
            controller: widget.controller,
            keyboardType: (widget.textInputAction == TextInputAction.newline
                ? TextInputType.multiline
                : widget.textInputType),
            textInputAction: widget.textInputAction,
            cursorColor: theme.colorScheme.primary,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            obscureText: widget.isObscure ? isPasswordShow : false,
            enabled: widget.isEnabled,
            decoration: customInputDecoration(
              titleColor: theme.colorScheme.onSurface,
              isBoldHint: widget.isBoldHint,
              borderColor: widget.borderColor,
              iconBackground: widget.iconBackground,
              readOnly: widget.readOnly,
              backgroundColor: widget.backgroundColor,
              hint: widget.hint,
              hintColor: widget.hintColor ?? theme.hintColor,
              icon: widget.icon,
              iconColor: widget.iconColor ?? theme.iconTheme.color,
              borderRadius: widget.borderRadius,
              contentPadding: widget.contentPadding,
              suffixIcon:
                  widget.suffixIcon ??
                  (widget.isObscure
                      ? IconButton(
                          splashRadius: 25,
                          onPressed: showOrHidePassword,
                          icon: Icon(
                            isPasswordShow
                                ? EvaIcons.eye_outline
                                : EvaIcons.eye_off_outline,
                            color: theme.iconTheme.color ?? theme.disabledColor,
                          ),
                        )
                      : null),
              title: widget.isUpperTitle ? null : widget.title,
            ),
          ),
        ],
      ),
    );
  }
}

/// ================================================================
/// Phone Input
/// ================================================================

class CustomPhoneInput extends StatefulWidget {
  const CustomPhoneInput({
    super.key,
    this.controller,
    required this.onCountryChange,
    this.formValidator,
    this.autoFocus,
    this.isRead = true,
    this.initialCountryCode,
    this.borderColor,
    this.isUpperTitle = true,
    this.textInputAction = TextInputAction.done,
  });
  final TextEditingController? controller;
  final FormFieldValidator<String>? formValidator;
  final ValueChanged<Country>? onCountryChange;
  final String? initialCountryCode;
  final bool? isRead;

  final bool? autoFocus;
  final Color? borderColor;
  final bool? isUpperTitle;
  final TextInputAction textInputAction;

  @override
  State<CustomPhoneInput> createState() => _CustomPhoneInputState();
}

class _CustomPhoneInputState extends State<CustomPhoneInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isUpperTitle == true)
          Text(
            'Phone number'.tr,
            textAlign: TextAlign.left,
            style: Get.theme.textTheme.bodyMedium?.copyWith(),
          ),
        if (widget.isUpperTitle == true) const Gap(4),
        IntlPhoneField(
          validator: (value) {
            return null;
          },
          countries: [
            Country(
              name: "Kuwait",
              nameTranslations: {
                "sk": "Kuvajt",
                "se": "Kuwait",
                "pl": "Kuwejt",
                "no": "Kuwait",
                "ja": "クウェート",
                "it": "Kuwait",
                "zh": "科威特",
                "nl": "Koeweit",
                "de": "Kuwait",
                "fr": "Koweït",
                "es": "Kuwait",
                "en": "Kuwait",
                "pt_BR": "Kuwait",
                "sr-Cyrl": "Кувајт",
                "sr-Latn": "Kuvajt",
                "zh_TW": "科威特",
                "tr": "Kuveyt",
                "ro": "Kuweit",
                "ar": "الكويت",
                "fa": "کویت",
                "yue": "科威特",
              },
              flag: "🇰🇼",
              code: "KW",
              dialCode: "965",
              minLength: 8,
              maxLength: 8,
            ),
            if (kDebugMode)
              Country(
                name: "Pakistan",
                nameTranslations: {
                  "sk": "Pakistan",
                  "se": "Pakistan",
                  "pl": "Pakistan",
                  "no": "Pakistan",
                  "ja": "パキスタン",
                  "it": "Pakistan",
                  "zh": "巴基斯坦",
                  "nl": "Pakistan",
                  "de": "Pakistan",
                  "fr": "Pakistan",
                  "es": "Pakistán",
                  "en": "Pakistan",
                  "pt_BR": "Paquistão",
                  "sr-Cyrl": "Пакистан",
                  "sr-Latn": "Pakistan",
                  "zh_TW": "巴基斯坦",
                  "tr": "Pakistan",
                  "ro": "Pakistan",
                  "ar": "باكستان",
                  "fa": "پاکستان",
                  "yue": "巴基斯坦",
                },
                flag: "🇵🇰",
                code: "PK",
                dialCode: "92",
                minLength: 10,
                maxLength: 10,
              ),
          ],
          onCountryChanged: widget.onCountryChange,
          autofocus: widget.autoFocus ?? false,
          controller: widget.controller,
          flagsButtonPadding: const EdgeInsets.only(left: 5),
          dropdownIconPosition: IconPosition.trailing,
          cursorColor: Get.theme.disabledColor,
          keyboardType: TextInputType.phone,
          textInputAction: widget.textInputAction,
          initialValue: "",
          languageCode: Get.locale.toString() == "en_US" ? 'en' : 'es',
          pickerDialogStyle: PickerDialogStyle(
            countryNameStyle: const TextStyle(),
            countryCodeStyle: const TextStyle(
              debugLabel: AutofillHints.countryCode,
              leadingDistribution: TextLeadingDistribution.proportional,
              // locale: Locale('ar', 'SA')
            ),
            searchFieldInputDecoration: customInputDecoration(
              hint: 'Search country'.tr,
            ),
          ),
          dropdownIcon: const Icon(
            EvaIcons.arrow_ios_downward_outline,
            size: 18,
          ),
          initialCountryCode: widget.initialCountryCode ?? initialCountry,
          decoration: customInputDecoration(
            hint: 'Phone number'.tr,
            suffixIcon: null,
          ),
          enabled: widget.isRead ?? true,
        ),
      ],
    );
  }
}

/// ================================================================
/// Verification Input
/// ================================================================

class CustomVerificationInput extends StatelessWidget {
  const CustomVerificationInput({
    super.key,
    required this.onSubmitted,
    this.onChange,
    this.textEditingController,
    this.length = 6,
    this.cellSize = const Size(42, 48),
    this.spacing = 8,
    this.autoFocus = true,
  });

  final ValueChanged<String> onSubmitted;
  final ValueChanged<String>? onChange;
  final TextEditingController? textEditingController;
  final int length;
  final Size cellSize;
  final double spacing;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    return Center(
      child: MaterialPinField(
        length: length,
        initialValue: textEditingController?.text,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        autoDismissKeyboard: true,
        autoFocus: autoFocus,
        onChanged: (value) {
          if (textEditingController != null &&
              textEditingController!.text != value) {
            textEditingController!.text = value;
            textEditingController!.selection = TextSelection.collapsed(
              offset: value.length,
            );
          }
          onChange?.call(value);
        },
        onCompleted: onSubmitted,
        onSubmitted: onSubmitted,
        theme: MaterialPinTheme(
          shape: MaterialPinShape.outlined,
          cellSize: cellSize,
          spacing: spacing,
          borderRadius: BorderRadius.circular(14),
          borderColor: theme.dividerColor,
          focusedBorderColor: theme.colorScheme.primary,
          filledBorderColor: theme.colorScheme.primary,
          fillColor: theme.colorScheme.surface,
          focusedFillColor: theme.colorScheme.surface,
          filledFillColor: theme.colorScheme.surface,
          textStyle: theme.textTheme.titleMedium,
          cursorColor: theme.colorScheme.primary,
          entryAnimation: MaterialPinAnimation.scale,
          hintCharacter: ' ',
          hintStyle: theme.textTheme.titleMedium?.copyWith(
            color: theme.disabledColor,
          ),
        ),
      ),
    );
  }
}

/// ================================================================
/// Custom Input Decoration
/// ================================================================

InputDecoration customInputDecoration({
  Color? backgroundColor,
  IconData? icon,
  Color? iconBackground,
  Color? iconColor,
  Widget? suffixIcon,
  String? title,
  String? hint,
  Color? hintColor,
  bool? readOnly,
  bool? isBoldHint,
  Color? borderColor,
  Color? titleColor,
  EdgeInsetsGeometry? contentPadding,
  double? borderRadius,
}) {
  var theme = Get.theme;
  final radius = BorderRadius.circular(borderRadius ?? kBorderRadius);
  final isDark = theme.brightness == Brightness.dark;
  final resolvedBorderColor =
      borderColor ??
      (isDark
          ? theme.colorScheme.onSurface.withValues(alpha: 0.22)
          : theme.dividerColor);
  final resolvedFillColor =
      backgroundColor ??
      (isDark
          ? theme.colorScheme.onSurface.withValues(alpha: 0.06)
          : theme.colorScheme.surface);
  final resolvedHintColor =
      hintColor ??
      theme.colorScheme.onSurface.withValues(alpha: isDark ? 0.62 : 0.5);
  final resolvedIconColor =
      iconColor ??
      theme.colorScheme.onSurface.withValues(alpha: isDark ? 0.8 : 0.65);

  return InputDecoration(
    counterText: "",
    errorMaxLines: 3,
    fillColor: resolvedFillColor,
    contentPadding: contentPadding ?? const EdgeInsets.all(kPadding / 2),
    prefixIcon: icon == null
        ? null
        : Container(
            margin: const EdgeInsets.only(right: 3),
            decoration: BoxDecoration(
              color: iconBackground,
              // color: iconBackground ??
              //     iconColor?.withOpacity(.2) ??
              //     Get.theme.primaryColor.withOpacity(.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(kBorderRadius),
                bottomLeft: Radius.circular(kBorderRadius),
              ),
            ),
            child: Icon(icon, color: resolvedIconColor),
          ),
    // label: widget.title == null ? null : Text(widget.title ?? ""),
    suffixIcon: suffixIcon,
    labelStyle: TextStyle(
      color: titleColor ?? theme.colorScheme.onSurface.withValues(alpha: 0.72),
    ),
    floatingLabelStyle: TextStyle(color: theme.primaryColor),
    labelText: title,
    hintText: hint,
    alignLabelWithHint: true,
    hintStyle: theme.textTheme.bodySmall!.copyWith(
      color: resolvedHintColor,
      fontWeight: isBoldHint == true ? FontWeight.bold : null,
    ),
    filled: true,
    border: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: resolvedBorderColor, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(color: resolvedBorderColor, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(
        color: readOnly == true ? resolvedBorderColor : theme.primaryColor,
        width: 1,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: radius,
      borderSide: BorderSide(
        color: resolvedBorderColor.withValues(alpha: 0.75),
        width: 1,
      ),
    ),
    //  UnderlineInputBorder(
    //   borderSide: BorderSide(
    //     color: AppColors.greyBackground,
    //   ),
    // ),
  );
}
