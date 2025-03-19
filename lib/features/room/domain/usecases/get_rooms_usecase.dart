import 'package:rental_management_app/features/room/domain/entities/room.dart';
import 'package:rental_management_app/features/room/domain/repositories/room_repository.dart';

class GetRoomsUseCase {
  final RoomRepository repository;

  GetRoomsUseCase(this.repository);

  Future<List<Room>> call(String buildingId) {
    return repository.getRoomsByBuilding(buildingId);
  }
}
