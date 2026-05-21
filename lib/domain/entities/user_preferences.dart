enum PrayerMethodOption { karachi, muslimWorldLeague, ummAlQura, northAmerica }

enum MapAppChoice { googleMaps, appleMaps, waze }

enum DetourTolerance { low, medium, high }

extension DetourToleranceX on DetourTolerance {
  int get maxDetourMinutes {
    switch (this) {
      case DetourTolerance.low:
        return 10;
      case DetourTolerance.medium:
        return 20;
      case DetourTolerance.high:
        return 35;
    }
  }
}

class UserPreferences {
  const UserPreferences({
    required this.madhab,
    required this.prayerMethod,
    required this.detourTolerance,
    required this.defaultMapApp,
  });

  final String madhab;
  final PrayerMethodOption prayerMethod;
  final DetourTolerance detourTolerance;
  final MapAppChoice defaultMapApp;

  factory UserPreferences.defaults() {
    return const UserPreferences(
      madhab: 'hanafi',
      prayerMethod: PrayerMethodOption.karachi,
      detourTolerance: DetourTolerance.medium,
      defaultMapApp: MapAppChoice.googleMaps,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'madhab': madhab,
      'prayerMethod': prayerMethod.name,
      'detourTolerance': detourTolerance.name,
      'defaultMapApp': defaultMapApp.name,
    };
  }

  factory UserPreferences.fromJson(Map<String, dynamic> json) {
    return UserPreferences(
      madhab: json['madhab'] as String? ?? 'hanafi',
      prayerMethod: PrayerMethodOption.values.firstWhere(
        (value) => value.name == json['prayerMethod'],
        orElse: () => PrayerMethodOption.karachi,
      ),
      detourTolerance: DetourTolerance.values.firstWhere(
        (value) => value.name == json['detourTolerance'],
        orElse: () => DetourTolerance.medium,
      ),
      defaultMapApp: MapAppChoice.values.firstWhere(
        (value) => value.name == json['defaultMapApp'],
        orElse: () => MapAppChoice.googleMaps,
      ),
    );
  }
}
