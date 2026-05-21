import 'geo_point.dart';
import 'prayer_window.dart';

class MosqueStopSuggestion {
  const MosqueStopSuggestion({
    required this.id,
    required this.name,
    required this.address,
    required this.point,
    required this.prayer,
    required this.detourMinutes,
    required this.routeDistanceKm,
    required this.suitabilityScore,
    required this.suitabilityLabel,
  });

  final String id;
  final String name;
  final String address;
  final GeoPoint point;
  final PrayerType prayer;
  final int detourMinutes;
  final double routeDistanceKm;
  final double suitabilityScore;
  final String suitabilityLabel;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'point': point.toJson(),
      'prayer': prayer.name,
      'detourMinutes': detourMinutes,
      'routeDistanceKm': routeDistanceKm,
      'suitabilityScore': suitabilityScore,
      'suitabilityLabel': suitabilityLabel,
    };
  }

  factory MosqueStopSuggestion.fromJson(Map<String, dynamic> json) {
    return MosqueStopSuggestion(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      point: GeoPoint.fromJson(json['point'] as Map<String, dynamic>? ?? {}),
      prayer: PrayerType.values.firstWhere(
        (value) => value.name == json['prayer'],
        orElse: () => PrayerType.dhuhr,
      ),
      detourMinutes: json['detourMinutes'] as int? ?? 0,
      routeDistanceKm: (json['routeDistanceKm'] as num?)?.toDouble() ?? 0,
      suitabilityScore: (json['suitabilityScore'] as num?)?.toDouble() ?? 0,
      suitabilityLabel: json['suitabilityLabel'] as String? ?? '',
    );
  }
}
