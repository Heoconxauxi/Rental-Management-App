import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_management_app/features/building/domain/entities/building.dart';

class BuildingModel extends Building {
  BuildingModel({
    required super.id,
    required super.buildingName,
    required super.address,
    required super.district,
    required super.city,
    required super.description,
    required super.totalRooms,
    required super.managerId,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    required super.settingsId,
  });

  factory BuildingModel.fromMap(Map<String, dynamic> map) {
    return BuildingModel(
      id: map['id'] as String? ?? 'UnknownID',
      buildingName: map['buildingName'] as String? ?? 'UnknownBuilding',
      address: map['address'] as String? ?? 'UnknownAddress',
      district: map['district'] as String? ?? 'UnknownDistrict',
      city: map['city'] as String? ?? 'UnknownCity',
      description: map['description'] as String? ?? '',
      totalRooms: (map['totalRooms'] as int?) ?? 0,
      managerId: map['managerId'] as String? ?? 'UnknownManager',
      status: map['status'] as String? ?? 'Unknown',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      settingsId: map['settingsId'] as String? ?? 'UnknownSettings',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'buildingName': buildingName,
      'address': address,
      'district': district,
      'city': city,
      'description': description,
      'totalRooms': totalRooms,
      'managerId': managerId,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'settingsId': settingsId,
    };
  }

  Building toEntity() => this;

  static BuildingModel fromEntity(Building building) {
    return BuildingModel(
      id: building.id,
      buildingName: building.buildingName,
      address: building.address,
      district: building.district,
      city: building.city,
      description: building.description,
      totalRooms: building.totalRooms,
      managerId: building.managerId,
      status: building.status,
      createdAt: building.createdAt,
      updatedAt: building.updatedAt,
      settingsId: building.settingsId,
    );
  }
}