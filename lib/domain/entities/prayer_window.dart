import 'geo_point.dart';

enum PrayerType { fajr, dhuhr, asr, maghrib, isha }

extension PrayerTypeX on PrayerType {
  String get label {
    switch (this) {
      case PrayerType.fajr:
        return 'Fajr';
      case PrayerType.dhuhr:
        return 'Dhuhr';
      case PrayerType.asr:
        return 'Asr';
      case PrayerType.maghrib:
        return 'Maghrib';
      case PrayerType.isha:
        return 'Isha';
    }
  }

  String displayLabelFor(DateTime date) {
    // if (this == PrayerType.dhuhr && date.weekday == DateTime.friday) {
    //   return 'Jumma';
    // }
    return label;
  }
}

class PrayerWindow {
  const PrayerWindow({
    required this.prayer,
    required this.startTime,
    required this.endTime,
    required this.safeStartTime,
    required this.safeEndTime,
    required this.projectedPosition,
    required this.arrivalOffsetMinutes,
  });

  final PrayerType prayer;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime safeStartTime;
  final DateTime safeEndTime;
  final GeoPoint projectedPosition;
  final int arrivalOffsetMinutes;

  String get displayLabel => prayer.displayLabelFor(startTime);

  Map<String, dynamic> toJson() {
    return {
      'prayer': prayer.name,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'safeStartTime': safeStartTime.toIso8601String(),
      'safeEndTime': safeEndTime.toIso8601String(),
      'projectedPosition': projectedPosition.toJson(),
      'arrivalOffsetMinutes': arrivalOffsetMinutes,
    };
  }

  factory PrayerWindow.fromJson(Map<String, dynamic> json) {
    return PrayerWindow(
      prayer: PrayerType.values.firstWhere(
        (value) => value.name == json['prayer'],
        orElse: () => PrayerType.dhuhr,
      ),
      startTime:
          DateTime.tryParse(json['startTime'] as String? ?? '') ??
          DateTime.now(),
      endTime:
          DateTime.tryParse(json['endTime'] as String? ?? '') ?? DateTime.now(),
      safeStartTime:
          DateTime.tryParse(json['safeStartTime'] as String? ?? '') ??
          DateTime.tryParse(json['startTime'] as String? ?? '') ??
          DateTime.now(),
      safeEndTime:
          DateTime.tryParse(json['safeEndTime'] as String? ?? '') ??
          DateTime.tryParse(json['endTime'] as String? ?? '') ??
          DateTime.now(),
      projectedPosition: GeoPoint.fromJson(
        json['projectedPosition'] as Map<String, dynamic>? ?? {},
      ),
      arrivalOffsetMinutes: json['arrivalOffsetMinutes'] as int? ?? 0,
    );
  }
}
