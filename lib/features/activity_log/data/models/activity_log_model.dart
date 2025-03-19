import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_management_app/features/activity_log/domain/entities/activity_log.dart';

class ActivityLogModel extends ActivityLog {
  ActivityLogModel({
    required super.id,
    required super.userId,
    required super.action,
    required super.collectionName,
    required super.documentId,
    super.oldValues,
    super.newValues,
    required super.ipAddress,
    required super.userAgent,
    required super.timestamp,
  });

  factory ActivityLogModel.fromMap(Map<String, dynamic> map) {
    return ActivityLogModel(
      id: map['id'] as String? ?? 'UnknownID',
      userId: map['userId'] as String? ?? 'UnknownUser',
      action: map['action'] as String? ?? 'UnknownAction',
      collectionName: map['collectionName'] as String? ?? 'UnknownCollection',
      documentId: map['documentId'] as String? ?? 'UnknownDocument',
      oldValues: map['oldValues'] as Map<String, dynamic>?,
      newValues: map['newValues'] as Map<String, dynamic>?,
      ipAddress: map['ipAddress'] as String? ?? 'UnknownIP',
      userAgent: map['userAgent'] as String? ?? 'UnknownAgent',
      timestamp: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'action': action,
      'collectionName': collectionName,
      'documentId': documentId,
      'oldValues': oldValues,
      'newValues': newValues,
      'ipAddress': ipAddress,
      'userAgent': userAgent,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  ActivityLog toEntity() => this;

  static ActivityLogModel fromEntity(ActivityLog entity) {
    return ActivityLogModel(
      id: entity.id,
      userId: entity.userId,
      action: entity.action,
      collectionName: entity.collectionName,
      documentId: entity.documentId,
      oldValues: entity.oldValues,
      newValues: entity.newValues,
      ipAddress: entity.ipAddress,
      userAgent: entity.userAgent,
      timestamp: entity.timestamp,
    );
  }
}