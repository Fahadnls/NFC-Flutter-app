import 'package:get/get.dart';

import '../../core/translations/strings_enum.dart';

abstract class Failure {
  final String message;
  final int? statusCode;
  final bool shouldShowMessage;

  const Failure({
    required this.message,
    this.statusCode,
    this.shouldShowMessage = true,
  });

  factory Failure.serverFailure({
    String? message,
    int? statusCode,
    bool shouldShowMessage = true,
  }) {
    return ServerFailure(
      message: message ?? Strings.something_went_wrong.tr,
      statusCode: statusCode,
      shouldShowMessage: shouldShowMessage,
    );
  }

  factory Failure.otherFailure({
    String? message,
    int? statusCode,
    bool shouldShowMessage = true,
  }) {
    return OtherFailure(
      message: message ?? Strings.something_wents_wrong.tr,
      statusCode: statusCode,
      shouldShowMessage: shouldShowMessage,
    );
  }

  @override
  String toString() => 'Failure(message: $message, statusCode: $statusCode)';
}

class ServerFailure extends Failure {
  ServerFailure({String? message, super.statusCode, super.shouldShowMessage})
    : super(message: message ?? Strings.something_went_wrong.tr);
}

class OtherFailure extends Failure {
  OtherFailure({String? message, super.statusCode, super.shouldShowMessage})
    : super(message: message ?? Strings.something_went_wrong.tr);
}
