import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';

import '../../core/components/custom_loading.dart';
import '../../domain/errors/failure.dart';

Future<void> handleResourceCall<T>({
  required Future<Either<Failure, T>> Function() asyncCall,
  required void Function(T data) onSuccess,
  void Function(String message)? onError,
  void Function(String message)? onLoading,
}) async {
  onLoading?.call('Loading...');
  if (onLoading == null) Loaders.showEasyLoading();
  final result = await asyncCall();

  EasyLoading.dismiss();

  result.fold((failure) {
    if (!failure.shouldShowMessage) {
      return;
    }

    final errorMsg = failure.message;
    if (onError != null) {
      onError(errorMsg);
    } else {
      Get.snackbar('Error', errorMsg);
    }
  }, (data) => onSuccess(data));
}
