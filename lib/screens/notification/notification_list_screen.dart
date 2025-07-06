import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/notification_model.dart';
import '../../providers/notification_provider.dart';

class NotificationListScreen extends ConsumerWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(allNotificationsProvider);
    final notificationService = ref.read(notificationServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông báo',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: notificationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.black)),
        error: (e, _) => Center(child: Text('Lỗi: $e', style: const TextStyle(color: Colors.black))),
        data: (notifications) {
          if (notifications.isEmpty) {
            return const Center(child: Text('Không có thông báo nào', style: TextStyle(color: Colors.black)));
          }

          // Nhóm thông báo theo targetType
          final groupedNotifications = <String, List<NotificationMessage>>{};
          for (var noti in notifications) {
            groupedNotifications.putIfAbsent(noti.targetType, () => []).add(noti);
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: groupedNotifications.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final targetType = groupedNotifications.keys.elementAt(index);
              final notifications = groupedNotifications[targetType]!;

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ExpansionTile(
                  title: Text(
                    _translateTargetType(targetType),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  collapsedBackgroundColor: Colors.white,
                  children: notifications.map((noti) {
                    final isUnread = noti.status == 'unread';

                    return InkWell(
                      onTap: () async {
                        if (isUnread) {
                          await notificationService.markAsRead(noti.id);
                          ref.invalidate(allNotificationsProvider);
                        }
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            backgroundColor: Colors.white,
                            title: Text(
                              noti.title,
                              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDetailRow('Nội dung:', noti.content),
                                  _buildDetailRow('Loại:', _translateTargetType(noti.targetType)),
                                  _buildDetailRow('Trạng thái:', _translateStatus(noti.status)),
                                  _buildDetailRow('Ngày gửi:', _formatDate(noti.sendDate)),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Đóng', style: TextStyle(color: Colors.black)),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    noti.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    noti.content,
                                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            if (isUnread)
                              const Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Icon(Icons.circle, color: Colors.red, size: 10),
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  String _translateStatus(String status) {
    switch (status.toLowerCase()) {
      case 'unread':
        return 'Chưa đọc';
      case 'readed':
        return 'Đã đọc';
      default:
        return status;
    }
  }

  String _translateTargetType(String targetType) {
    switch (targetType.toLowerCase()) {
      case 'tenant':
        return 'Người thuê';
      case 'manager':
        return 'Quản lý';
      default:
        return targetType;
    }
  }

  String _formatDate(String isoDate) {
    final date = DateTime.parse(isoDate);
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}