import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_management_app/core/services/notification_service.dart';
import 'package:rental_management_app/models/notification_model.dart';

/// Provider cho NotificationService
final notificationServiceProvider = Provider<NotificationService>((ref) => NotificationService());

/// Stream toàn bộ thông báo (thời gian thực)
final allNotificationsStreamProvider = StreamProvider<List<NotificationMessage>>((ref) {
  final service = ref.read(notificationServiceProvider);
  return service.getAllNotificationsStream();
});

/// Stream thông báo theo userId (thời gian thực)
final userNotificationsStreamProvider = StreamProvider.family<List<NotificationMessage>, String>((ref, userId) {
  final service = ref.read(notificationServiceProvider);
  return service.getNotificationsByUserIdStream(userId);
});

/// Future toàn bộ thông báo (tải một lần)
final allNotificationsProvider = FutureProvider<List<NotificationMessage>>((ref) {
  final service = ref.read(notificationServiceProvider);
  return service.getAllNotifications();
});

/// Future thông báo theo userId (tải một lần)
final userNotificationsProvider = FutureProvider.family<List<NotificationMessage>, String>((ref, userId) {
  final service = ref.read(notificationServiceProvider);
  return service.getNotificationsByUserId(userId);
});