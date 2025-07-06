import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/invoice_service.dart';
import '../models/invoice_model.dart';

// Service provider
final invoiceServiceProvider = Provider<InvoiceService>((ref) {
  return InvoiceService();
});

// Tất cả hóa đơn (realtime)
final allInvoicesProvider = StreamProvider<List<Invoice>>((ref) {
  return ref.read(invoiceServiceProvider).getAllInvoicesStream();
});

// Hóa đơn theo buildingId (Future)
final invoicesByBuildingProvider = FutureProvider.family<List<Invoice>, String>((ref, buildingId) {
  return ref.read(invoiceServiceProvider).getInvoicesByBuilding(buildingId);
});

// Hóa đơn theo tenantId (Future)
final invoicesByTenantProvider = StreamProvider.family<List<Invoice>, String>((ref, tenantId) {
  return ref.read(invoiceServiceProvider).watchInvoicesByTenant(tenantId);
});

// Hóa đơn theo roomId (Future)
final invoicesByRoomProvider = FutureProvider.family<List<Invoice>, String>((ref, roomId) {
  return ref.read(invoiceServiceProvider).getInvoicesByRoom(roomId);
});

final invoicesByContractProvider = FutureProvider.family<List<Invoice>, String>((ref, contractId) async {
  final service = ref.read(invoiceServiceProvider);
  return await service.getInvoicesByContractId(contractId);
});