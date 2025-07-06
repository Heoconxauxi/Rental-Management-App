import 'package:freezed_annotation/freezed_annotation.dart';

part 'contract_model.freezed.dart';
part 'contract_model.g.dart';

@freezed
class Contract with _$Contract {
  const factory Contract({
    required String id,
    required String contractNumber,
    required String roomId,
    required String tenantId,
    required String buildingId,
    required String startDate,
    required String endDate,
    required int monthlyRent,
    required int depositPaid,
    required String status,
    required String createdBy,
  }) = _Contract;

  factory Contract.fromJson(Map<String, dynamic> json) => _$ContractFromJson(json);
}
