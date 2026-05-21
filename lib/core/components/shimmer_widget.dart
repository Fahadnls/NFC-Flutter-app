import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmer(
  BuildContext context, {
  double? height,
  double? width,
  Color? baseColor,
  Color? highlightColor,
  double? borderRadius,
}) {
  return Shimmer.fromColors(
    baseColor: baseColor ?? Colors.grey.withValues(alpha: 0.4),
    highlightColor: highlightColor ?? Colors.grey[100]!,
    child: Container(
      height: height ?? Get.height * .046,
      width: width ?? Get.width * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius ?? 20),
      ),
    ),
  );
}

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildShimmer(
          context,
          height: 150,
          width: double.infinity,
          borderRadius: 16,
        ),
        const Gap(12),
        buildShimmer(
          context,
          height: 36,
          width: double.infinity,
          borderRadius: 20,
        ),
        const Gap(12),
        SizedBox(
          height: 240,
          child: Row(
            children: [
              Expanded(
                child: buildShimmer(context, height: 230, borderRadius: 16),
              ),
              const Gap(10),
              Expanded(
                child: buildShimmer(context, height: 230, borderRadius: 16),
              ),
            ],
          ),
        ),
        const Gap(12),
        buildShimmer(context, height: 30, width: 180, borderRadius: 12),
        const Gap(10),
        SizedBox(
          height: 52,
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (_, _) => const Gap(10),
            itemBuilder: (_, _) =>
                buildShimmer(context, height: 52, width: 110, borderRadius: 24),
          ),
        ),
      ],
    );
  }
}

class ProductDetailShimmer extends StatelessWidget {
  const ProductDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildShimmer(
            context,
            height: Get.height * (Get.width >= 700 ? 0.34 : 0.29),
            width: double.infinity,
            borderRadius: 16,
          ),
          const Gap(14),
          buildShimmer(context, height: 18, width: 130, borderRadius: 8),
          const Gap(8),
          buildShimmer(context, height: 24, width: 220, borderRadius: 8),
          const Gap(10),
          buildShimmer(context, height: 18, width: 160, borderRadius: 8),
          const Gap(12),
          buildShimmer(
            context,
            height: 36,
            width: double.infinity,
            borderRadius: 10,
          ),
          const Gap(10),
          buildShimmer(
            context,
            height: 120,
            width: double.infinity,
            borderRadius: 12,
          ),
          const Gap(10),
          SizedBox(
            height: 240,
            child: Row(
              children: [
                Expanded(
                  child: buildShimmer(context, height: 230, borderRadius: 16),
                ),
                const Gap(10),
                Expanded(
                  child: buildShimmer(context, height: 230, borderRadius: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
