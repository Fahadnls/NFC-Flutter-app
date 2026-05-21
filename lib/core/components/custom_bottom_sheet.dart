// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../translations/localization_service.dart';
import '../translations/strings_enum.dart';
import '../utils/consts.dart';
import '../utils/spaces.dart';
import 'custom_buttons.dart';

void changeLanguage() {
  openCustomBottomSheet([
    {
      "text": Strings.english.tr,
      "textColor": Get.locale.toString() == "en_US"
          ? AppColors.primaryColor
          : AppColors.black,
      "onTap": () async {
        if (Get.isBottomSheetOpen!) Get.back();
        // if (MySharedPref.getUserData()?.language == 'en') return;
        // await updateLanguage('en');
        LocalizationService.updateLanguage('en');
      },
      "check": Get.locale.toString() == "en_US",
    },
    {
      "text": Strings.arabic.tr,
      "textColor": Get.locale.toString() == "ar_AR"
          ? AppColors.primaryColor
          : AppColors.black,
      "onTap": () async {
        if (Get.isBottomSheetOpen!) Get.back();
        // if (MySharedPref.getUserData()?.language == 'es') return;
        // await updateLanguage('es');
        LocalizationService.updateLanguage('ar');
      },
      "check": Get.locale.toString() == "ar_AR",
    },
  ], true);
}

// updateLanguage(language) {
//   int passengerId = MySharedPref.getUserId();
//   if (passengerId == 0) return;

//   showLoadingOverLay(
//     msg: Strings.loading.tr,
//     asyncFunction: () async {
//       var data = {
//         "passengerId": passengerId,
//         "language": language,
//       };
//       return BaseClient.safeApiCall(
//         UserService.updateLanguage,
//         RequestType.patch,
//         data: data,
//         onSuccess: (resp) {
//           var response = userFromJson(resp.data["user"]);
//           MySharedPref.setUserData(response);
//         },
//       );
//     },
//   );
// }

void openCustomBottomSheet(List<Map<String, dynamic>> list, bool isLang) {
  Get.bottomSheet(
    isLang
        ? CustomBottomSheetForChangeLang(list: list)
        : CustomBottomSheetForProfile(list: list),
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(kBorderRadius),
        topRight: Radius.circular(kBorderRadius),
      ),
    ),
  );
}

void showCustomBottomSheet({
  required BuildContext context,
  bool? isDismissible,
  bool? isBack,
  bool? isCancel,
  String? title,
  String? subTitle,
  double? height,
  double? padding,
  Function()? onTap,
  Widget? trailingWidget,
  required List<Widget> listOfItem,
}) {
  Theme.of(context);

  Get.bottomSheet(
    SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: kPadding,
          vertical: kPadding * 2,
        ), // 👈 Add margin here
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(kBorderRadius)),
        ),
        child: CustomBottomSheet(
          title: title,
          subTitle: subTitle,
          isBack: isBack ?? true,
          list: listOfItem,
          height: height ?? Get.height * 0.9,
          padding: padding,
          onTap: onTap,
          trailingWidget: trailingWidget,
        ),
      ),
    ),
    isDismissible: isDismissible ?? true,
    ignoreSafeArea: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent, // 👈 Important: make bg transparent
  );
}

class CustomBottomSheet extends StatelessWidget {
  CustomBottomSheet({
    super.key,
    this.title,
    this.subTitle,
    this.padding,
    required this.height,
    required this.list,
    this.onTap,
    this.isBack,
    this.isCancel,
    this.trailingWidget,
  });

  String? title;
  String? subTitle;
  double? padding;
  bool? isBack;
  bool? isCancel;
  double height;
  Widget? trailingWidget;
  List<Widget> list;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, kPadding / 2, 0, kBottomPadding(context)),
      constraints: BoxConstraints(maxHeight: height),
      // height: height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (title != null && isBack != false && isCancel != false)
              Center(
                child: Container(
                  width: Get.width / 3,
                  color: Colors.white,
                  height: 5,
                ),
              ),
            if (title != null && isBack != false && isCancel != false)
              const SpaceH12(),
            if (title != null && isBack != false && isCancel != false)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isBack ?? true)
                      CustomIconButton(
                        isSmall: true,
                        iconData: Icons.chevron_left_outlined,
                        backgroundColor: AppColors.greyBtn,
                        color: AppColors.primaryBlackColor,
                        onTap: () {
                          if (onTap == null) {
                            if (Get.isBottomSheetOpen ?? false) Get.back();
                          }
                          onTap?.call();
                        },
                      ),
                    Expanded(
                      child: Center(
                        child: Text(
                          title ?? "",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                              ),
                        ),
                      ),
                    ),
                    if (isCancel ?? false)
                      CustomIconButton(
                        isSmall: true,
                        iconData: Icons.close_outlined,
                        backgroundColor: AppColors.greyBtn,
                        color: AppColors.primaryBlackColor,
                        onTap: () {
                          if (onTap == null) {
                            if (Get.isBottomSheetOpen ?? false) Get.back();
                          }
                          onTap?.call();
                        },
                      ),
                    //  trailingWidget ??
                    // const SizedBox(
                    //   width: 45,
                    //   height: 15,
                    // )
                  ],
                ),
              ),
            if (title != null && isBack != false && isCancel != false)
              const SpaceH8(),
            // for (int index = 0; index < list.length; index++)
            // Divider(
            //   height: 1,
            //   color: Get.theme.dividerColor.withOpacity(.5),
            // ),
            Padding(
              padding: EdgeInsets.all(padding ?? 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: list,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBottomSheetForChangeLang extends StatelessWidget {
  CustomBottomSheetForChangeLang({super.key, required this.list});

  final List<Map<String, dynamic>> list;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.fromLTRB(
        0,
        kPadding,
        0,
        kBottomPadding(context) + kPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    Strings.LANGUAGE.tr,
                    style: Get.textTheme.bodyLarge,
                  ),
                ),
                CustomIconButton(
                  isSmall: true,
                  iconData: Icons.close,
                  color: AppColors.primaryTextColor,
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          for (var item in list)
            InkWell(
              onTap: item["onTap"],
              borderRadius: BorderRadius.circular(kBorderRadius),
              overlayColor: WidgetStateProperty.all(
                theme.primaryColor.withValues(alpha: .1),
              ),
              splashColor: theme.primaryColor.withValues(alpha: .1),
              focusColor: theme.primaryColor.withValues(alpha: .1),
              highlightColor: theme.primaryColor.withValues(alpha: .1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding / 2),
                child: Row(
                  children: [
                    Checkbox(
                      value: item["check"],
                      onChanged: null,
                      fillColor: item["check"] == true
                          ? WidgetStateProperty.all(Get.theme.primaryColor)
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item["text"],
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: item["textColor"],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CustomBottomSheetForProfile extends StatelessWidget {
  CustomBottomSheetForProfile({super.key, required this.list});

  final List<Map<String, dynamic>> list;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.fromLTRB(
        kPadding / 3,
        kPadding,
        kPadding / 3,
        kBottomPadding(context),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var item in list)
            InkWell(
              onTap: item["onTap"],
              borderRadius: BorderRadius.circular(kBorderRadius),
              overlayColor: WidgetStateProperty.all(
                theme.primaryColor.withValues(alpha: .1),
              ),
              splashColor: theme.primaryColor.withValues(alpha: .1),
              focusColor: theme.primaryColor.withValues(alpha: .1),
              highlightColor: theme.primaryColor.withValues(alpha: .1),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: kPadding,
                  horizontal: kPadding / 3,
                ),
                child: Row(
                  children: [
                    CustomIconButton(
                      iconData: item["icon"],
                      isRounded: true,
                      color: (item["textColor"] as Color),
                      backgroundColor: (item["textColor"] as Color).withValues(
                        alpha: .1,
                      ),
                      showShadow: false,
                    ),
                    // Icon(
                    //   ,
                    //   ,
                    // ),
                    const SpaceW16(),
                    Text(
                      item["text"],
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge!.copyWith(color: item["textColor"]),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// ============================================================
/// Custom Draggable BottomSheet
/// ============================================================

Widget customDraggableBottomSheet(Widget header, Widget body) {
  return DraggableScrollableSheet(
    initialChildSize: .075,
    minChildSize: .075,
    maxChildSize: .6,

    // expand: true,
    builder: (BuildContext context, ScrollController scrollController) {
      return SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            header,
            const Divider(height: 1),
            Container(color: Get.theme.cardColor, child: body),
          ],
        ),
      );
    },
  );
}
