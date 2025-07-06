  import 'package:freezed_annotation/freezed_annotation.dart';

  part 'tenant_model.freezed.dart';
  part 'tenant_model.g.dart';

  @freezed
  class Tenant with _$Tenant {
    const factory Tenant({
      required String id,
      String? accountId,
      required String fullName,
      required String phone,
      required String email,
      required String gender,
      required String occupation,
      required String workplace,
      required int monthlyIncome,
      required String status,
      String? currentRoomId,
    }) = _Tenant;

    factory Tenant.fromJson(Map<String, dynamic> json) => _$TenantFromJson(json);
  }
