// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
  id: json['id'] as String,
  buildingId: json['buildingId'] as String,
  roomNumber: json['roomNumber'] as String,
  roomType: json['roomType'] as String,
  area: (json['area'] as num).toDouble(),
  basePrice: (json['basePrice'] as num).toInt(),
  depositAmount: (json['depositAmount'] as num).toInt(),
  status: json['status'] as String,
  maxOccupants: (json['maxOccupants'] as num).toInt(),
  floor: (json['floor'] as num).toInt(),
  amenities: Map<String, bool>.from(json['amenities'] as Map),
  currentTenantId: json['currentTenantId'] as String?,
);

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'buildingId': instance.buildingId,
      'roomNumber': instance.roomNumber,
      'roomType': instance.roomType,
      'area': instance.area,
      'basePrice': instance.basePrice,
      'depositAmount': instance.depositAmount,
      'status': instance.status,
      'maxOccupants': instance.maxOccupants,
      'floor': instance.floor,
      'amenities': instance.amenities,
      'currentTenantId': instance.currentTenantId,
    };
