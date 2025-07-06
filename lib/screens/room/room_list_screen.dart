import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/room_model.dart';
import '../../providers/room_provider.dart';

class RoomListScreen extends ConsumerStatefulWidget {
  final String buildingId;

  const RoomListScreen({super.key, required this.buildingId});

  @override
  ConsumerState<RoomListScreen> createState() => _RoomListScreenState();
}

class _RoomListScreenState extends ConsumerState<RoomListScreen> {
  bool changed = false;

  @override
  Widget build(BuildContext context) {
    final roomsAsync = ref.watch(roomsByBuildingProvider(widget.buildingId));
    final roomService = ref.read(roomServiceProvider);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, changed);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Danh sách phòng'),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: roomsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Lỗi: $e')),
          data: (rooms) => ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (context, index) {
              final room = rooms[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                color: Colors.grey[100],
                child: ListTile(
                  title: Text('Phòng ${room.roomNumber}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${room.roomType}, ${room.area} m²\nTrạng thái: ${room.status}'),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () => _showRoomDialog(context, ref, room: room),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Xác nhận xoá'),
                              content: Text('Xoá phòng ${room.roomNumber}'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Huỷ')),
                                TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Xoá')),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            await roomService.deleteRoom(room.id);
                            setState(() => changed = true);
                          }
                        },
                      ),
                    ],
                  ),
                    onTap: () => context.push('/admin-room-detail', extra: room),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showRoomDialog(context, ref),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  void _showRoomDialog(BuildContext context, WidgetRef parentRef, {Room? room}) {
    final roomNumberCtrl = TextEditingController(text: room?.roomNumber ?? '');
    final areaCtrl = TextEditingController(text: room?.area.toString() ?? '');
    final basePriceCtrl = TextEditingController(text: room?.basePrice.toString() ?? '');
    final depositCtrl = TextEditingController(text: room?.depositAmount.toString() ?? '');
    final maxOccupantsCtrl = TextEditingController(text: room?.maxOccupants.toString() ?? '');
    final floorCtrl = TextEditingController(text: room?.floor.toString() ?? '');
    String status = room?.status ?? 'available';
    String roomType = room?.roomType ?? 'standard';

    final validStatuses = ['available', 'occupied', 'maintenance'];
    final validRoomTypes = ['standard', 'vip', 'studio'];
    if (!validStatuses.contains(status)) status = 'available';
    if (!validRoomTypes.contains(roomType)) roomType = 'standard';

    final availableAmenities = [
      'wifi',
      'airConditioner',
      'fridge',
      'hotWater',
      'privateToilet',
      'washingMachine',
      'balcony',
    ];

    final amenitiesProvider = StateProvider<Map<String, bool>>((ref) {
      return room?.amenities ?? {for (var a in availableAmenities) a: false};
    });

    showDialog(
      context: context,
      builder: (dialogContext) => Consumer(
        builder: (context, ref, _) {
          final amenities = ref.watch(amenitiesProvider);

          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(room == null ? 'Thêm phòng' : 'Chỉnh sửa phòng'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: roomNumberCtrl, decoration: const InputDecoration(labelText: 'Số phòng', border: OutlineInputBorder())),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: roomType,
                    decoration: const InputDecoration(labelText: 'Loại phòng', border: OutlineInputBorder()),
                    items: validRoomTypes.map((type) => DropdownMenuItem(value: type, child: Text(type))).toList(),
                    onChanged: (value) => roomType = value!,
                  ),
                  const SizedBox(height: 8),
                  TextField(controller: areaCtrl, decoration: const InputDecoration(labelText: 'Diện tích (m²)', border: OutlineInputBorder()), keyboardType: TextInputType.number),
                  const SizedBox(height: 8),
                  TextField(controller: basePriceCtrl, decoration: const InputDecoration(labelText: 'Giá cơ bản', border: OutlineInputBorder()), keyboardType: TextInputType.number),
                  const SizedBox(height: 8),
                  TextField(controller: depositCtrl, decoration: const InputDecoration(labelText: 'Tiền đặt cọc', border: OutlineInputBorder()), keyboardType: TextInputType.number),
                  const SizedBox(height: 8),
                  TextField(controller: maxOccupantsCtrl, decoration: const InputDecoration(labelText: 'Số người tối đa', border: OutlineInputBorder()), keyboardType: TextInputType.number),
                  const SizedBox(height: 8),
                  TextField(controller: floorCtrl, decoration: const InputDecoration(labelText: 'Tầng', border: OutlineInputBorder()), keyboardType: TextInputType.number),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: status,
                    decoration: const InputDecoration(labelText: 'Trạng thái', border: OutlineInputBorder()),
                    items: validStatuses.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                    onChanged: (value) => status = value!,
                  ),
                  const SizedBox(height: 12),
                  const Text('Tiện ích', style: TextStyle(fontWeight: FontWeight.bold)),
                  ...availableAmenities.map((amenity) {
                    return CheckboxListTile(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                      title: Text(amenity),
                      value: amenities[amenity] ?? false,
                      onChanged: (value) {
                        ref.read(amenitiesProvider.notifier).update((map) => {
                              ...map,
                              amenity: value ?? false,
                            });
                      },
                    );
                  }),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Huỷ')),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () async {
                  final roomNumber = roomNumberCtrl.text.trim();
                  final area = double.tryParse(areaCtrl.text) ?? 0;
                  final basePrice = int.tryParse(basePriceCtrl.text) ?? 0;
                  final deposit = int.tryParse(depositCtrl.text) ?? 0;
                  final maxOccupants = int.tryParse(maxOccupantsCtrl.text) ?? 0;
                  final floor = int.tryParse(floorCtrl.text) ?? 0;
                  final amenitiesData = ref.read(amenitiesProvider);

                  if (roomNumber.isEmpty || area <= 0 || basePrice <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Vui lòng nhập đủ thông tin hợp lệ')),
                    );
                    return;
                  }

                  final service = parentRef.read(roomServiceProvider);

                  if (room == null) {
                    final newRoom = Room(
                      id: '',
                      buildingId: widget.buildingId,
                      roomNumber: roomNumber,
                      roomType: roomType,
                      area: area,
                      basePrice: basePrice,
                      depositAmount: deposit,
                      status: status,
                      maxOccupants: maxOccupants,
                      floor: floor,
                      amenities: amenitiesData,
                      currentTenantId: null,
                    );
                    await service.addRoom(newRoom);
                  } else {
                    final updated = room.copyWith(
                      roomNumber: roomNumber,
                      roomType: roomType,
                      area: area,
                      basePrice: basePrice,
                      depositAmount: deposit,
                      status: status,
                      maxOccupants: maxOccupants,
                      floor: floor,
                      amenities: amenitiesData,
                    );
                    await service.updateRoom(updated);
                  }

                  setState(() => changed = true);
                  Navigator.pop(context);
                },
                child: const Text('Lưu', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }
}
