import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CustomEmptyWidget extends StatefulWidget {
  const CustomEmptyWidget({
    super.key,
    required this.title,
    this.subtitle = '',
    this.iconWidget,
    this.icon,
    this.titleColor,
    this.subtitleColor,
    this.backgroundColor,
    this.widget,
  });

  final String title;
  final String? subtitle;
  final Widget? iconWidget;
  final IconData? icon;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? backgroundColor;
  final Widget? widget;

  @override
  State<CustomEmptyWidget> createState() => _CustomEmptyWidgetState();
}

class _CustomEmptyWidgetState extends State<CustomEmptyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleColor = widget.titleColor ?? theme.colorScheme.onSurface;
    final subtitleColor =
        widget.subtitleColor ??
        theme.colorScheme.onSurface.withValues(alpha: 0.68);

    return Container(
      width: Get.width,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(8),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, sin(_controller.value * 2 * pi) * 8),
                child: child,
              );
            },
            child: Container(
              width: Get.width * (Get.width >= 700 ? 0.22 : 0.52),
              height: Get.width * (Get.width >= 700 ? 0.22 : 0.52),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Center(
                child:
                    widget.iconWidget ??
                    Icon(
                      widget.icon ?? Icons.remove_shopping_cart_outlined,
                      color: theme.colorScheme.primary,
                      size: Get.width >= 700 ? 72 : 56,
                    ),
              ),
            ),
          ),
          const Gap(16),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: titleColor,
            ),
          ),
          if (widget.subtitle != null && widget.subtitle!.trim().isNotEmpty)
            Column(
              children: [
                const Gap(8),
                Text(
                  widget.subtitle!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: subtitleColor),
                ),
              ],
            ),
          if (widget.widget != null) ...[const Gap(12), widget.widget!],
        ],
      ),
    );
  }
}
