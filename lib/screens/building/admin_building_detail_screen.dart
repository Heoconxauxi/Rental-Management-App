import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../models/building_model.dart';
import '../../providers/user_provider.dart';

class AdminBuildingDetailScreen extends ConsumerWidget {
  final Building building;

  const AdminBuildingDetailScreen({super.key, required this.building});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userByIdProvider(building.managerId));

    return Scaffold(
      appBar: AppBar(
        title: Text(building.buildingName),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle('Thông tin tòa nhà'),
          _infoCard([
            _infoTile('Tên', building.buildingName),
            _infoTile('Địa chỉ', building.address),
            _infoTile('Tổng số phòng', building.totalRooms.toString()),
            _infoTile('Trạng thái', _translateStatus(building.status)),
          ]),
          const SizedBox(height: 20),
          _sectionTitle('Người quản lý'),
          userAsync.when(
            loading: () => const Center(child: CircularProgressIndicator(color: Colors.black)),
            error: (e, _) => Text('Lỗi: $e', style: const TextStyle(color: Colors.black)),
            data: (user) => _infoCard([
              _infoTile('Tên', user!.fullName),
              _infoTile('Email', user.email),
              _infoTile('SĐT', user.phone),
            ]),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              context.push('/rooms/${building.id}', extra: building);
            },
            label: const Text('Xem danh sách phòng'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }

  Widget _infoTile(String label, String value) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      subtitle: Text(value, style: const TextStyle(color: Colors.black87)),
    );
  }

  Widget _infoCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }

  String _translateStatus(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return 'Hoạt động';
      case 'maintenance':
        return 'Sửa chữa';
      default:
        return status;
    }
  }
}