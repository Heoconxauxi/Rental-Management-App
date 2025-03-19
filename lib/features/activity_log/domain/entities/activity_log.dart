class ActivityLog {
  final String id;
  final String userId;
  final String action;
  final String collectionName;
  final String documentId;
  final Map<String, dynamic>? oldValues;
  final Map<String, dynamic>? newValues;
  final String ipAddress;
  final String userAgent;
  final DateTime timestamp;

  const ActivityLog({
    required this.id,
    required this.userId,
    required this.action,
    required this.collectionName,
    required this.documentId,
    this.oldValues,
    this.newValues,
    required this.ipAddress,
    required this.userAgent,
    required this.timestamp,
  });

  List<Object?> get props => [
        id,
        userId,
        action,
        collectionName,
        documentId,
        oldValues,
        newValues,
        ipAddress,
        userAgent,
        timestamp,
      ];
}