import 'geo_point.dart';

class PlaceLocation {
  const PlaceLocation({
    required this.id,
    required this.label,
    required this.address,
    required this.point,
    this.isCurrentLocation = false,
  });

  final String id;
  final String label;
  final String address;
  final GeoPoint point;
  final bool isCurrentLocation;

  factory PlaceLocation.fromJson(Map<String, dynamic> json) {
    return PlaceLocation(
      id: json['id'] as String? ?? '',
      label: json['label'] as String? ?? '',
      address: json['address'] as String? ?? '',
      point: GeoPoint.fromJson(json['point'] as Map<String, dynamic>? ?? {}),
      isCurrentLocation: json['isCurrentLocation'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'address': address,
      'point': point.toJson(),
      'isCurrentLocation': isCurrentLocation,
    };
  }
}
