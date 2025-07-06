import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/room_model.dart';

class RoomService {
  final _roomCollection = FirebaseFirestore.instance.collection('rooms');
  final _contractCollection = FirebaseFirestore.instance.collection('contracts');

  // Lấy danh sách tất cả phòng
  Stream<List<Room>> getAllRoomsStream() {
    return _roomCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Room.fromJson(doc.data()).copyWith(id: doc.id);
      }).toList();
    });
  }

  // Lấy danh sách phòng theo buildingId
  Stream<List<Room>> getRoomsByBuilding(String buildingId) {
    return _roomCollection.where('buildingId', isEqualTo: buildingId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Room.fromJson(doc.data()).copyWith(id: doc.id);
      }).toList();
    });
  }

  // ➕ Thêm phòng mới
  Future<void> addRoom(Room room) async {
    final docRef = await _roomCollection.add(room.toJson());
    await docRef.update({'id': docRef.id});
  }

  // Cập nhật phòng
  Future<void> updateRoom(Room room) async {
    await _roomCollection.doc(room.id).update(room.toJson());
  }

  Future<void> deleteRoom(String roomId) async {
    try {
      // Kiểm tra và xóa các hợp đồng liên quan đến phòng
      final contractsSnapshot = await _contractCollection
          .where('roomId', isEqualTo: roomId)
          .get();

      // Xóa từng hợp đồng
      final deleteContracts = contractsSnapshot.docs.map((doc) => doc.reference.delete());
      await Future.wait(deleteContracts);

      // Sau khi xóa hợp đồng, xóa phòng
      await _roomCollection.doc(roomId).delete();
    } catch (e) {
      throw Exception('Lỗi khi xóa phòng và hợp đồng liên quan: $e');
    }
  }

  // Lấy 1 phòng theo ID
  Future<Room?> getRoomById(String id) async {
    final doc = await _roomCollection.doc(id).get();
    if (doc.exists) {
      return Room.fromJson(doc.data()!).copyWith(id: doc.id);
    }
    return null;
  }
}
