import 'package:rental_management_app/features/room/domain/entities/room.dart';
import 'package:rental_management_app/features/room/domain/repositories/room_repository.dart';

class CreateRoomUseCase {
  final RoomRepository repository;

  CreateRoomUseCase(this.repository);

  Future<void> call(Room room) {
    return repository.createRoom(room);
  }
}