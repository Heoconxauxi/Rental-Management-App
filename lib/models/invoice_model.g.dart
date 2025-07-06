// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvoiceImpl _$$InvoiceImplFromJson(Map<String, dynamic> json) =>
    _$InvoiceImpl(
      id: json['id'] as String,
      contractId: json['contractId'] as String,
      roomId: json['roomId'] as String,
      tenantId: json['tenantId'] as String,
      buildingId: json['buildingId'] as String,
      invoiceMonth: (json['invoiceMonth'] as num).toInt(),
      invoiceYear: (json['invoiceYear'] as num).toInt(),
      fees: Fees.fromJson(json['fees'] as Map<String, dynamic>),
      totalAmount: (json['totalAmount'] as num).toInt(),
      status: json['status'] as String,
      paymentDate: json['paymentDate'] as String?,
    );

Map<String, dynamic> _$$InvoiceImplToJson(_$InvoiceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contractId': instance.contractId,
      'roomId': instance.roomId,
      'tenantId': instance.tenantId,
      'buildingId': instance.buildingId,
      'invoiceMonth': instance.invoiceMonth,
      'invoiceYear': instance.invoiceYear,
      'fees': instance.fees.toJson(),
      'totalAmount': instance.totalAmount,
      'status': instance.status,
      'paymentDate': instance.paymentDate,
    };

_$FeesImpl _$$FeesImplFromJson(Map<String, dynamic> json) => _$FeesImpl(
  roomRent: (json['roomRent'] as num).toInt(),
  electricity: (json['electricity'] as num).toInt(),
  water: (json['water'] as num).toInt(),
  serviceFee: (json['serviceFee'] as num).toInt(),
  parkingFee: (json['parkingFee'] as num).toInt(),
);

Map<String, dynamic> _$$FeesImplToJson(_$FeesImpl instance) =>
    <String, dynamic>{
      'roomRent': instance.roomRent,
      'electricity': instance.electricity,
      'water': instance.water,
      'serviceFee': instance.serviceFee,
      'parkingFee': instance.parkingFee,
    };
