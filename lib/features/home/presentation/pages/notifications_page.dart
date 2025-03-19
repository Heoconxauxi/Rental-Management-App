import 'package:flutter/material.dart';

class _NotificationItem {
  final String title;
  final String subtitle;
  final String timeAgo;
  bool isRead;

  _NotificationItem({
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    this.isRead = false,
  });
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<_NotificationItem> _notifications = [
    _NotificationItem(
      title: 'Thông báo hệ thống',
      subtitle: 'Hệ thống sẽ bảo trì vào 22h tối nay.',
      timeAgo: '5 phút trước',
      isRead: false,
    ),
    _NotificationItem(
      title: 'Thanh toán tiền trọ',
      subtitle: 'Vui lòng thanh toán tiền phòng trước ngày 5 hàng tháng.',
      timeAgo: '2 giờ trước',
      isRead: false,
    ),
    _NotificationItem(
      title: 'Cập nhật hợp đồng',
      subtitle: 'Hợp đồng thuê trọ mới đã được cập nhật.',
      timeAgo: '1 ngày trước',
      isRead: true,
    ),
  ];

  void _markAsRead(int index) {
    setState(() {
      _notifications[index].isRead = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã đọc: ${_notifications[index].title}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thông báo")),
      body: ListView.separated(
        itemCount: _notifications.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final item = _notifications[index];
          return Dismissible(
            key: Key(item.title + index.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              setState(() {
                _notifications.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đã xoá: ${item.title}')),
              );
            },
            child: ListTile(
              leading: Icon(
                item.isRead ? Icons.notifications_none : Icons.notifications_active,
                color: item.isRead ? Colors.grey : Colors.blueAccent,
              ),
              title: Text(item.title),
              subtitle: Text(item.subtitle),
              trailing: Text(
                item.timeAgo,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              onTap: () => _markAsRead(index),
            ),
          );
        },
      ),
    );
  }
}

class NotificationPage2 extends StatefulWidget {
  const NotificationPage2({super.key});

  @override
  State<NotificationPage2> createState() => _NotificationPage2State();
}

class _NotificationPage2State extends State<NotificationPage2> {
  final List<_NotificationItem> _notifications = [
    _NotificationItem(
      title: 'Thông báo hệ thống',
      subtitle: 'Hệ thống sẽ bảo trì vào 22h tối nay.',
      timeAgo: '5 phút trước',
      isRead: false,
    ),
    _NotificationItem(
      title: 'Thanh toán tiền trọ',
      subtitle: 'Vui lòng thanh toán tiền phòng trước ngày 5 hàng tháng.',
      timeAgo: '2 giờ trước',
      isRead: false,
    ),
    _NotificationItem(
      title: 'Cập nhật hợp đồng',
      subtitle: 'Hợp đồng thuê trọ mới đã được cập nhật.',
      timeAgo: '1 ngày trước',
      isRead: true,
    ),
  ];

  void _markAsRead(int index) {
    setState(() {
      _notifications[index].isRead = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã đọc: ${_notifications[index].title}')),
    );
  }

  List<double> _dragOffsets = [];

  final double maxDrag = -80;

  @override
  void initState() {
    super.initState();
    _dragOffsets = List.filled(_notifications.length, 0);
  }

  void _deleteItem(int index) {
    setState(() {
      _dragOffsets[index] = 0;
    });
    setState(() {
      _notifications.removeAt(index);
      _dragOffsets.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Thông báo")),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Positioned.fill(
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 16),
                  child: GestureDetector(
                    onTap: () => _deleteItem(index),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    _dragOffsets[index] += details.delta.dx;
                    if (_dragOffsets[index] > 0) _dragOffsets[index] = 0;
                    if (_dragOffsets[index] < maxDrag) _dragOffsets[index] = maxDrag;
                  });
                },
                onHorizontalDragEnd: (details) {
                  setState(() {
                    if (_dragOffsets[index] < maxDrag / 2) {
                      _dragOffsets[index] = maxDrag;
                    } else {
                      _dragOffsets[index] = 0;
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  transform: Matrix4.translationValues(_dragOffsets[index], 0, 0),
                  child: Card(
                    child: ListTile(
                      leading: Icon(
                        _notifications[index].isRead ? Icons.notifications_none : Icons.notifications_active,
                        color: _notifications[index].isRead ? Colors.grey : Colors.blueAccent,
                      ),
                      title: Text(_notifications[index].title),
                      subtitle: Text(_notifications[index].subtitle),
                      trailing: Text(
                        _notifications[index].timeAgo,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      onTap: () => _markAsRead(index),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
