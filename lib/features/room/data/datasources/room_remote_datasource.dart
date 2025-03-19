import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_management_app/features/room/data/models/room_model.dart';

abstract class RoomRemoteDatasource {
  Future<List<RoomModel>> fetchRoomsByBuilding(String buildingId);
  Future<void> addRoom(RoomModel room);
  Future<void> updateRoom(RoomModel room);
  Future<void> deleteRoom(String roomId);
}

class RoomRemoteDataSourceImpl implements RoomRemoteDatasource {
  final FirebaseFirestore _firestore;

  RoomRemoteDataSourceImpl({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<RoomModel>> fetchRoomsByBuilding(String buildingId) async {
    try {
      final snapshot = await _firestore
          .collection('rooms')
          .where('buildingId', isEqualTo: buildingId)
          .get();
      return snapshot.docs.map((doc) {
        return RoomModel.fromMap(doc.data());
      }).toList();
    } catch (e) {
      throw Exception('Error fetching rooms by building: $e');
    }
  }

  @override
  Future<void> addRoom(RoomModel room) async {
    try {
      await _firestore.collection('rooms').doc(room.id).set(room.toMap());
    } catch (e) {
      throw Exception('Error adding room: $e');
    }
  }

  @override
  Future<void> updateRoom(RoomModel room) async {
    try {
      await _firestore.collection('rooms').doc(room.id).update(room.toMap());
    } catch (e) {
      throw Exception('Error updating room: $e');
    }
  }

  @override
  Future<void> deleteRoom(String roomId) async {
    try {
      await _firestore.collection('rooms').doc(roomId).delete();
    } catch (e) {
      throw Exception('Error deleting room: $e');
    }
  }
}