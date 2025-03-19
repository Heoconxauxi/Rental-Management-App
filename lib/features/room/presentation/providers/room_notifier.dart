import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_management_app/features/room/domain/entities/room.dart';
import 'package:rental_management_app/features/room/domain/usecases/create_room_usecase.dart';
import 'package:rental_management_app/features/room/domain/usecases/delete_room_usecase.dart';
import 'package:rental_management_app/features/room/domain/usecases/get_rooms_usecase.dart';
import 'package:rental_management_app/features/room/domain/usecases/update_room_usecase.dart';
import 'package:rental_management_app/features/room/presentation/states/room_state.dart';

class RoomNotifier extends StateNotifier<RoomState> {
  final GetRoomsUseCase getRoomsUseCase;
  final CreateRoomUseCase createRoomUseCase;
  final DeleteRoomUseCase deleteRoomUseCase;
  final UpdateRoomUseCase updateRoomUseCase;

  RoomNotifier(
    this.getRoomsUseCase,
    this.createRoomUseCase,
    this.deleteRoomUseCase,
    this.updateRoomUseCase,
  ) : super(const RoomState());

  Future<void> loadRooms(String buildingId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final rooms = await getRoomsUseCase(buildingId);
      state = state.copyWith(isLoading: false, rooms: rooms);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addRoom(Room room) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await createRoomUseCase(room);
      await loadRooms(room.buildingId);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateRoom(Room room) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await updateRoomUseCase(room);
      await loadRooms(room.buildingId);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> deleteRoom(String roomId, String buildingId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await deleteRoomUseCase(roomId);
      await loadRooms(buildingId);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
