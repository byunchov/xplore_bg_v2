import 'package:xplore_bg_v2/domain/core/utils/google_maps.util.dart';

class LocationIdentifierModel {
  final String id;
  final GMapsPlaceType type;
  LocationIdentifierModel({
    required this.id,
    required this.type,
  });

  LocationIdentifierModel copyWith({
    String? id,
    GMapsPlaceType? type,
  }) {
    return LocationIdentifierModel(
      id: id ?? this.id,
      type: type ?? this.type,
    );
  }

  @override
  String toString() => 'LocationIdentifierModel(id: $id, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationIdentifierModel && other.id == id && other.type == type;
  }

  @override
  int get hashCode => id.hashCode ^ type.hashCode;
}
