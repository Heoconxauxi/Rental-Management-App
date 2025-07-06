import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_management_app/providers/invoice_provider.dart';
import '../core/services/payment_service.dart';
import '../models/payment_model.dart';

// Provider cho service
final paymentServiceProvider = Provider<PaymentService>((ref) {
  return PaymentService();
});

// Tất cả payments (realtime)
final allPaymentsProvider = StreamProvider<List<Payment>>((ref) {
  return ref.read(paymentServiceProvider).getAllPaymentsStream();
});

// Theo `invoiceId`
final paymentsByInvoiceProvider = FutureProvider.family<List<Payment>, String>((ref, invoiceId) {
  return ref.read(paymentServiceProvider).getPaymentsByInvoice(invoiceId);
});

// Theo `tenantId`
final paymentsByTenantProvider = FutureProvider.family<List<Payment>, String>((ref, tenantId) {
  return ref.read(paymentServiceProvider).getPaymentsByTenant(tenantId);
});

// Theo `roomId`
final paymentsByRoomProvider = FutureProvider.family<List<Payment>, String>((ref, roomId) {
  return ref.read(paymentServiceProvider).getPaymentsByRoom(roomId);
});

// Theo `buildingId`
final paymentsByBuildingProvider = FutureProvider.family<List<Payment>, String>((ref, buildingId) {
  return ref.read(paymentServiceProvider).getPaymentsByBuilding(buildingId);
});

// Provider cho tổng số tiền đã thu, lọc theo tháng/năm
final totalPaymentsAmountProvider = StreamProvider.family<double, Map<String, int?>>((ref, filter) {
  final service = ref.read(paymentServiceProvider);
  final month = filter['month'];
  final year = filter['year'];
  return service.getTotalPaymentsAmount(month: month, year: year);
});

// Provider cho số lượng hóa đơn theo trạng thái, lọc theo tháng/năm
final paymentStatusCountsProvider = StreamProvider.family<Map<String, int>, Map<String, int?>>((ref, filter) {
  final service = ref.read(invoiceServiceProvider);
  final month = filter['month'];
  final year = filter['year'];
  return service.getPaymentStatusCounts(month: month, year: year);
});