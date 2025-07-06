// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tenant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TenantImpl _$$TenantImplFromJson(Map<String, dynamic> json) => _$TenantImpl(
  id: json['id'] as String,
  accountId: json['accountId'] as String?,
  fullName: json['fullName'] as String,
  phone: json['phone'] as String,
  email: json['email'] as String,
  gender: json['gender'] as String,
  occupation: json['occupation'] as String,
  workplace: json['workplace'] as String,
  monthlyIncome: (json['monthlyIncome'] as num).toInt(),
  status: json['status'] as String,
  currentRoomId: json['currentRoomId'] as String?,
);

Map<String, dynamic> _$$TenantImplToJson(_$TenantImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'accountId': instance.accountId,
      'fullName': instance.fullName,
      'phone': instance.phone,
      'email': instance.email,
      'gender': instance.gender,
      'occupation': instance.occupation,
      'workplace': instance.workplace,
      'monthlyIncome': instance.monthlyIncome,
      'status': instance.status,
      'currentRoomId': instance.currentRoomId,
    };
