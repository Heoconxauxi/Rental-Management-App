// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContractImpl _$$ContractImplFromJson(Map<String, dynamic> json) =>
    _$ContractImpl(
      id: json['id'] as String,
      contractNumber: json['contractNumber'] as String,
      roomId: json['roomId'] as String,
      tenantId: json['tenantId'] as String,
      buildingId: json['buildingId'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      monthlyRent: (json['monthlyRent'] as num).toInt(),
      depositPaid: (json['depositPaid'] as num).toInt(),
      status: json['status'] as String,
      createdBy: json['createdBy'] as String,
    );

Map<String, dynamic> _$$ContractImplToJson(_$ContractImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contractNumber': instance.contractNumber,
      'roomId': instance.roomId,
      'tenantId': instance.tenantId,
      'buildingId': instance.buildingId,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'monthlyRent': instance.monthlyRent,
      'depositPaid': instance.depositPaid,
      'status': instance.status,
      'createdBy': instance.createdBy,
    };
