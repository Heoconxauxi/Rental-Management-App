import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_management_app/features/room/data/datasources/room_remote_datasource.dart';
import 'package:rental_management_app/features/room/data/repositories/room_repository_impl.dart';
import 'package:rental_management_app/features/room/domain/repositories/room_repository.dart';
import 'package:rental_management_app/features/room/domain/usecases/create_room_usecase.dart';
import 'package:rental_management_app/features/room/domain/usecases/delete_room_usecase.dart';
import 'package:rental_management_app/features/room/domain/usecases/get_rooms_usecase.dart';
import 'package:rental_management_app/features/room/domain/usecases/update_room_usecase.dart';
import 'package:rental_management_app/features/room/presentation/providers/room_notifier.dart';
import 'package:rental_management_app/features/room/presentation/states/room_state.dart';

// DataSource
final roomRemoteDataSourceProvider = Provider<RoomRemoteDatasource>((ref) {
  return RoomRemoteDataSourceImpl();
});

// Repository
final roomRepositoryProvider = Provider<RoomRepository>((ref) {
  final ds = ref.watch(roomRemoteDataSourceProvider);
  return RoomRepositoryImpl(ds);
});

// UseCases
final getRoomsUseCaseProvider = Provider((ref) =>
    GetRoomsUseCase(ref.watch(roomRepositoryProvider)));

final createRoomUseCaseProvider = Provider((ref) =>
    CreateRoomUseCase(ref.watch(roomRepositoryProvider)));

final deleteRoomUseCaseProvider = Provider((ref) =>
    DeleteRoomUseCase(ref.watch(roomRepositoryProvider)));

final updateRoomUseCaseProvider = Provider((ref) =>
    UpdateRoomUseCase(ref.watch(roomRepositoryProvider)));

// Notifier
final roomNotifierProvider =
    StateNotifierProvider<RoomNotifier, RoomState>((ref) {
  return RoomNotifier(
    ref.watch(getRoomsUseCaseProvider),
    ref.watch(createRoomUseCaseProvider),
    ref.watch(deleteRoomUseCaseProvider),
    ref.watch(updateRoomUseCaseProvider),
  );
});
