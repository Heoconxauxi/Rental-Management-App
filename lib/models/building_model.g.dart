// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BuildingImpl _$$BuildingImplFromJson(Map<String, dynamic> json) =>
    _$BuildingImpl(
      id: json['id'] as String,
      buildingName: json['buildingName'] as String,
      address: json['address'] as String,
      totalRooms: (json['totalRooms'] as num).toInt(),
      managerId: json['managerId'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$BuildingImplToJson(_$BuildingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'buildingName': instance.buildingName,
      'address': instance.address,
      'totalRooms': instance.totalRooms,
      'managerId': instance.managerId,
      'status': instance.status,
    };
