import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/translations/strings_enum.dart';
import 'resource.dart';

class ResourceWidget<T> extends StatelessWidget {
  final Resource<T> resource;
  final Widget Function()? loadingBuilder;
  final Widget Function(String message)? errorBuilder;
  final Widget Function(T data) successBuilder;
  final Widget Function()? emptyBuilder;
  final bool Function(T data)? emptyCondition;

  const ResourceWidget({
    super.key,
    required this.resource,
    required this.successBuilder,
    this.loadingBuilder,
    this.errorBuilder,
    this.emptyBuilder,
    this.emptyCondition,
  });

  @override
  Widget build(BuildContext context) {
    switch (resource.state) {
      case ResourceState.loading:
        return loadingBuilder?.call() ??
            Center(child: CircularProgressIndicator());

      case ResourceState.error:
        return errorBuilder?.call(
              resource.message ?? Strings.something_wents_wrong.tr,
            ) ??
            Center(
              child: Text(resource.message ?? Strings.something_wents_wrong.tr),
            );

      case ResourceState.success:
        final data = resource.data;
        final isEmpty = emptyCondition?.call(data as T) ?? (data == null);
        if (isEmpty) {
          return emptyBuilder?.call() ??
              Center(child: Text(Strings.no_data_found.tr));
        }
        return successBuilder(data as T);

      case ResourceState.initial:
        return const SizedBox.shrink();
    }
  }
}
