import 'package:flutter/material.dart';
import '../../models/room_model.dart';

class AdminRoomDetailScreen extends StatelessWidget {
  final Room room;

  const AdminRoomDetailScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phòng ${room.roomNumber}'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildInfoTile('Loại phòng', room.roomType),
          _buildInfoTile('Diện tích', '${room.area} m²'),
          _buildInfoTile('Tầng', room.floor.toString()),
          _buildInfoTile('Số người tối đa', room.maxOccupants.toString()),
          _buildInfoTile('Giá cơ bản', '${room.basePrice} VNĐ'),
          _buildInfoTile('Tiền đặt cọc', '${room.depositAmount} VNĐ'),
          _buildInfoTile('Trạng thái', _translateStatus(room.status)),
          const SizedBox(height: 12),
          const Text('Tiện ích', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          ...room.amenities.entries
              .where((entry) => entry.value)
              .map((entry) => ListTile(
                    leading: const Icon(Icons.check_circle, color: Colors.green),
                    title: Text(_formatAmenity(entry.key)),
                  )),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }

  String _formatAmenity(String key) {
    switch (key) {
      case 'wifi': return 'Wi-Fi';
      case 'airConditioner': return 'Máy lạnh';
      case 'fridge': return 'Tủ lạnh';
      case 'hotWater': return 'Nước nóng';
      case 'privateToilet': return 'Toilet riêng';
      case 'washingMachine': return 'Máy giặt';
      case 'balcony': return 'Ban công';
      default: return key;
    }
  }

  String _translateStatus(String status) {
    switch (status.toLowerCase()) {
      case 'active': return 'Hoạt động';
      case 'maintenance': return 'Sửa chữa';
      default: return status;
    }
  }
}