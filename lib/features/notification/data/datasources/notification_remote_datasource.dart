import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/notification_model.dart';
import '../../domain/entities/notification.dart';

abstract class NotificationRemoteDataSource {
  Future<List<Notification>> getNotificationsByRecipient(String recipientId);
  Future<Notification> getNotificationById(String notificationId);
  Future<void> addNotification(Notification notification);
  Future<void> updateNotification(Notification notification);
  Future<void> deleteNotification(String notificationId);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final FirebaseFirestore firestore;

  NotificationRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<Notification>> getNotificationsByRecipient(String recipientId) async {
    final snapshot = await firestore
        .collection('notifications')
        .where('recipients.$recipientId', isNotEqualTo: null)
        .get();
    return snapshot.docs
        .map((doc) => NotificationModel.fromMap(doc.data()).toEntity())
        .toList();
  }

  @override
  Future<Notification> getNotificationById(String notificationId) async {
    final doc = await firestore.collection('notifications').doc(notificationId).get();
    if (!doc.exists) {
      throw Exception('Notification not found');
    }
    return NotificationModel.fromMap(doc.data()!).toEntity();
  }

  @override
  Future<void> addNotification(Notification notification) async {
    final model = NotificationModel.fromEntity(notification);
    await firestore.collection('notifications').doc(notification.id).set(model.toMap());
  }

  @override
  Future<void> updateNotification(Notification notification) async {
    final model = NotificationModel.fromEntity(notification);
    await firestore.collection('notifications').doc(notification.id).update(model.toMap());
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    await firestore.collection('notifications').doc(notificationId).delete();
  }
}