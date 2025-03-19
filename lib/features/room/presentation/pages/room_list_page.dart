import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_management_app/features/room/presentation/pages/room_detail.dart';
import 'package:rental_management_app/features/room/presentation/pages/room_form_page.dart';
import 'package:rental_management_app/features/room/presentation/providers/room_provider.dart';

class RoomListPage extends ConsumerWidget {
  final String buildingId;

  const RoomListPage({super.key, required this.buildingId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(roomNotifierProvider);
    final notifier = ref.read(roomNotifierProvider.notifier);

    // Chỉ load khi chưa có dữ liệu
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!state.isLoading && state.rooms.isEmpty && state.error == null) {
        notifier.loadRooms(buildingId);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Danh sách phòng')),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text("Lỗi: ${state.error}"))
              : ListView.builder(
                  itemCount: state.rooms.length,
                  itemBuilder: (context, index) {
                    final room = state.rooms[index];
                    return ListTile(
                      title: Text('Phòng ${room.roomNumber} - ${room.roomType}'),
                      subtitle: Text('Tầng ${room.floor} • ${room.status}'),
                      trailing: Text('${room.basePrice.toStringAsFixed(0)}đ'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RoomDetailPage(room: room),
                          ),
                        );
                      },
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomFormPage(buildingId: buildingId),
            ),
          );
        },
        tooltip: 'Thêm phòng mới',
        child: const Icon(Icons.add),
      ),
    );
  }
}
