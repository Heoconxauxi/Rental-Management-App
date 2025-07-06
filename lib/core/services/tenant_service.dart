import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rental_management_app/models/user_model.dart';
import '../../models/tenant_model.dart';

class TenantService {
  final _tenantCollection = FirebaseFirestore.instance.collection('tenants');
  final _roomCollection = FirebaseFirestore.instance.collection('rooms');
  final _userCollection = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;

  var value;

  // Lấy tất cả tenant (realtime)
  Stream<List<Tenant>> getAllTenantsStream() {
    return _tenantCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Tenant.fromJson(doc.data()).copyWith(id: doc.id);
      }).toList();
    });
  }

  // Thêm tenant mới, tạo user auth, appUser và quay lại tài khoản hiện tại
  Future<void> addTenant(Tenant tenant, {
    required String adminEmail,
    required String adminPassword,
  }) async {
    final currentUser = _auth.currentUser;

    try {
      // 1. Tạo tài khoản Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: tenant.email,
        password: tenant.phone, // dùng số điện thoại làm mật khẩu
      );

      final uid = userCredential.user!.uid;

      // 2. Tạo AppUser trong Firestore
      final appUser = AppUser(
        id: uid,
        email: tenant.email,
        fullName: tenant.fullName,
        phone: tenant.phone,
        role: 'tenant',
        status: 'active',
      );
      await _userCollection.doc(uid).set(appUser.toJson());

      // 3. Tạo tenant (liên kết với user)
      final tenantWithAccountId = tenant.copyWith(accountId: uid);
      final docRef = await _tenantCollection.add(tenantWithAccountId.toJson());
      await docRef.update({'id': docRef.id});
    } on FirebaseAuthException catch (e) {
      throw Exception('Tạo tài khoản thất bại: ${e.message}');
    }

    //  4. Đăng nhập lại tài khoản admin gốc
    if (currentUser != null) {
      await _auth.signOut();
      await _auth.signInWithEmailAndPassword(
        email: adminEmail,
        password: adminPassword,
      );
    }
  }

  // Cập nhật tenant
  Future<void> updateTenant(Tenant tenant) async {
    await _tenantCollection.doc(tenant.id).update(tenant.toJson());
  }

  // Xoá tenant
  Future<void> deleteTenant(String id) async {
    await _tenantCollection.doc(id).delete();
  }

  // Lấy tenant theo id
  Future<Tenant?> getTenantById(String id) async {
    final doc = await _tenantCollection.doc(id).get();
    if (doc.exists) {
      return Tenant.fromJson(doc.data()!).copyWith(id: doc.id);
    }
    return null;
  }

  // Lọc theo toà nhà
  Future<List<Tenant>> getTenantsByBuilding(String buildingId) async {
    final roomSnapshot = await _roomCollection
        .where('buildingId', isEqualTo: buildingId)
        .get();

    final roomIds = roomSnapshot.docs.map((r) => r.id).toList();
    if (roomIds.isEmpty) return [];

    final tenantSnapshot = await _tenantCollection
        .where('currentRoomId', whereIn: roomIds.take(10).toList())
        .get();

    return tenantSnapshot.docs
        .map((doc) => Tenant.fromJson(doc.data()).copyWith(id: doc.id))
        .toList();
  }
}
