import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/building_model.dart';
import '../../providers/user_provider.dart';

class BuildingDetailScreen extends ConsumerWidget {
  final Building building;
  const BuildingDetailScreen({super.key, required this.building});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final managerAsync = ref.watch(userByIdProvider(building.managerId));

    return Scaffold(
      appBar: AppBar(title: const Text('Thông tin Tòa nhà')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: managerAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Text('Lỗi tải quản lý: $e'),
            data: (manager) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tên: ${building.buildingName}', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('Địa chỉ: ${building.address}', style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 8),
                Text('Tổng số phòng: ${building.totalRooms}'),
                const SizedBox(height: 8),
                Text('Trạng thái: ${building.status}'),
                const Divider(height: 32, thickness: 2),
                Text('Người quản lý:', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('Họ tên: ${manager?.fullName}'),
                Text('Email: ${manager?.email}'),
                Text('Số điện thoại: ${manager?.phone}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
