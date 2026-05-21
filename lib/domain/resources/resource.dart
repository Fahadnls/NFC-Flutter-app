import 'package:get/get.dart';

import '../../core/translations/strings_enum.dart';

class Resource<T> {
  final T? data;
  final String? message;
  final ResourceState state;

  const Resource._({this.data, this.message, required this.state});

  factory Resource.initial() => const Resource._(state: ResourceState.initial);

  factory Resource.loading({T? data}) =>
      Resource._(state: ResourceState.loading, data: data);

  factory Resource.success({required T data}) =>
      Resource._(state: ResourceState.success, data: data);

  factory Resource.error({String? message}) => Resource._(
    state: ResourceState.error,
    message: message ?? Strings.something_went_wrong.tr,
  );

  @override
  String toString() =>
      'Resource(state: $state, data: $data, message: $message)';
}

enum ResourceState { initial, loading, success, error }
