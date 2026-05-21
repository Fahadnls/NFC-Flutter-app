import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loaders {
  static void showEasyLoading({String? status}) {
    EasyLoading.show(maskType: EasyLoadingMaskType.black, status: status);
  }

  static void showLoadingWithMessage() {
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
  }
}
