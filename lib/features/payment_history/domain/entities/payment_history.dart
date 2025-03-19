class PaymentHistory {
  final String id;
  final String invoiceId;
  final double paymentAmount;
  final DateTime paymentDate;
  final String paymentMethod;
  final String transactionReference;
  final String notes;
  final String recordedBy;
  final DateTime createdAt;

  const PaymentHistory({
    required this.id,
    required this.invoiceId,
    required this.paymentAmount,
    required this.paymentDate,
    required this.paymentMethod,
    required this.transactionReference,
    required this.notes,
    required this.recordedBy,
    required this.createdAt,
  });

  List<Object?> get props => [
        id,
        invoiceId,
        paymentAmount,
        paymentDate,
        paymentMethod,
        transactionReference,
        notes,
        recordedBy,
        createdAt,
      ];
}