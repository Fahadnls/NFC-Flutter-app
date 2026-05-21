import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../theme/app_colors.dart';
import '../translations/strings_enum.dart';

class RefreshLoadingHeader extends StatelessWidget {
  const RefreshLoadingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      builder: (context, mode) {
        final status = mode ?? RefreshStatus.idle;
        String text = 'Pull to refresh';
        Widget icon = Icon(Icons.arrow_downward, color: AppColors.primaryGreen);

        if (status == RefreshStatus.refreshing) {
          text = 'Refreshing';
          icon = SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.primaryGreen,
            ),
          );
        } else if (status == RefreshStatus.completed) {
          text = 'Completed';
          icon = Icon(Icons.check_circle, color: AppColors.primaryGreen);
        } else if (status == RefreshStatus.canRefresh) {
          text = 'Release to refresh';
        }

        return SizedBox(
          height: 60,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [icon, const SizedBox(width: 8), Text(text)],
            ),
          ),
        );
      },
    );
  }
}

class RefreshLoadingFooterLoadMore extends StatelessWidget {
  const RefreshLoadingFooterLoadMore({super.key});

  @override
  Widget build(BuildContext context) {
    return ClassicFooter(
      loadStyle: LoadStyle.ShowWhenLoading,
      loadingIcon: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Get.theme.primaryColor,
        ),
      ),
      loadingText: Strings.LOAD_MORE.tr,
      canLoadingText: Strings.RELEASE_TO_LOAD_MORE.tr,
      idleText: Strings.PULL_UP_TO_LOAD_MORE.tr,
      noDataText: Strings.NO_MORE_DATA.tr,
    );
  }
}
