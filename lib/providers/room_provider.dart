import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/room_service.dart';
import '../models/room_model.dart';

/// Provider cho RoomService
final roomServiceProvider = Provider<RoomService>((ref) => RoomService());

/// StreamProvider lấy tất cả phòng (nếu cần)
final roomListProvider = StreamProvider<List<Room>>((ref) {
  return ref.read(roomServiceProvider).getAllRoomsStream();
});

/// StreamProvider danh sách phòng theo `buildingId`
final roomsByBuildingProvider = StreamProvider.family<List<Room>, String>((ref, buildingId) {
  return ref.read(roomServiceProvider).getRoomsByBuilding(buildingId);
});
