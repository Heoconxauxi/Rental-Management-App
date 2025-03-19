import 'package:flutter/material.dart';
import 'package:rental_management_app/features/room/domain/entities/room.dart';

class RoomDetailPage extends StatelessWidget {
  final Room room;

  const RoomDetailPage({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    final a = room.amenities;
    final ct = room.currentTenant;

    return Scaffold(
      appBar: AppBar(title: Text('Phòng ${room.roomNumber}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Loại phòng: ${room.roomType}'),
            Text('Tầng: ${room.floor}'),
            Text('Diện tích: ${room.area} m²'),
            Text('Giá cơ bản: ${room.basePrice.toStringAsFixed(0)}đ'),
            Text('Tiền cọc: ${room.depositAmount.toStringAsFixed(0)}đ'),
            Text('Trạng thái: ${room.status}'),
            const SizedBox(height: 12),
            Text('Tiện nghi:', style: const TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: [
                if (a.wifi) const Chip(label: Text('WiFi')),
                if (a.airConditioner) const Chip(label: Text('Điều hòa')),
                if (a.fridge) const Chip(label: Text('Tủ lạnh')),
                if (a.washingMachine) const Chip(label: Text('Máy giặt')),
                if (a.balcony) const Chip(label: Text('Ban công')),
                if (a.privateToilet) const Chip(label: Text('WC riêng')),
                if (a.hotWater) const Chip(label: Text('Nước nóng')),
              ],
            ),
            const SizedBox(height: 12),
            if (ct != null) ...[
              const Text('Người đang thuê:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Họ tên: ${ct.tenantName}'),
              Text('Mã hợp đồng: ${ct.contractId}'),
              Text('Ngày vào ở: ${ct.moveInDate.toLocal().toString().split(' ')[0]}'),
            ],
            if (ct == null)
              const Text('Phòng đang trống.', style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
