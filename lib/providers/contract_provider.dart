import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/contract_service.dart';
import '../models/contract_model.dart';

// Provider cho service
final contractServiceProvider = Provider<ContractService>((ref) {
  return ContractService();
});

// Stream tất cả hợp đồng
final allContractsProvider = StreamProvider<List<Contract>>((ref) {
  return ref.read(contractServiceProvider).getAllContractsStream();
});

// Future danh sách hợp đồng theo `buildingId`
final contractsByBuildingProvider = FutureProvider.family<List<Contract>, String>((ref, buildingId) async {
  return await ref.read(contractServiceProvider).getContractsByBuilding(buildingId);
});
