import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_management_app/models/user_model.dart';
import '../../models/building_model.dart';
import '../../providers/building_provider.dart';
import '../../providers/user_provider.dart';

class BuildingListScreen extends ConsumerWidget {
  const BuildingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildingListAsync = ref.watch(buildingListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý tòa nhà', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: buildingListAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.black)),
        error: (e, _) => Center(child: Text('Lỗi: $e', style: TextStyle(color: Colors.black))),
        data: (buildings) {
          if (buildings.isEmpty) {
            return const Center(child: Text('Chưa có tòa nhà nào', style: TextStyle(color: Colors.black)));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: buildings.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final b = buildings[index];
              return InkWell(
                onTap: () => context.push('/admin-building-detail', extra: b),
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
                            Text(b.buildingName,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            const SizedBox(height: 8),
                            Text('Địa chỉ: ${b.address}',
                                style: const TextStyle(color: Colors.black87)),
                            Text('Số phòng: ${b.totalRooms}',
                                style: const TextStyle(color: Colors.black87)),
                            Text('Trạng thái: ${_translateStatus(b.status)}',
                                style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.black),
                        onPressed: () => _showBuildingDialog(context, ref, building: b),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () => _showBuildingDialog(context, ref),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showBuildingDialog(BuildContext context, WidgetRef ref, {Building? building}) {
    final nameCtrl = TextEditingController(text: building?.buildingName ?? '');
    final addressCtrl = TextEditingController(text: building?.address ?? '');
    final totalRoomCtrl = TextEditingController(text: building?.totalRooms.toString() ?? '');
    String status = building?.status ?? 'active';
    final buildingService = ref.read(buildingServiceProvider);

    AppUser? selectedManager;

    showDialog(
      context: context,
      builder: (_) {
        final managerListAsync = ref.watch(managerListProvider);

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
          title: Text(
            building == null ? 'Thêm tòa nhà' : 'Chỉnh sửa tòa nhà',
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    labelText: 'Tên tòa nhà',
                    labelStyle: const TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: addressCtrl,
                  decoration: InputDecoration(
                    labelText: 'Địa chỉ',
                    labelStyle: const TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: totalRoomCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Số phòng',
                    labelStyle: const TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 12),
                managerListAsync.when(
                  loading: () => const CircularProgressIndicator(color: Colors.black),
                  error: (e, _) => Text('Lỗi tải danh sách quản lý: $e', style: const TextStyle(color: Colors.black)),
                  data: (managers) {
                    selectedManager ??= building != null
                        ? managers.firstWhere(
                            (m) => m.id == building.managerId,
                          )
                        : null;

                    return DropdownButtonFormField<AppUser>(
                      value: selectedManager,
                      decoration: InputDecoration(
                        labelText: 'Người quản lý',
                        labelStyle: const TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      style: const TextStyle(color: Colors.black),
                      items: managers.map((manager) {
                        return DropdownMenuItem(
                          value: manager,
                          child: Text(manager.fullName, style: const TextStyle(color: Colors.black)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        selectedManager = val;
                      },
                    );
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: status,
                  decoration: InputDecoration(
                    labelText: 'Trạng thái',
                    labelStyle: const TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                  items: ['Hoạt động', 'Bảo trì'].map((s) {
                    return DropdownMenuItem(
                      value: s == 'Hoạt động' ? 'active' : 'maintenance',
                      child: Text(s, style: const TextStyle(color: Colors.black)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      status = value == 'Hoạt động' ? 'active' : 'inactive';
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Huỷ', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = nameCtrl.text.trim();
                final address = addressCtrl.text.trim();
                final totalRooms = int.tryParse(totalRoomCtrl.text.trim()) ?? 0;

                if (name.isEmpty || address.isEmpty || totalRooms <= 0 || selectedManager == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
                  );
                  return;
                }

                if (building == null) {
                  final docRef = await FirebaseFirestore.instance.collection('buildings').add({
                    'buildingName': name,
                    'address': address,
                    'totalRooms': totalRooms,
                    'managerId': selectedManager!.id,
                    'status': status,
                  });
                  await docRef.update({'id': docRef.id});
                } else {
                  final updated = building.copyWith(
                    buildingName: name,
                    address: address,
                    totalRooms: totalRooms,
                    status: status,
                    managerId: selectedManager!.id,
                  );
                  await buildingService.updateBuilding(updated);
                }

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  String _translateStatus(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return 'Hoạt động';
      case 'maintenance':
        return 'Bảo trì';
      default:
        return status;
    }
  }
}