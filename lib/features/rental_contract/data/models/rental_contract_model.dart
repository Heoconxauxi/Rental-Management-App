import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_management_app/features/rental_contract/domain/entities/rental_contract.dart';

class RentalContractModel extends RentalContract {
  RentalContractModel({
    required super.id,
    required super.contractNumber,
    required super.roomId,
    required super.tenantId,
    required super.buildingId,
    required super.startDate,
    required super.endDate,
    required super.monthlyRent,
    required super.depositPaid,
    required super.contractTerms,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    required super.createdBy,
    required super.paymentSchedule,
  });

  factory RentalContractModel.fromMap(Map<String, dynamic> map) {
    return RentalContractModel(
      id: map['id'] as String? ?? 'UnknownID',
      contractNumber: map['contractNumber'] as String? ?? 'UnknownNumber',
      roomId: map['roomId'] as String? ?? 'UnknownRoom',
      tenantId: map['tenantId'] as String? ?? 'UnknownTenant',
      buildingId: map['buildingId'] as String? ?? 'UnknownBuilding',
      startDate: (map['startDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endDate: (map['endDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      monthlyRent: (map['monthlyRent'] as num?)?.toDouble() ?? 0.0,
      depositPaid: (map['depositPaid'] as num?)?.toDouble() ?? 0.0,
      contractTerms: map['contractTerms'] as String? ?? '',
      status: map['status'] as String? ?? 'Unknown',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdBy: map['createdBy'] as String? ?? 'UnknownCreator',
      paymentSchedule: PaymentSchedule(
        dueDate: (map['paymentSchedule']?['dueDate'] as int?) ?? 1,
        reminderDays: (map['paymentSchedule']?['reminderDays'] as int?) ?? 0,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'contractNumber': contractNumber,
      'roomId': roomId,
      'tenantId': tenantId,
      'buildingId': buildingId,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'monthlyRent': monthlyRent,
      'depositPaid': depositPaid,
      'contractTerms': contractTerms,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'createdBy': createdBy,
      'paymentSchedule': {
        'dueDate': paymentSchedule.dueDate,
        'reminderDays': paymentSchedule.reminderDays,
      },
    };
  }

  RentalContract toEntity() => this;

  static RentalContractModel fromEntity(RentalContract entity) {
    return RentalContractModel(
      id: entity.id,
      contractNumber: entity.contractNumber,
      roomId: entity.roomId,
      tenantId: entity.tenantId,
      buildingId: entity.buildingId,
      startDate: entity.startDate,
      endDate: entity.endDate,
      monthlyRent: entity.monthlyRent,
      depositPaid: entity.depositPaid,
      contractTerms: entity.contractTerms,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      createdBy: entity.createdBy,
      paymentSchedule: entity.paymentSchedule,
    );
  }
}