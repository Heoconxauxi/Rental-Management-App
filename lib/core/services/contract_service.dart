import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/contract_model.dart';

class ContractService {
  final _collection = FirebaseFirestore.instance.collection('contracts');

  // Lấy tất cả hợp đồng (realtime)
  Stream<List<Contract>> getAllContractsStream() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Contract.fromJson(doc.data()).copyWith(id: doc.id);
      }).toList();
    });
  }

  // Thêm hợp đồng mới
  Future<void> addContract(Contract contract) async {
    // Thêm contract mới
    final docRef = await _collection.add(contract.toJson());
    await docRef.update({'id': docRef.id});

    // Cập nhật currentTenantId cho phòng tương ứng
    final roomRef = FirebaseFirestore.instance.collection('rooms').doc(contract.roomId);
    await roomRef.update({'currentTenantId': contract.tenantId});
  }

  // Cập nhật hợp đồng
  Future<void> updateContract(Contract contract) async {
    // Cập nhật hợp đồng
    await _collection.doc(contract.id).update(contract.toJson());

    // Cập nhật lại currentTenantId cho phòng
    final roomRef = FirebaseFirestore.instance.collection('rooms').doc(contract.roomId);
    await roomRef.update({'currentTenantId': contract.tenantId});
  }

  // Xoá hợp đồng
  Future<void> deleteContract(String id) async {
    // Lấy hợp đồng cần xóa để biết roomId
    final doc = await _collection.doc(id).get();
    if (doc.exists) {
      final contract = Contract.fromJson(doc.data()!).copyWith(id: doc.id);

      // Xoá hợp đồng
      await _collection.doc(id).delete();

      // Cập nhật lại phòng: bỏ currentTenantId
      final roomRef = FirebaseFirestore.instance.collection('rooms').doc(contract.roomId);
      await roomRef.update({'currentTenantId': null});
    }
  }

  //Lấy hợp đồng theo ID
  Future<Contract?> getContractById(String id) async {
    final doc = await _collection.doc(id).get();
    if (doc.exists) {
      return Contract.fromJson(doc.data()!).copyWith(id: doc.id);
    }
    return null;
  }

  // Lọc hợp đồng theo `buildingId`
  Future<List<Contract>> getContractsByBuilding(String buildingId) async {
    final snapshot = await _collection.where('buildingId', isEqualTo: buildingId).get();
    return snapshot.docs.map((doc) => Contract.fromJson(doc.data()).copyWith(id: doc.id)).toList();
  }
}
