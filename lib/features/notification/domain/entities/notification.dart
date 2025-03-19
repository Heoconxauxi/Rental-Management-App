class Notification {
  final String id;
  final String title;
  final String content;
  final String type;
  final String targetType;
  final String targetId;
  final String priority;
  final String status;
  final DateTime sendDate;
  final String createdBy;
  final DateTime createdAt;
  final Map<String, Recipient> recipients;

  const Notification({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.targetType,
    required this.targetId,
    required this.priority,
    required this.status,
    required this.sendDate,
    required this.createdBy,
    required this.createdAt,
    required this.recipients,
  });

  List<Object?> get props => [
        id,
        title,
        content,
        type,
        targetType,
        targetId,
        priority,
        status,
        sendDate,
        createdBy,
        createdAt,
        recipients,
      ];
}

class Recipient {
  final DateTime? readAt;
  final bool readStatus;

  const Recipient({
    this.readAt,
    required this.readStatus,
  });

  List<Object?> get props => [readAt, readStatus];
}