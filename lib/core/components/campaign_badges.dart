import 'package:flutter/material.dart';

class CampaignBadgeData {
  const CampaignBadgeData({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
}

class CampaignBadges extends StatelessWidget {
  const CampaignBadges({
    super.key,
    required this.badges,
    this.spacing = 6,
    this.runSpacing = 6,
  });

  final List<CampaignBadgeData> badges;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    if (badges.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: badges
          .map(
            (badge) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: badge.backgroundColor,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                badge.label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: badge.foregroundColor,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
