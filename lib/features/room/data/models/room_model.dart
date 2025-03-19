import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_management_app/features/room/domain/entities/room.dart';

class RoomModel extends Room {
  RoomModel({
    required super.id,
    required super.buildingId,
    required super.roomNumber,
    required super.roomType,
    required super.area,
    required super.basePrice,
    required super.depositAmount,
    required super.status,
    required super.description,
    required super.amenities,
    required super.maxOccupants,
    required super.floor,
    required super.createdAt,
    required super.updatedAt,
    super.currentTenant,
  });

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'] as String? ?? 'UnknownID',
      buildingId: map['buildingId'] as String? ?? 'UnknownBuilding',
      roomNumber: map['roomNumber'] as String? ?? 'UnknownNumber',
      roomType: map['roomType'] as String? ?? 'UnknownType',
      area: (map['area'] as num?)?.toDouble() ?? 0.0,
      basePrice: (map['basePrice'] as num?)?.toDouble() ?? 0.0,
      depositAmount: (map['depositAmount'] as num?)?.toDouble() ?? 0.0,
      status: map['status'] as String? ?? 'Unknown',
      description: map['description'] as String? ?? '',
      amenities: Amenities(
        wifi: (map['amenities']?['wifi'] as bool?) ?? false,
        airConditioner: (map['amenities']?['airConditioner'] as bool?) ?? false,
        fridge: (map['amenities']?['fridge'] as bool?) ?? false,
        washingMachine: (map['amenities']?['washingMachine'] as bool?) ?? false,
        balcony: (map['amenities']?['balcony'] as bool?) ?? false,
        privateToilet: (map['amenities']?['privateToilet'] as bool?) ?? false,
        hotWater: (map['amenities']?['hotWater'] as bool?) ?? false,
      ),
      maxOccupants: (map['maxOccupants'] as int?) ?? 0,
      floor: (map['floor'] as int?) ?? 0,
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      currentTenant: map['currentTenant'] != null
          ? CurrentTenant(
              tenantId: map['currentTenant']['tenantId'] as String? ?? 'UnknownTenantID',
              tenantName: map['currentTenant']['tenantName'] as String? ?? 'UnknownTenant',
              contractId: map['currentTenant']['contractId'] as String? ?? 'UnknownContract',
              moveInDate: (map['currentTenant']['moveInDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
            )
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'buildingId': buildingId,
      'roomNumber': roomNumber,
      'roomType': roomType,
      'area': area,
      'basePrice': basePrice,
      'depositAmount': depositAmount,
      'status': status,
      'description': description,
      'amenities': {
        'wifi': amenities.wifi,
        'airConditioner': amenities.airConditioner,
        'fridge': amenities.fridge,
        'washingMachine': amenities.washingMachine,
        'balcony': amenities.balcony,
        'privateToilet': amenities.privateToilet,
        'hotWater': amenities.hotWater,
      },
      'maxOccupants': maxOccupants,
      'floor': floor,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'currentTenant': currentTenant != null
          ? {
              'tenantId': currentTenant!.tenantId,
              'tenantName': currentTenant!.tenantName,
              'contractId': currentTenant!.contractId,
              'moveInDate': Timestamp.fromDate(currentTenant!.moveInDate),
            }
          : null,
    };
  }

  Room toEntity() => this;

  static RoomModel fromEntity(Room room) {
    return RoomModel(
      id: room.id,
      buildingId: room.buildingId,
      roomNumber: room.roomNumber,
      roomType: room.roomType,
      area: room.area,
      basePrice: room.basePrice,
      depositAmount: room.depositAmount,
      status: room.status,
      description: room.description,
      amenities: room.amenities,
      maxOccupants: room.maxOccupants,
      floor: room.floor,
      createdAt: room.createdAt,
      updatedAt: room.updatedAt,
      currentTenant: room.currentTenant,
    );
  }
}

extension CurrentTenantExtension on CurrentTenant {
  Map<String, dynamic>? toMap() {
    return {
      'tenantId': tenantId,
      'tenantName': tenantName,
      'contractId': contractId,
      'moveInDate': Timestamp.fromDate(moveInDate),
    };
  }
}