import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_management_app/features/payment_history/domain/entities/payment_history.dart';

class PaymentHistoryModel extends PaymentHistory {
  PaymentHistoryModel({
    required super.id,
    required super.invoiceId,
    required super.paymentAmount,
    required super.paymentDate,
    required super.paymentMethod,
    required super.transactionReference,
    required super.notes,
    required super.recordedBy,
    required super.createdAt,
  });

  factory PaymentHistoryModel.fromMap(Map<String, dynamic> map) {
    return PaymentHistoryModel(
      id: map['id'] as String? ?? 'UnknownID',
      invoiceId: map['invoiceId'] as String? ?? 'UnknownInvoice',
      paymentAmount: (map['paymentAmount'] as num?)?.toDouble() ?? 0.0,
      paymentDate: (map['paymentDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      paymentMethod: map['paymentMethod'] as String? ?? 'UnknownMethod',
      transactionReference: map['transactionReference'] as String? ?? 'UnknownRef',
      notes: map['notes'] as String? ?? '',
      recordedBy: map['recordedBy'] as String? ?? 'UnknownRecorder',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invoiceId': invoiceId,
      'paymentAmount': paymentAmount,
      'paymentDate': Timestamp.fromDate(paymentDate),
      'paymentMethod': paymentMethod,
      'transactionReference': transactionReference,
      'notes': notes,
      'recordedBy': recordedBy,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  PaymentHistory toEntity() => this;

  static PaymentHistoryModel fromEntity(PaymentHistory entity) {
    return PaymentHistoryModel(
      id: entity.id,
      invoiceId: entity.invoiceId,
      paymentAmount: entity.paymentAmount,
      paymentDate: entity.paymentDate,
      paymentMethod: entity.paymentMethod,
      transactionReference: entity.transactionReference,
      notes: entity.notes,
      recordedBy: entity.recordedBy,
      createdAt: entity.createdAt,
    );
  }
}