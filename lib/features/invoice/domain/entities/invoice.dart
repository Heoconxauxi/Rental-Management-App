class Invoice {
  final String id;
  final String invoiceNumber;
  final String contractId;
  final String roomId;
  final String tenantId;
  final String buildingId;
  final int invoiceMonth;
  final int invoiceYear;
  final Fees fees;
  final double totalAmount;
  final Payment payment;
  final DateTime issueDate;
  final DateTime dueDate;
  final String notes;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Invoice({
    required this.id,
    required this.invoiceNumber,
    required this.contractId,
    required this.roomId,
    required this.tenantId,
    required this.buildingId,
    required this.invoiceMonth,
    required this.invoiceYear,
    required this.fees,
    required this.totalAmount,
    required this.payment,
    required this.issueDate,
    required this.dueDate,
    required this.notes,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
  });

  List<Object?> get props => [
        id,
        invoiceNumber,
        contractId,
        roomId,
        tenantId,
        buildingId,
        invoiceMonth,
        invoiceYear,
        fees,
        totalAmount,
        payment,
        issueDate,
        dueDate,
        notes,
        createdBy,
        createdAt,
        updatedAt,
      ];
}

class Fees {
  final double roomRent;
  final UtilityFee electricity;
  final UtilityFee water;
  final double serviceFee;
  final double internetFee;
  final double parkingFee;
  final double otherFees;
  final String otherFeesDescription;

  const Fees({
    required this.roomRent,
    required this.electricity,
    required this.water,
    required this.serviceFee,
    required this.internetFee,
    required this.parkingFee,
    required this.otherFees,
    required this.otherFeesDescription,
  });

  List<Object?> get props => [
        roomRent,
        electricity,
        water,
        serviceFee,
        internetFee,
        parkingFee,
        otherFees,
        otherFeesDescription,
      ];
}

class UtilityFee {
  final int usage;
  final double price;
  final double amount;

  const UtilityFee({
    required this.usage,
    required this.price,
    required this.amount,
  });

  List<Object?> get props => [usage, price, amount];
}

class Payment {
  final String status;
  final double paidAmount;
  final double remainingAmount;
  final DateTime? paymentDate;
  final String? paymentMethod;

  const Payment({
    required this.status,
    required this.paidAmount,
    required this.remainingAmount,
    this.paymentDate,
    this.paymentMethod,
  });

  List<Object?> get props => [
        status,
        paidAmount,
        remainingAmount,
        paymentDate,
        paymentMethod,
      ];
}
