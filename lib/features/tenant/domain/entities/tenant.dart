class Tenant {
  final String id;
  final String? accountId;
  final String fullName;
  final String phone;
  final String email;
  final String idNumber;
  final DateTime idIssueDate;
  final String idIssuePlace;
  final DateTime dateOfBirth;
  final String gender;
  final String permanentAddress;
  final EmergencyContact emergencyContact;
  final String occupation;
  final String workplace;
  final double monthlyIncome;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CurrentRental? currentRental;

  const Tenant({
    required this.id,
    this.accountId,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.idNumber,
    required this.idIssueDate,
    required this.idIssuePlace,
    required this.dateOfBirth,
    required this.gender,
    required this.permanentAddress,
    required this.emergencyContact,
    required this.occupation,
    required this.workplace,
    required this.monthlyIncome,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.currentRental,
  });

  List<Object?> get props => [
        id,
        accountId,
        fullName,
        phone,
        email,
        idNumber,
        idIssueDate,
        idIssuePlace,
        dateOfBirth,
        gender,
        permanentAddress,
        emergencyContact,
        occupation,
        workplace,
        monthlyIncome,
        status,
        createdAt,
        updatedAt,
        currentRental,
      ];
}

class EmergencyContact {
  final String name;
  final String phone;
  final String relationship;

  const EmergencyContact({
    required this.name,
    required this.phone,
    required this.relationship,
  });

  List<Object?> get props => [name, phone, relationship];
}

class CurrentRental {
  final String roomId;
  final String contractId;
  final String buildingId;

  const CurrentRental({
    required this.roomId,
    required this.contractId,
    required this.buildingId,
  });

  List<Object?> get props => [roomId, contractId, buildingId];
}