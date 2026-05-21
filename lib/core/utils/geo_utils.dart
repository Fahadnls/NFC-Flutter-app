import 'dart:math';

import '../../domain/entities/geo_point.dart';

class GeoUtils {
  static double haversineKm(GeoPoint start, GeoPoint end) {
    const radius = 6371.0;
    final dLat = _degToRad(end.latitude - start.latitude);
    final dLng = _degToRad(end.longitude - start.longitude);
    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(start.latitude)) *
            cos(_degToRad(end.latitude)) *
            sin(dLng / 2) *
            sin(dLng / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return radius * c;
  }

  static GeoPoint interpolate(GeoPoint start, GeoPoint end, double fraction) {
    final safeFraction = fraction.clamp(0, 1);
    return GeoPoint(
      latitude: start.latitude + (end.latitude - start.latitude) * safeFraction,
      longitude:
          start.longitude + (end.longitude - start.longitude) * safeFraction,
    );
  }

  static double _degToRad(double value) => value * pi / 180;
}
