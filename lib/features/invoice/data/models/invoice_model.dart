import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/invoice.dart';

class InvoiceModel extends Invoice {
  InvoiceModel({
    required super.id,
    required super.invoiceNumber,
    required super.contractId,
    required super.roomId,
    required super.tenantId,
    required super.buildingId,
    required super.invoiceMonth,
    required super.invoiceYear,
    required super.fees,
    required super.totalAmount,
    required super.payment,
    required super.issueDate,
    required super.dueDate,
    required super.notes,
    required super.createdBy,
    required super.createdAt,
    required super.updatedAt,
  });

  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      id: map['id'] as String? ?? 'UnknownID',
      invoiceNumber: map['invoiceNumber'] as String? ?? 'UnknownNumber',
      contractId: map['contractId'] as String? ?? 'UnknownContract',
      roomId: map['roomId'] as String? ?? 'UnknownRoom',
      tenantId: map['tenantId'] as String? ?? 'UnknownTenant',
      buildingId: map['buildingId'] as String? ?? 'UnknownBuilding',
      invoiceMonth: (map['invoiceMonth'] as int?) ?? 1,
      invoiceYear: (map['invoiceYear'] as int?) ?? 2023,
      fees: Fees(
        roomRent: (map['fees']?['roomRent'] as num?)?.toDouble() ?? 0.0,
        electricity: UtilityFee(
          usage: (map['fees']?['electricity']?['usage'] as int?) ?? 0,
          price: (map['fees']?['electricity']?['price'] as num?)?.toDouble() ?? 0.0,
          amount: (map['fees']?['electricity']?['amount'] as num?)?.toDouble() ?? 0.0,
        ),
        water: UtilityFee(
          usage: (map['fees']?['water']?['usage'] as int?) ?? 0,
          price: (map['fees']?['water']?['price'] as num?)?.toDouble() ?? 0.0,
          amount: (map['fees']?['water']?['amount'] as num?)?.toDouble() ?? 0.0,
        ),
        serviceFee: (map['fees']?['serviceFee'] as num?)?.toDouble() ?? 0.0,
        internetFee: (map['fees']?['internetFee'] as num?)?.toDouble() ?? 0.0,
        parkingFee: (map['fees']?['parkingFee'] as num?)?.toDouble() ?? 0.0,
        otherFees: (map['fees']?['otherFees'] as num?)?.toDouble() ?? 0.0,
        otherFeesDescription: map['fees']?['otherFeesDescription'] as String? ?? '',
      ),
      totalAmount: (map['totalAmount'] as num?)?.toDouble() ?? 0.0,
      payment: Payment(
        status: map['payment']?['status'] as String? ?? 'Unknown',
        paidAmount: (map['payment']?['paidAmount'] as num?)?.toDouble() ?? 0.0,
        remainingAmount: (map['payment']?['remainingAmount'] as num?)?.toDouble() ?? 0.0,
        paymentDate: (map['payment']?['paymentDate'] as Timestamp?)?.toDate(),
        paymentMethod: map['payment']?['paymentMethod'] as String?,
      ),
      issueDate: (map['issueDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      dueDate: (map['dueDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      notes: map['notes'] as String? ?? '',
      createdBy: map['createdBy'] as String? ?? 'UnknownCreator',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invoiceNumber': invoiceNumber,
      'contractId': contractId,
      'roomId': roomId,
      'tenantId': tenantId,
      'buildingId': buildingId,
      'invoiceMonth': invoiceMonth,
      'invoiceYear': invoiceYear,
      'fees': {
        'roomRent': fees.roomRent,
        'electricity': {
          'usage': fees.electricity.usage,
          'price': fees.electricity.price,
          'amount': fees.electricity.amount,
        },
        'water': {
          'usage': fees.water.usage,
          'price': fees.water.price,
          'amount': fees.water.amount,
        },
        'serviceFee': fees.serviceFee,
        'internetFee': fees.internetFee,
        'parkingFee': fees.parkingFee,
        'otherFees': fees.otherFees,
        'otherFeesDescription': fees.otherFeesDescription,
      },
      'totalAmount': totalAmount,
      'payment': {
        'status': payment.status,
        'paidAmount': payment.paidAmount,
        'remainingAmount': payment.remainingAmount,
        'paymentDate': payment.paymentDate != null ? Timestamp.fromDate(payment.paymentDate!) : null,
        'paymentMethod': payment.paymentMethod,
      },
      'issueDate': Timestamp.fromDate(issueDate),
      'dueDate': Timestamp.fromDate(dueDate),
      'notes': notes,
      'createdBy': createdBy,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  Invoice toEntity() => this;

  static InvoiceModel fromEntity(Invoice entity) {
    return InvoiceModel(
      id: entity.id,
      invoiceNumber: entity.invoiceNumber,
      contractId: entity.contractId,
      roomId: entity.roomId,
      tenantId: entity.tenantId,
      buildingId: entity.buildingId,
      invoiceMonth: entity.invoiceMonth,
      invoiceYear: entity.invoiceYear,
      fees: entity.fees,
      totalAmount: entity.totalAmount,
      payment: entity.payment,
      issueDate: entity.issueDate,
      dueDate: entity.dueDate,
      notes: entity.notes,
      createdBy: entity.createdBy,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}