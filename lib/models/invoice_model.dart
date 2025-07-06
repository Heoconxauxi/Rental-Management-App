import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_model.freezed.dart';
part 'invoice_model.g.dart';

@freezed
class Invoice with _$Invoice {
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory Invoice({
    required String id,
    required String contractId,
    required String roomId,
    required String tenantId,
    required String buildingId,
    required int invoiceMonth,
    required int invoiceYear,
    required Fees fees,
    required int totalAmount,
    required String status,
    String? paymentDate,
  }) = _Invoice;

  factory Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);
}

@freezed
class Fees with _$Fees {
  const factory Fees({
    required int roomRent,
    required int electricity,
    required int water,
    required int serviceFee,
    required int parkingFee,
  }) = _Fees;

  factory Fees.fromJson(Map<String, dynamic> json) => _$FeesFromJson(json);
}
