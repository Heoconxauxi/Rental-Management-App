import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/payment_history_model.dart';
import '../../domain/entities/payment_history.dart';

abstract class PaymentHistoryRemoteDataSource {
  Future<List<PaymentHistory>> getPaymentsByInvoice(String invoiceId);
  Future<PaymentHistory> getPaymentById(String paymentId);
  Future<void> addPayment(PaymentHistory payment);
  Future<void> updatePayment(PaymentHistory payment);
  Future<void> deletePayment(String paymentId);
}

class PaymentHistoryRemoteDataSourceImpl implements PaymentHistoryRemoteDataSource {
  final FirebaseFirestore firestore;

  PaymentHistoryRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<PaymentHistory>> getPaymentsByInvoice(String invoiceId) async {
    final snapshot = await firestore
        .collection('paymentHistory')
        .where('invoiceId', isEqualTo: invoiceId)
        .get();
    return snapshot.docs
        .map((doc) => PaymentHistoryModel.fromMap(doc.data()).toEntity())
        .toList();
  }

  @override
  Future<PaymentHistory> getPaymentById(String paymentId) async {
    final doc = await firestore.collection('paymentHistory').doc(paymentId).get();
    if (!doc.exists) {
      throw Exception('Payment not found');
    }
    return PaymentHistoryModel.fromMap(doc.data()!).toEntity();
  }

  @override
  Future<void> addPayment(PaymentHistory payment) async {
    final model = PaymentHistoryModel.fromEntity(payment);
    await firestore.collection('paymentHistory').doc(payment.id).set(model.toMap());
  }

  @override
  Future<void> updatePayment(PaymentHistory payment) async {
    final model = PaymentHistoryModel.fromEntity(payment);
    await firestore.collection('paymentHistory').doc(payment.id).update(model.toMap());
  }

  @override
  Future<void> deletePayment(String paymentId) async {
    await firestore.collection('paymentHistory').doc(paymentId).delete();
  }
}