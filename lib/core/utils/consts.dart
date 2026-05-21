import 'package:flutter/material.dart';
import 'package:get/get.dart';

const kAppName = 'Prayer Aligned Trips';
const String defaultCurrency = '';
const String googleApiKey = '';
const bool kShowTripMaps = true;

const String defaultCountries = 'country:kw|country:pk';
const List<String> countriesList = ['kw', 'pk'];

const String initialCountry = 'KW';
const String initialCountryDialCode = '965';

const kBorderRadius = 13.0;
const kSpacing = 10.0;
const kPadding = 20.0;
const String kUseKey = 'user';
const kHorizantalPadding = 18.0;

double getBookListHeight() {
  if (Get.height < 700) return Get.height * 0.3;
  if (Get.height < 900) return Get.height * 0.34;
  return Get.height * 0.31;
}

double getChipHeight() {
  if (Get.height < 700) return Get.height * 0.4;
  if (Get.height < 900) return Get.height * 0.053;
  return Get.height * .045;
}

double kBottomPadding(BuildContext context) {
  return MediaQuery.of(context).padding.bottom;
}

double kTopPadding(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

double kRightPadding(BuildContext context) {
  return MediaQuery.of(context).padding.right;
}

double kLeftPadding(BuildContext context) {
  return MediaQuery.of(context).padding.left;
}
