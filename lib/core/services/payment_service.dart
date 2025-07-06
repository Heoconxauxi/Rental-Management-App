import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:rental_management_app/models/invoice_model.dart';
import '../../models/payment_model.dart';

class PaymentService {
  final _paymentCollection = FirebaseFirestore.instance.collection('payments');
  final _invoiceCollection = FirebaseFirestore.instance.collection('invoices');

  // Lấy danh sách thanh toán (realtime)
  Stream<List<Payment>> getAllPaymentsStream() {
    return _paymentCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Payment.fromJson(doc.data()).copyWith(id: doc.id);
      }).toList();
    });
  }

  // Thêm payment và cập nhật invoice tương ứng
  Future<void> addPayment(Payment payment) async {
    // Lấy ngày hôm nay định dạng yyyy-MM-dd
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    //  Thêm payment mới (ghi paymentDate = hôm nay)
    final newPayment = payment.copyWith(paymentDate: today);
    final docRef = await _paymentCollection.add(newPayment.toJson());
    await docRef.update({'id': docRef.id});

    // Cập nhật invoice
    await _invoiceCollection.doc(payment.invoiceId).update({
      'paymentDate': today,
      'status': 'paid',
    });
  }

  // Xoá payment
  Future<void> deletePayment(String id) async {
    await _paymentCollection.doc(id).delete();
  }

  // Lấy payment theo invoiceId
  Future<List<Payment>> getPaymentsByInvoice(String invoiceId) async {
    final snapshot = await _paymentCollection.where('invoiceId', isEqualTo: invoiceId).get();
    return snapshot.docs.map((doc) => Payment.fromJson(doc.data()).copyWith(id: doc.id)).toList();
  }

  Future<List<Payment>> getPaymentsByTenant(String tenantId) async {
  final invoiceSnap = await _invoiceCollection.where('tenantId', isEqualTo: tenantId).get();
  final invoiceIds = invoiceSnap.docs.map((doc) => doc.id).toList();

  if (invoiceIds.isEmpty) return [];

  final paymentSnap = await _paymentCollection
        .where('invoiceId', whereIn: invoiceIds.take(10).toList())
        .get();

    return paymentSnap.docs
        .map((doc) => Payment.fromJson(doc.data()).copyWith(id: doc.id))
        .toList();
  }

  Future<List<Payment>> getPaymentsByRoom(String roomId) async {
    final invoiceSnap = await _invoiceCollection.where('roomId', isEqualTo: roomId).get();
    final invoiceIds = invoiceSnap.docs.map((doc) => doc.id).toList();

    if (invoiceIds.isEmpty) return [];

    final paymentSnap = await _paymentCollection
        .where('invoiceId', whereIn: invoiceIds.take(10).toList())
        .get();

    return paymentSnap.docs
        .map((doc) => Payment.fromJson(doc.data()).copyWith(id: doc.id))
        .toList();
  }

  Future<List<Payment>> getPaymentsByBuilding(String buildingId) async {
    final invoiceSnap = await _invoiceCollection.where('buildingId', isEqualTo: buildingId).get();
    final invoiceIds = invoiceSnap.docs.map((doc) => doc.id).toList();

    if (invoiceIds.isEmpty) return [];

    final paymentSnap = await _paymentCollection
        .where('invoiceId', whereIn: invoiceIds.take(10).toList())
        .get();

    return paymentSnap.docs
        .map((doc) => Payment.fromJson(doc.data()).copyWith(id: doc.id))
        .toList();
  }

  // Stream số lượng hóa đơn đã thanh toán và chưa thanh toán
  Stream<Map<String, int>> getPaymentStatusCounts() {
    return FirebaseFirestore.instance.collection('invoices').snapshots().map((snapshot) {
      final Map<String, int> counts = {'paid': 0, 'unpaid': 0};
      for (var doc in snapshot.docs) {
        final invoice = Invoice.fromJson(doc.data());
        if (invoice.status == 'paid') {
          counts['paid'] = (counts['paid'] ?? 0) + 1;
        } else if (invoice.status == 'unpaid') {
          counts['unpaid'] = (counts['unpaid'] ?? 0) + 1;
        }
      }
      return counts;
    });
  }

  // Stream tổng số tiền đã thu theo tháng/năm
  Stream<double> getTotalPaymentsAmount({int? month, int? year}) {

    if (month != null && year != null) {
      // Lọc theo tháng/năm dựa trên paymentDate
      // Firestore không hỗ trợ lọc trực tiếp theo tháng/năm trong query, nên ta xử lý trong stream
      return _paymentCollection.snapshots().map((snapshot) {
        double total = 0;
        for (var doc in snapshot.docs) {
          final payment = Payment.fromJson(doc.data());
          final paymentDate = DateTime.parse(payment.paymentDate);
          if ((paymentDate.month == month && paymentDate.year == year)) {
            total += payment.amount;
          }
        }
        return total;
      });
    }

    return _paymentCollection.snapshots().map((snapshot) {
      double total = 0;
      for (var doc in snapshot.docs) {
        final payment = Payment.fromJson(doc.data());
        total += payment.amount;
      }
      return total;
    });
  }
}
