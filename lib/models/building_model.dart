import 'package:freezed_annotation/freezed_annotation.dart';

part 'building_model.freezed.dart';
part 'building_model.g.dart';

@freezed
class Building with _$Building {
  const factory Building({
    required String id,
    required String buildingName,
    required String address,
    required int totalRooms,
    required String managerId,
    required String status,
  }) = _Building;

  factory Building.fromJson(Map<String, dynamic> json) => _$BuildingFromJson(json);
}
