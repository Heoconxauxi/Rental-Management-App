import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/building_model.dart';
import '../../domain/entities/building.dart';

abstract class BuildingRemoteDataSource {
  Future<List<Building>> getBuildingsByManager(String managerId);
  Future<Building> getBuildingById(String buildingId);
  Future<void> addBuilding(Building building);
  Future<void> updateBuilding(Building building);
  Future<void> deleteBuilding(String buildingId);
}

class BuildingRemoteDataSourceImpl implements BuildingRemoteDataSource {
  final FirebaseFirestore firestore;

  BuildingRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<Building>> getBuildingsByManager(String managerId) async {
    final snapshot = await firestore
        .collection('buildings')
        .where('managerId', isEqualTo: managerId)
        .get();
    return snapshot.docs
        .map((doc) => BuildingModel.fromMap(doc.data()).toEntity())
        .toList();
  }

  @override
  Future<Building> getBuildingById(String buildingId) async {
    final doc = await firestore.collection('buildings').doc(buildingId).get();
    if (!doc.exists) {
      throw Exception('Building not found');
    }
    return BuildingModel.fromMap(doc.data()!).toEntity();
  }

  @override
  Future<void> addBuilding(Building building) async {
    final model = BuildingModel.fromEntity(building);
    await firestore.collection('buildings').doc(building.id).set(model.toMap());
  }

  @override
  Future<void> updateBuilding(Building building) async {
    final model = BuildingModel.fromEntity(building);
    await firestore.collection('buildings').doc(building.id).update(model.toMap());
  }

  @override
  Future<void> deleteBuilding(String buildingId) async {
    await firestore.collection('buildings').doc(buildingId).delete();
  }
}