import 'package:rental_management_app/features/room/domain/entities/room.dart';

abstract class RoomRepository {
  Future<List<Room>> getRoomsByBuilding(String buildingId);
  Future<void> createRoom(Room room);
  Future<void> updateRoom(Room room);
  Future<void> deleteRoom(String roomId);
}
