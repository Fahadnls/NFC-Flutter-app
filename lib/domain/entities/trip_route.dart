import 'geo_point.dart';

class TripRoute {
  const TripRoute({
    required this.distanceKm,
    required this.durationMinutes,
    required this.polyline,
    required this.legs,
    required this.departureTime,
  });

  final double distanceKm;
  final int durationMinutes;
  final List<GeoPoint> polyline;
  final List<TripLeg> legs;
  final DateTime departureTime;

  Map<String, dynamic> toJson() {
    return {
      'distanceKm': distanceKm,
      'durationMinutes': durationMinutes,
      'polyline': polyline.map((point) => point.toJson()).toList(),
      'legs': legs.map((leg) => leg.toJson()).toList(),
      'departureTime': departureTime.toIso8601String(),
    };
  }

  factory TripRoute.fromJson(Map<String, dynamic> json) {
    final polylineData = json['polyline'] as List? ?? <dynamic>[];
    final legsData = json['legs'] as List? ?? <dynamic>[];
    return TripRoute(
      distanceKm: (json['distanceKm'] as num?)?.toDouble() ?? 0,
      durationMinutes: json['durationMinutes'] as int? ?? 0,
      polyline: polylineData
          .map((item) => GeoPoint.fromJson(item as Map<String, dynamic>))
          .toList(),
      legs: legsData
          .map((item) => TripLeg.fromJson(item as Map<String, dynamic>))
          .toList(),
      departureTime:
          DateTime.tryParse(json['departureTime'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}

class TripLeg {
  const TripLeg({
    required this.start,
    required this.end,
    required this.distanceKm,
    required this.durationMinutes,
  });

  final GeoPoint start;
  final GeoPoint end;
  final double distanceKm;
  final int durationMinutes;

  Map<String, dynamic> toJson() {
    return {
      'start': start.toJson(),
      'end': end.toJson(),
      'distanceKm': distanceKm,
      'durationMinutes': durationMinutes,
    };
  }

  factory TripLeg.fromJson(Map<String, dynamic> json) {
    return TripLeg(
      start: GeoPoint.fromJson(json['start'] as Map<String, dynamic>? ?? {}),
      end: GeoPoint.fromJson(json['end'] as Map<String, dynamic>? ?? {}),
      distanceKm: (json['distanceKm'] as num?)?.toDouble() ?? 0,
      durationMinutes: json['durationMinutes'] as int? ?? 0,
    );
  }
}
