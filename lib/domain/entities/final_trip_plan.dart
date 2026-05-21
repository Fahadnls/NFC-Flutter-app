import 'mosque_stop_suggestion.dart';
import 'prayer_window.dart';
import 'trip_route.dart';

class FinalTripPlan {
  const FinalTripPlan({
    required this.route,
    required this.stops,
    required this.totalDurationMinutes,
  });

  final TripRoute route;
  final List<SelectedTripStop> stops;
  final int totalDurationMinutes;

  Map<String, dynamic> toJson() {
    return {
      'route': route.toJson(),
      'stops': stops.map((item) => item.toJson()).toList(),
      'totalDurationMinutes': totalDurationMinutes,
    };
  }

  factory FinalTripPlan.fromJson(Map<String, dynamic> json) {
    final rawStops = json['stops'] as List? ?? <dynamic>[];
    return FinalTripPlan(
      route: TripRoute.fromJson(json['route'] as Map<String, dynamic>? ?? {}),
      stops: rawStops
          .map(
            (item) => SelectedTripStop.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
      totalDurationMinutes: json['totalDurationMinutes'] as int? ?? 0,
    );
  }
}

class SelectedTripStop {
  const SelectedTripStop({
    required this.prayer,
    required this.suggestion,
    required this.scheduledArrival,
  });

  final PrayerType prayer;
  final MosqueStopSuggestion suggestion;
  final DateTime scheduledArrival;

  Map<String, dynamic> toJson() {
    return {
      'prayer': prayer.name,
      'suggestion': suggestion.toJson(),
      'scheduledArrival': scheduledArrival.toIso8601String(),
    };
  }

  factory SelectedTripStop.fromJson(Map<String, dynamic> json) {
    return SelectedTripStop(
      prayer: PrayerType.values.firstWhere(
        (value) => value.name == json['prayer'],
        orElse: () => PrayerType.dhuhr,
      ),
      suggestion: MosqueStopSuggestion.fromJson(
        json['suggestion'] as Map<String, dynamic>? ?? {},
      ),
      scheduledArrival:
          DateTime.tryParse(json['scheduledArrival'] as String? ?? '') ??
          DateTime.now(),
    );
  }
}
