import 'package:rental_management_app/features/room/domain/entities/room.dart';

class RoomState {
  final bool isLoading;
  final List<Room> rooms;
  final String? error;

  const RoomState({
    this.isLoading = false,
    this.rooms = const [],
    this.error,
  });

  RoomState copyWith({
    bool? isLoading,
    List<Room>? rooms,
    String? error,
  }) {
    return RoomState(
      isLoading: isLoading ?? this.isLoading,
      rooms: rooms ?? this.rooms,
      error: error,
    );
  }
}
