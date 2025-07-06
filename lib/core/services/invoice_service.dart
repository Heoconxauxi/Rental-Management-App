import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/invoice_model.dart';

class InvoiceService {
  final _collection = FirebaseFirestore.instance.collection('invoices');

  // Lấy tất cả hóa đơn (realtime)
  Stream<List<Invoice>> getAllInvoicesStream() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Invoice.fromJson(doc.data()).copyWith(id: doc.id);
      }).toList();
    });
  }

  // Lấy hóa đơn theo buildingId
  Future<List<Invoice>> getInvoicesByBuilding(String buildingId) async {
    final snapshot = await _collection.where('buildingId', isEqualTo: buildingId).get();
    return snapshot.docs.map((doc) => Invoice.fromJson(doc.data()).copyWith(id: doc.id)).toList();
  }

  // Thêm hóa đơn (paymentDate luôn null khi thêm)
  Future<void> addInvoice(Invoice invoice) async {
    final data = invoice.copyWith(paymentDate: null).toJson();
    final docRef = await _collection.add(data);
    await docRef.update({'id': docRef.id});
  }

  // Cập nhật hóa đơn
  Future<void> updateInvoice(Invoice invoice) async {
    await _collection.doc(invoice.id).update(invoice.toJson());
  }

  // Xóa hóa đơn
  Future<void> deleteInvoice(String id) async {
    await _collection.doc(id).delete();
  }

  // Lấy hóa đơn theo ID
  Future<Invoice?> getInvoiceById(String id) async {
    final doc = await _collection.doc(id).get();
    if (doc.exists) {
      return Invoice.fromJson(doc.data()!).copyWith(id: doc.id);
    }
    return null;
  }

  // Lấy hóa đơn theo tenantId
  Future<List<Invoice>> getInvoicesByTenant(String tenantId) async {
    final snapshot = await _collection.where('tenantId', isEqualTo: tenantId).get();
    return snapshot.docs.map((doc) => Invoice.fromJson(doc.data()).copyWith(id: doc.id)).toList();
  }

  // Lấy hóa đơn theo roomId
  Future<List<Invoice>> getInvoicesByRoom(String roomId) async {
    final snapshot = await _collection.where('roomId', isEqualTo: roomId).get();
    return snapshot.docs.map((doc) => Invoice.fromJson(doc.data()).copyWith(id: doc.id)).toList();
  }

  // Lấy hóa đơn theo contractId (sửa lỗi cú pháp)
  Future<List<Invoice>> getInvoicesByContractId(String contractId) async {
    final snapshot = await _collection.where('contractId', isEqualTo: contractId).get();
    return snapshot.docs.map((doc) => Invoice.fromJson(doc.data()).copyWith(id: doc.id)).toList();
  }

  Stream<List<Invoice>> watchInvoicesByTenant(String tenantId) {
    return _collection
        .where('tenantId', isEqualTo: tenantId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Invoice.fromJson(doc.data()).copyWith(id: doc.id))
            .toList());
  }

  // Stream số lượng hóa đơn theo trạng thái, lọc theo tháng/năm
  Stream<Map<String, int>> getPaymentStatusCounts({int? month, int? year}) {
    return _collection.snapshots().map((snapshot) {
      final Map<String, int> counts = {'paid': 0, 'unpaid': 0};
      for (var doc in snapshot.docs) {
        final invoice = Invoice.fromJson(doc.data());
        // Lọc theo tháng/năm
        if (month == null || year == null || (invoice.invoiceMonth == month && invoice.invoiceYear == year)) {
          if (invoice.status == 'paid') {
            counts['paid'] = (counts['paid'] ?? 0) + 1;
          } else if (invoice.status == 'unpaid') {
            counts['unpaid'] = (counts['unpaid'] ?? 0) + 1;
          }
        }
      }
      return counts;
    });
  }
}
