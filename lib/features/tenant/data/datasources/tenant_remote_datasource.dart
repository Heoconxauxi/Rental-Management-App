import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tenant_model.dart';
import '../../domain/entities/tenant.dart';

abstract class TenantRemoteDataSource {
  Future<List<Tenant>> getTenantsByBuilding(String buildingId);
  Future<Tenant> getTenantById(String tenantId);
  Future<void> addTenant(Tenant tenant, String encryptedIdNumber);
  Future<void> updateTenant(Tenant tenant);
  Future<void> deleteTenant(String tenantId);
}

class TenantRemoteDataSourceImpl implements TenantRemoteDataSource {
  final FirebaseFirestore firestore;

  TenantRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<Tenant>> getTenantsByBuilding(String buildingId) async {
    final snapshot = await firestore
        .collection('tenants')
        .where('currentRental.buildingId', isEqualTo: buildingId)
        .get();
    return snapshot.docs
        .map((doc) => TenantModel.fromMap(doc.data()).toEntity())
        .toList();
  }

  @override
  Future<Tenant> getTenantById(String tenantId) async {
    final doc = await firestore.collection('tenants').doc(tenantId).get();
    if (!doc.exists) {
      throw Exception('Tenant not found');
    }
    return TenantModel.fromMap(doc.data()!).toEntity();
  }

  @override
  Future<void> addTenant(Tenant tenant, String encryptedIdNumber) async {
    final model = TenantModel.fromEntity(tenant, encryptedIdNumber: encryptedIdNumber);
    await firestore.collection('tenants').doc(tenant.id).set(model.toMap());
  }

  @override
  Future<void> updateTenant(Tenant tenant) async {
    final model = TenantModel.fromEntity(tenant);
    await firestore.collection('tenants').doc(tenant.id).update(model.toMap());
  }

  @override
  Future<void> deleteTenant(String tenantId) async {
    await firestore.collection('tenants').doc(tenantId).delete();
  }
}