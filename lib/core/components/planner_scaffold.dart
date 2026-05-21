import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/consts.dart';
import 'custom_buttons.dart';

class PlannerScaffold extends StatelessWidget {
  const PlannerScaffold({
    super.key,
    required this.title,
    required this.body,
    this.bottom,
    this.showBack = false,
  });

  final String title;
  final Widget body;
  final Widget? bottom;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: kPadding,
        title: Row(
          children: [
            if (showBack)
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: CustomIconButton(
                  onTap: Get.back,
                  isSmall: true,
                  iconData: Icons.arrow_back_ios_new_rounded,
                  backgroundColor: theme.colorScheme.surface,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.displaySmall?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(kPadding),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.transparent],
                    ),
                  ),
                  child: body,
                ),
              ),
            ),
            ...?(bottom == null ? null : <Widget>[bottom!]),
          ],
        ),
      ),
    );
  }
}
