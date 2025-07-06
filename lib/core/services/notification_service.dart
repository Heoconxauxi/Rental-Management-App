import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_management_app/models/notification_model.dart';

class NotificationService {
  final _collection = FirebaseFirestore.instance.collection('notifications');

  // Lấy tất cả thông báo (Future)
  Future<List<NotificationMessage>> getAllNotifications() async {
    final snapshot = await _collection.orderBy('sendDate', descending: true).get();
    return snapshot.docs.map((doc) => NotificationMessage.fromJson(doc.data())).toList();
  }

  // Lấy tất cả thông báo theo thời gian thực (Stream)
  Stream<List<NotificationMessage>> getAllNotificationsStream() {
    return _collection
        .orderBy('sendDate', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NotificationMessage.fromJson(doc.data()))
            .toList());
  }

  // Lấy thông báo theo userId (Future)
  Future<List<NotificationMessage>> getNotificationsByUserId(String userId) async {
    final snapshot = await _collection
        .where('targetId', isEqualTo: userId)
        .orderBy('sendDate', descending: true)
        .get();
    return snapshot.docs.map((doc) => NotificationMessage.fromJson(doc.data())).toList();
  }

  // Lấy thông báo theo userId theo thời gian thực (Stream)
  Stream<List<NotificationMessage>> getNotificationsByUserIdStream(String userId) {
    return _collection
        .where('targetId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NotificationMessage.fromJson(doc.data()))
            .toList());
  }

  // Đánh dấu thông báo đã đọc
  Future<void> markAsRead(String id) async {
    await _collection.doc(id).update({'status': 'readed'});
  }

  // Gửi thông báo
  Future<void> sendNotification({
    required String title,
    required String content,
    required String targetType,
    required String targetId,
  }) async {
    final message = NotificationMessage(
      id: _collection.doc().id,
      title: title,
      content: content,
      targetType: targetType,
      targetId: targetId,
      sendDate: DateTime.now().toIso8601String(),
      status: 'unread',
    );

    await _collection.doc(message.id).set(message.toJson());
  }
}