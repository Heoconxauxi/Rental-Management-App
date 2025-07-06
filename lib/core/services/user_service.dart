import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/user_model.dart';

class UserService {
  final _collection = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;

  // Lấy toàn bộ users (realtime)
  Stream<List<AppUser>> getAllUsersStream() {
    return _collection.snapshots().map((snap) {
      return snap.docs.map((doc) => AppUser.fromJson(doc.data()).copyWith(id: doc.id)).toList();
    });
  }

  Stream<List<AppUser>> getManagers() {
    return _collection
        .where('role', isEqualTo: 'manager')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AppUser.fromJson(doc.data()).copyWith(id: doc.id))
            .toList());
  }

  // Lấy user theo ID
  Future<AppUser?> getUserById(String userId) async {
    final doc = await _collection.doc(userId).get();
    if (doc.exists) {
      return AppUser.fromJson(doc.data()!).copyWith(id: doc.id);
    }
    return null;
  }

  // Lấy users theo tenantId (tức id trong bảng tenant => accountId)
  Future<List<AppUser>> getUsersByTenantId(String tenantAccountId) async {
    final snap = await _collection.where('id', isEqualTo: tenantAccountId).get();
    return snap.docs.map((doc) => AppUser.fromJson(doc.data()).copyWith(id: doc.id)).toList();
  }

  // Lấy users theo buildingId (giả sử user có liên kết với building)
  Future<List<AppUser>> getUsersByBuildingId(String buildingId) async {
    final roomSnap = await FirebaseFirestore.instance
        .collection('rooms')
        .where('buildingId', isEqualTo: buildingId)
        .get();

    final roomIds = roomSnap.docs.map((doc) => doc.id).toList();

    if (roomIds.isEmpty) return [];

    final tenantSnap = await FirebaseFirestore.instance
        .collection('tenants')
        .where('currentRoomId', whereIn: roomIds.take(10).toList())
        .get();

    final accountIds = tenantSnap.docs.map((t) => t.data()['accountId']).whereType<String>().toList();

    final userSnap = await _collection.where('id', whereIn: accountIds.take(10).toList()).get();

    return userSnap.docs.map((doc) => AppUser.fromJson(doc.data()).copyWith(id: doc.id)).toList();
  }

  // Thêm mới user và tạo auth
  Future<void> addUserWithAuth(AppUser user, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      final uid = userCredential.user!.uid;
      final newUser = user.copyWith(id: uid);
      await _collection.doc(uid).set(newUser.toJson());
    } on FirebaseAuthException catch (e) {
      throw Exception('Tạo tài khoản thất bại: ${e.message}');
    }
  }

  // Cập nhật user
  Future<void> updateUser(AppUser user) async {
    await _collection.doc(user.id).update(user.toJson());
  }

  // Xoá user
  Future<void> deleteUser(String id) async {
    await _collection.doc(id).delete();
  }
}
