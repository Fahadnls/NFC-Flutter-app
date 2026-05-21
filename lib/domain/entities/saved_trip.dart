import 'final_trip_plan.dart';
import 'place_location.dart';

class SavedTrip {
  const SavedTrip({
    required this.id,
    required this.origin,
    required this.destination,
    required this.createdAt,
    required this.plan,
  });

  final String id;
  final PlaceLocation origin;
  final PlaceLocation destination;
  final DateTime createdAt;
  final FinalTripPlan plan;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'origin': origin.toJson(),
      'destination': destination.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'plan': plan.toJson(),
    };
  }

  factory SavedTrip.fromJson(Map<String, dynamic> json) {
    return SavedTrip(
      id: json['id'] as String? ?? '',
      origin: PlaceLocation.fromJson(
        json['origin'] as Map<String, dynamic>? ?? {},
      ),
      destination: PlaceLocation.fromJson(
        json['destination'] as Map<String, dynamic>? ?? {},
      ),
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
      plan: FinalTripPlan.fromJson(json['plan'] as Map<String, dynamic>? ?? {}),
    );
  }
}
