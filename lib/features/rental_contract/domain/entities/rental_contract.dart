class RentalContract {
  final String id;
  final String contractNumber;
  final String roomId;
  final String tenantId;
  final String buildingId;
  final DateTime startDate;
  final DateTime endDate;
  final double monthlyRent;
  final double depositPaid;
  final String contractTerms;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String createdBy;
  final PaymentSchedule paymentSchedule;

  RentalContract({
    required this.id,
    required this.contractNumber,
    required this.roomId,
    required this.tenantId,
    required this.buildingId,
    required this.startDate,
    required this.endDate,
    required this.monthlyRent,
    required this.depositPaid,
    required this.contractTerms,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.paymentSchedule,
  }) {
    if (endDate.isBefore(startDate)) {
      throw Exception('endDate must be after startDate');
    }
  }

  List<Object?> get props => [
        id,
        contractNumber,
        roomId,
        tenantId,
        buildingId,
        startDate,
        endDate,
        monthlyRent,
        depositPaid,
        contractTerms,
        status,
        createdAt,
        updatedAt,
        createdBy,
        paymentSchedule,
      ];
}

class PaymentSchedule {
  final int dueDate;
  final int reminderDays;

  const PaymentSchedule({
    required this.dueDate,
    required this.reminderDays,
  });

  List<Object?> get props => [dueDate, reminderDays];
}