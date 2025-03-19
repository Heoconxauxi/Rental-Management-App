import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_management_app/features/tenant/domain/entities/tenant.dart';

class TenantModel extends Tenant {
  TenantModel({
    required super.id,
    super.accountId,
    required super.fullName,
    required super.phone,
    required super.email,
    required String encryptedIdNumber,
    required super.idIssueDate,
    required super.idIssuePlace,
    required super.dateOfBirth,
    required super.gender,
    required super.permanentAddress,
    required super.emergencyContact,
    required super.occupation,
    required super.workplace,
    required super.monthlyIncome,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    super.currentRental, required super.idNumber,
  }) : _encryptedIdNumber = encryptedIdNumber;

  final String _encryptedIdNumber;

  factory TenantModel.fromMap(Map<String, dynamic> map) {
    return TenantModel(
      id: map['id'] as String? ?? 'UnknownID',
      accountId: map['accountId'] as String?,
      fullName: map['fullName'] as String? ?? 'UnknownName',
      phone: map['phone'] as String? ?? 'UnknownPhone',
      email: map['email'] as String? ?? 'UnknownEmail',
      encryptedIdNumber: map['encryptedIdNumber'] as String? ?? '',
      idIssueDate: (map['idIssueDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      idIssuePlace: map['idIssuePlace'] as String? ?? 'UnknownPlace',
      dateOfBirth: (map['dateOfBirth'] as Timestamp?)?.toDate() ?? DateTime.now(),
      gender: map['gender'] as String? ?? 'Unknown',
      permanentAddress: map['permanentAddress'] as String? ?? 'UnknownAddress',
      emergencyContact: EmergencyContact(
        name: map['emergencyContact']?['name'] as String? ?? 'UnknownName',
        phone: map['emergencyContact']?['phone'] as String? ?? 'UnknownPhone',
        relationship: map['emergencyContact']?['relationship'] as String? ?? 'Unknown',
      ),
      occupation: map['occupation'] as String? ?? 'Unknown',
      workplace: map['workplace'] as String? ?? 'Unknown',
      monthlyIncome: (map['monthlyIncome'] as num?)?.toDouble() ?? 0.0,
      status: map['status'] as String? ?? 'Unknown',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      currentRental: map['currentRental'] != null
          ? CurrentRental(
              roomId: map['currentRental']['roomId'] as String? ?? 'UnknownRoom',
              contractId: map['currentRental']['contractId'] as String? ?? 'UnknownContract',
              buildingId: map['currentRental']['buildingId'] as String? ?? 'UnknownBuilding',
            )
          : null, idNumber: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'accountId': accountId,
      'fullName': fullName,
      'phone': phone,
      'email': email,
      'encryptedIdNumber': _encryptedIdNumber,
      'idIssueDate': Timestamp.fromDate(idIssueDate),
      'idIssuePlace': idIssuePlace,
      'dateOfBirth': Timestamp.fromDate(dateOfBirth),
      'gender': gender,
      'permanentAddress': permanentAddress,
      'emergencyContact': {
        'name': emergencyContact.name,
        'phone': emergencyContact.phone,
        'relationship': emergencyContact.relationship,
      },
      'occupation': occupation,
      'workplace': workplace,
      'monthlyIncome': monthlyIncome,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'currentRental': currentRental != null
          ? {
              'roomId': currentRental!.roomId,
              'contractId': currentRental!.contractId,
              'buildingId': currentRental!.buildingId,
            }
          : null,
    };
  }

  Tenant toEntity() => this;

  static TenantModel fromEntity(Tenant entity, {String? encryptedIdNumber}) {
    return TenantModel(
      id: entity.id,
      accountId: entity.accountId,
      fullName: entity.fullName,
      phone: entity.phone,
      email: entity.email,
      encryptedIdNumber: encryptedIdNumber ?? '',
      idIssueDate: entity.idIssueDate,
      idIssuePlace: entity.idIssuePlace,
      dateOfBirth: entity.dateOfBirth,
      gender: entity.gender,
      permanentAddress: entity.permanentAddress,
      emergencyContact: entity.emergencyContact,
      occupation: entity.occupation,
      workplace: entity.workplace,
      monthlyIncome: entity.monthlyIncome,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      currentRental: entity.currentRental, idNumber: '',
    );
  }
}