import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_model.freezed.dart';
part 'room_model.g.dart';

@freezed
class Room with _$Room {
  const factory Room({
    required String id,
    required String buildingId,
    required String roomNumber,
    required String roomType,
    required double area,
    required int basePrice,
    required int depositAmount,
    required String status,
    required int maxOccupants,
    required int floor,
    required Map<String, bool> amenities,
    String? currentTenantId,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
