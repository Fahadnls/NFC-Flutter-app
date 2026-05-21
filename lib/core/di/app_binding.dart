import 'package:get/get.dart';

import 'dependency_injection.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(
    //   () => ProfileController(
    //     preferencesRepository: sl(),
    //     tripHistoryRepository: sl(),
    //   ),
    //   fenix: true,
    // );
  }
}
