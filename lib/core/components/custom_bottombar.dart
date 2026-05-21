import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/consts.dart';

Widget customBottomBar({
  required Widget widget,
  double? padding,
  Color? backgroundColor,
  bool? isBorder,
}) {
  var theme = Get.theme;

  return Container(
    padding: EdgeInsets.all(padding ?? kPadding),
    decoration: BoxDecoration(
      color: backgroundColor ?? Get.theme.scaffoldBackgroundColor,
      border: isBorder ?? false
          ? Border(top: BorderSide(color: theme.splashColor))
          : null,
    ),
    child: SafeArea(
      child: Column(mainAxisSize: MainAxisSize.min, children: [widget]),
    ),
  );
}
