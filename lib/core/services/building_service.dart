import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/building_model.dart';

class BuildingService {
  final _collection = FirebaseFirestore.instance.collection('buildings');

  // Lấy danh sách tất cả building (Stream)
  Stream<List<Building>> getAllBuildingsStream() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Building.fromJson(data).copyWith(id: doc.id);
      }).toList();
    });
  }

  // Thêm building mới (id sẽ do Firestore tự sinh)
  Future<void> addBuilding(Building building) async {
    await _collection.add(building.toJson());
  }

  // Cập nhật building
  Future<void> updateBuilding(Building building) async {
    await _collection.doc(building.id).update(building.toJson());
  }

  // Xoá building theo id
  Future<void> deleteBuilding(String id) async {
    await _collection.doc(id).delete();
  }

  // Lấy 1 building theo id (nếu cần)
  Future<Building?> getBuildingById(String id) async {
    final doc = await _collection.doc(id).get();
    if (doc.exists) {
      return Building.fromJson(doc.data()!).copyWith(id: doc.id);
    }
    return null;
  }
}
