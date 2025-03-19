import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_management_app/features/notification/domain/entities/notification.dart';

class NotificationModel extends Notification {
  NotificationModel({
    required super.id,
    required super.title,
    required super.content,
    required super.type,
    required super.targetType,
    required super.targetId,
    required super.priority,
    required super.status,
    required super.sendDate,
    required super.createdBy,
    required super.createdAt,
    required super.recipients,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as String? ?? 'UnknownID',
      title: map['title'] as String? ?? 'UnknownTitle',
      content: map['content'] as String? ?? '',
      type: map['type'] as String? ?? 'UnknownType',
      targetType: map['targetType'] as String? ?? 'UnknownTargetType',
      targetId: map['targetId'] as String? ?? 'UnknownTarget',
      priority: map['priority'] as String? ?? 'UnknownPriority',
      status: map['status'] as String? ?? 'Unknown',
      sendDate: (map['sendDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdBy: map['createdBy'] as String? ?? 'UnknownCreator',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      recipients: (map['recipients'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(
              key,
              Recipient(
                readAt: (value['readAt'] as Timestamp?)?.toDate(),
                readStatus: (value['readStatus'] as bool?) ?? false,
              ),
            ),
          ) ??
          {},
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'type': type,
      'targetType': targetType,
      'targetId': targetId,
      'priority': priority,
      'status': status,
      'sendDate': Timestamp.fromDate(sendDate),
      'createdBy': createdBy,
      'createdAt': Timestamp.fromDate(createdAt),
      'recipients': recipients.map(
        (key, value) => MapEntry(key, {
          'readAt': value.readAt != null ? Timestamp.fromDate(value.readAt!) : null,
          'readStatus': value.readStatus,
        }),
      ),
    };
  }

  Notification toEntity() => this;

  static NotificationModel fromEntity(Notification entity) {
    return NotificationModel(
      id: entity.id,
      title: entity.title,
      content: entity.content,
      type: entity.type,
      targetType: entity.targetType,
      targetId: entity.targetId,
      priority: entity.priority,
      status: entity.status,
      sendDate: entity.sendDate,
      createdBy: entity.createdBy,
      createdAt: entity.createdAt,
      recipients: entity.recipients,
    );
  }
}