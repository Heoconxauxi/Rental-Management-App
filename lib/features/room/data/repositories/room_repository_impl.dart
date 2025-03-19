import 'package:rental_management_app/features/room/data/datasources/room_remote_datasource.dart';
import 'package:rental_management_app/features/room/data/models/room_model.dart';
import 'package:rental_management_app/features/room/domain/entities/room.dart';
import 'package:rental_management_app/features/room/domain/repositories/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDatasource remoteDatasource;

  RoomRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<Room>> getRoomsByBuilding(String buildingId) async {
    try {
      final models = await remoteDatasource.fetchRoomsByBuilding(buildingId);
      return models.map((m) => m.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to fetch rooms by building: $e');
    }
  }

  @override
  Future<void> createRoom(Room room) async {
    try {
      final model = RoomModel.fromEntity(room);
      await remoteDatasource.addRoom(model);
    } catch (e) {
      throw Exception('Failed to create room: $e');
    }
  }

  @override
  Future<void> updateRoom(Room room) async {
    try {
      final model = RoomModel.fromEntity(room);
      await remoteDatasource.updateRoom(model);
    } catch (e) {
      throw Exception('Failed to update room: $e');
    }
  }

  @override
  Future<void> deleteRoom(String roomId) async {
    try {
      await remoteDatasource.deleteRoom(roomId);
    } catch (e) {
      throw Exception('Failed to delete room: $e');
    }
  }
}