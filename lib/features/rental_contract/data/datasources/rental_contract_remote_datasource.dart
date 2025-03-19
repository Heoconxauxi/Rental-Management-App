import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/rental_contract_model.dart';
import '../../domain/entities/rental_contract.dart';

abstract class RentalContractRemoteDataSource {
  Future<List<RentalContract>> getContractsByTenant(String tenantId);
  Future<RentalContract> getContractById(String contractId);
  Future<void> addContract(RentalContract contract);
  Future<void> updateContract(RentalContract contract);
  Future<void> deleteContract(String contractId);
}

class RentalContractRemoteDataSourceImpl implements RentalContractRemoteDataSource {
  final FirebaseFirestore firestore;

  RentalContractRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<RentalContract>> getContractsByTenant(String tenantId) async {
    final snapshot = await firestore
        .collection('rentalContracts')
        .where('tenantId', isEqualTo: tenantId)
        .get();
    return snapshot.docs
        .map((doc) => RentalContractModel.fromMap(doc.data()).toEntity())
        .toList();
  }

  @override
  Future<RentalContract> getContractById(String contractId) async {
    final doc = await firestore.collection('rentalContracts').doc(contractId).get();
    if (!doc.exists) {
      throw Exception('Contract not found');
    }
    return RentalContractModel.fromMap(doc.data()!).toEntity();
  }

  @override
  Future<void> addContract(RentalContract contract) async {
    final model = RentalContractModel.fromEntity(contract);
    await firestore.collection('rentalContracts').doc(contract.id).set(model.toMap());
  }

  @override
  Future<void> updateContract(RentalContract contract) async {
    final model = RentalContractModel.fromEntity(contract);
    await firestore.collection('rentalContracts').doc(contract.id).update(model.toMap());
  }

  @override
  Future<void> deleteContract(String contractId) async {
    await firestore.collection('rentalContracts').doc(contractId).delete();
  }
}