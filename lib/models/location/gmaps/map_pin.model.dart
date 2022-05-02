import 'package:latlong2/latlong.dart';
import 'package:xplore_bg_v2/models/models.dart';

class GMapsLocationPin {
  final String id;
  final String? name;
  final int index;
  final LatLng coordinates;

  GMapsLocationPin({
    required this.id,
    this.name,
    required this.index,
    required this.coordinates,
  });

  GMapsLocationPin copyWith({
    String? id,
    String? name,
    int? index,
    LatLng? coordinates,
  }) {
    return GMapsLocationPin(
      id: id ?? this.id,
      name: name ?? this.name,
      index: index ?? this.index,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  factory GMapsLocationPin.fromLocationModel(LocationModel location, int index) {
    return GMapsLocationPin(
      id: location.id,
      name: location.name,
      index: index,
      coordinates: location.coordinates!,
    );
  }

  @override
  String toString() {
    return 'GMapsLocationPin(id: $id, name: $name, index: $index, coordinates: $coordinates)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GMapsLocationPin &&
        other.id == id &&
        other.name == name &&
        other.index == index &&
        other.coordinates == coordinates;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ index.hashCode ^ coordinates.hashCode;
  }
}
