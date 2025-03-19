import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/invoice_model.dart';
import '../../domain/entities/invoice.dart';

abstract class InvoiceRemoteDataSource {
  Future<List<Invoice>> getInvoicesByTenant(String tenantId);
  Future<Invoice> getInvoiceById(String invoiceId);
  Future<void> addInvoice(Invoice invoice);
  Future<void> updateInvoice(Invoice invoice);
  Future<void> deleteInvoice(String invoiceId);
}

class InvoiceRemoteDataSourceImpl implements InvoiceRemoteDataSource {
  final FirebaseFirestore firestore;

  InvoiceRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<Invoice>> getInvoicesByTenant(String tenantId) async {
    final snapshot = await firestore
        .collection('invoices')
        .where('tenantId', isEqualTo: tenantId)
        .get();
    return snapshot.docs
        .map((doc) => InvoiceModel.fromMap(doc.data()).toEntity())
        .toList();
  }

  @override
  Future<Invoice> getInvoiceById(String invoiceId) async {
    final doc = await firestore.collection('invoices').doc(invoiceId).get();
    if (!doc.exists) {
      throw Exception('Invoice not found');
    }
    return InvoiceModel.fromMap(doc.data()!).toEntity();
  }

  @override
  Future<void> addInvoice(Invoice invoice) async {
    final model = InvoiceModel.fromEntity(invoice);
    await firestore.collection('invoices').doc(invoice.id).set(model.toMap());
  }

  @override
  Future<void> updateInvoice(Invoice invoice) async {
    final model = InvoiceModel.fromEntity(invoice);
    await firestore.collection('invoices').doc(invoice.id).update(model.toMap());
  }

  @override
  Future<void> deleteInvoice(String invoiceId) async {
    await firestore.collection('invoices').doc(invoiceId).delete();
  }
}