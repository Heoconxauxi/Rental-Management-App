import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/building_access_model.dart';
import '../../domain/entities/building_access.dart';

abstract class BuildingAccessRemoteDataSource {
  Future<List<BuildingAccess>> getAccessByAccount(String accountId);
  Future<BuildingAccess> getAccessById(String accessId);
  Future<void> addAccess(BuildingAccess access);
  Future<void> updateAccess(BuildingAccess access);
  Future<void> deleteAccess(String accessId);
}

class BuildingAccessRemoteDataSourceImpl implements BuildingAccessRemoteDataSource {
  final FirebaseFirestore firestore;

  BuildingAccessRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<BuildingAccess>> getAccessByAccount(String accountId) async {
    final snapshot = await firestore
        .collection('buildingAccess')
        .where('accountId', isEqualTo: accountId)
        .get();
    return snapshot.docs
        .map((doc) => BuildingAccessModel.fromMap(doc.data()).toEntity())
        .toList();
  }

  @override
  Future<BuildingAccess> getAccessById(String accessId) async {
    final doc = await firestore.collection('buildingAccess').doc(accessId).get();
    if (!doc.exists) {
      throw Exception('Access not found');
    }
    return BuildingAccessModel.fromMap(doc.data()!).toEntity();
  }

  @override
  Future<void> addAccess(BuildingAccess access) async {
    final model = BuildingAccessModel.fromEntity(access);
    await firestore.collection('buildingAccess').doc(access.id).set(model.toMap());
  }

  @override
  Future<void> updateAccess(BuildingAccess access) async {
    final model = BuildingAccessModel.fromEntity(access);
    await firestore.collection('buildingAccess').doc(access.id).update(model.toMap());
  }

  @override
  Future<void> deleteAccess(String accessId) async {
    await firestore.collection('buildingAccess').doc(accessId).delete();
  }
}