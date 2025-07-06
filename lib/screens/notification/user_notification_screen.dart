import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../providers/notification_provider.dart';

class UserNotificationScreen extends ConsumerWidget {
  const UserNotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(appUserProvider);

    return userAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.black)),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('Lỗi: $e', style: const TextStyle(color: Colors.black))),
      ),
      data: (user) {
        if (user == null) {
          print('User is null');
          return const Scaffold(
            body: Center(child: Text('Không tìm thấy người dùng', style: TextStyle(color: Colors.black))),
          );
        }

        print('User ID: ${user.id}');
        final notificationsAsync = ref.watch(userNotificationsStreamProvider(user.id));
        final notificationService = ref.read(notificationServiceProvider);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Thông báo của tôi',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            elevation: 1,
          ),
          backgroundColor: Colors.white,
          body: notificationsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator(color: Colors.black)),
            error: (e, stack) {
              print('Error fetching notifications: $e\n$stack');
              return Center(child: Text('Lỗi: $e', style: const TextStyle(color: Colors.black)));
            },
            data: (notifications) {
              print('Notifications count: ${notifications.length}');
              if (notifications.isEmpty) {
                return const Center(child: Text('Không có thông báo nào', style: TextStyle(color: Colors.black)));
              }

              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: notifications.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final noti = notifications[index];
                  final isUnread = noti.status == 'unread';

                  return InkWell(
                    onTap: () async {
                      if (isUnread) {
                        await notificationService.markAsRead(noti.id);
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
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(12),
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
                                    fontSize: 18,
                                    fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  noti.content,
                                  style: const TextStyle(fontSize: 16, color: Colors.black87),
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
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start, // Đảm bảo nội dung dài không bị cắt
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8), // Khoảng cách giữa label và value
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
              softWrap: true, // Cho phép ngắt dòng
              overflow: TextOverflow.visible, // Hiển thị toàn bộ nội dung, ngắt dòng nếu cần
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