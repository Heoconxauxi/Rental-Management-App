import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_management_app/features/building_access/domain/entities/building_access.dart';

class BuildingAccessModel extends BuildingAccess {
  BuildingAccessModel({
    required super.id,
    required super.accountId,
    required super.buildingId,
    required super.accessLevel,
    required super.grantedBy,
    required super.grantedDate,
  });

  factory BuildingAccessModel.fromMap(Map<String, dynamic> map) {
    return BuildingAccessModel(
      id: map['id'] as String? ?? 'UnknownID',
      accountId: map['accountId'] as String? ?? 'UnknownAccount',
      buildingId: map['buildingId'] as String? ?? 'UnknownBuilding',
      accessLevel: map['accessLevel'] as String? ?? 'UnknownLevel',
      grantedBy: map['grantedBy'] as String? ?? 'UnknownGranter',
      grantedDate: (map['grantedDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'accountId': accountId,
      'buildingId': buildingId,
      'accessLevel': accessLevel,
      'grantedBy': grantedBy,
      'grantedDate': Timestamp.fromDate(grantedDate),
    };
  }

  BuildingAccess toEntity() => this;

  static BuildingAccessModel fromEntity(BuildingAccess entity) {
    return BuildingAccessModel(
      id: entity.id,
      accountId: entity.accountId,
      buildingId: entity.buildingId,
      accessLevel: entity.accessLevel,
      grantedBy: entity.grantedBy,
      grantedDate: entity.grantedDate,
    );
  }
}