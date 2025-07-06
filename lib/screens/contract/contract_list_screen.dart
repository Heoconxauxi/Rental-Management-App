import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rental_management_app/providers/building_provider.dart';
import 'package:rental_management_app/providers/room_provider.dart';
import 'package:rental_management_app/providers/tenant_provider.dart';
import '../../models/contract_model.dart';
import '../../providers/contract_provider.dart';

class ContractListScreen extends ConsumerWidget {
  const ContractListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contractListAsync = ref.watch(allContractsProvider);
    final buildings = ref.watch(buildingListProvider).value ?? [];
    final rooms = ref.watch(roomListProvider).value ?? [];
    final tenants = ref.watch(allTenantsProvider).value ?? [];
    final contractService = ref.read(contractServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quản lý hợp đồng',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: contractListAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.black)),
        error: (e, _) => Center(child: Text('Lỗi: $e', style: const TextStyle(color: Colors.black))),
        data: (contracts) {
          if (contracts.isEmpty) {
            return const Center(child: Text('Chưa có hợp đồng nào', style: TextStyle(color: Colors.black)));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: contracts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final c = contracts[index];
              final building = buildings.firstWhereOrNull((b) => b.id == c.buildingId);
              final room = rooms.firstWhereOrNull((r) => r.id == c.roomId);
              final tenant = tenants.firstWhereOrNull((t) => t.id == c.tenantId);

              final dateFormat = DateFormat('dd/MM/yyyy');
              final startDate = dateFormat.format(DateTime.parse(c.startDate));
              final endDate = dateFormat.format(DateTime.parse(c.endDate));

              return Container(
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
                            'HĐ: ${c.contractNumber}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Phòng: ${room?.roomNumber ?? 'Không tìm thấy phòng'}',
                              style: const TextStyle(color: Colors.black87)),
                          Text('Khách thuê: ${tenant?.fullName ?? 'Không tìm thấy khách thuê'}',
                              style: const TextStyle(color: Colors.black87)),
                          Text('Tòa: ${building?.buildingName ?? 'Không tìm thấy tòa nhà'}',
                              style: const TextStyle(color: Colors.black87)),
                          Text('Từ: $startDate → $endDate', style: const TextStyle(color: Colors.black87)),
                          Text('Tiền thuê: ${c.monthlyRent}₫', style: const TextStyle(color: Colors.black87)),
                          Text('Cọc: ${c.depositPaid}₫', style: const TextStyle(color: Colors.black87)),
                          Text('Trạng thái: ${_translateStatus(c.status)}',
                              style: const TextStyle(color: Colors.black87)),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.black),
                          onPressed: () {
                            _showContractDialog(context, ref, contract: c);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                backgroundColor: Colors.white,
                                title: const Text(
                                  'Xóa hợp đồng',
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                                content: const Text('Bạn có chắc chắn muốn xóa?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, false),
                                    child: const Text('Hủy', style: TextStyle(color: Colors.black)),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.pop(context, true),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text('Xóa'),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              try {
                                await contractService.deleteContract(c.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Xóa hợp đồng thành công')),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Lỗi khi xóa hợp đồng: $e')),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: () => _showContractDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showContractDialog(BuildContext context, WidgetRef ref, {Contract? contract}) {
    final idCtrl = TextEditingController(text: contract?.contractNumber ?? '');
    final rentCtrl = TextEditingController(text: contract?.monthlyRent.toString() ?? '');
    final depositCtrl = TextEditingController(text: contract?.depositPaid.toString() ?? '');

    DateTime? selectedStartDate = contract != null ? DateTime.parse(contract.startDate) : null;
    DateTime? selectedEndDate = contract != null ? DateTime.parse(contract.endDate) : null;
    String durationChoice = '6 tháng';

    final createdBy = contract?.createdBy ?? 'admin';
    String status = contract?.status ?? 'active';

    String? selectedBuildingId = contract?.buildingId;
    String? selectedRoomId = contract?.roomId;
    String? selectedTenantId = contract?.tenantId;

    showDialog(
      context: context,
      builder: (_) => Consumer(
        builder: (context, ref, _) {
          final buildings = ref.watch(buildingListProvider).value ?? [];
          final rooms = ref.watch(roomListProvider).value ?? [];
          final tenants = ref.watch(allTenantsProvider).value ?? [];

          if (buildings.isEmpty || rooms.isEmpty || tenants.isEmpty) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              backgroundColor: Colors.white,
              title: const Text(
                'Lỗi',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              content: const Text('Không có dữ liệu tòa nhà, phòng hoặc khách thuê'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Đóng', style: TextStyle(color: Colors.black)),
                ),
              ],
            );
          }

          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            backgroundColor: Colors.white,
            title: Text(
              contract == null ? 'Thêm hợp đồng' : 'Chỉnh sửa hợp đồng',
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            content: StatefulBuilder(
              builder: (context, setState) {
                final filteredRooms = rooms.where((r) => r.buildingId == selectedBuildingId).toList();

                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: idCtrl,
                        decoration: InputDecoration(
                          labelText: 'Số hợp đồng',
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: selectedBuildingId,
                        decoration: InputDecoration(
                          labelText: 'Tòa nhà',
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                        items: buildings
                            .map((b) => DropdownMenuItem(value: b.id, child: Text(b.buildingName)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedBuildingId = value;
                            selectedRoomId = null;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: selectedRoomId,
                        decoration: InputDecoration(
                          labelText: 'Phòng',
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                        items: filteredRooms.isNotEmpty
                            ? filteredRooms
                                .map((r) => DropdownMenuItem(value: r.id, child: Text(r.roomNumber)))
                                .toList()
                            : [const DropdownMenuItem(value: null, child: Text('Không có phòng'))],
                        onChanged: filteredRooms.isNotEmpty
                            ? (value) {
                                setState(() {
                                  selectedRoomId = value;
                                  final room = rooms.firstWhereOrNull((r) => r.id == value);
                                  if (room != null) {
                                    rentCtrl.text = room.basePrice.toString();
                                  }
                                });
                              }
                            : null,
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: selectedTenantId,
                        decoration: InputDecoration(
                          labelText: 'Khách thuê',
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                        items: tenants
                            .map((t) => DropdownMenuItem(value: t.id, child: Text(t.fullName)))
                            .toList(),
                        onChanged: (value) => setState(() => selectedTenantId = value),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'Từ ngày:',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            selectedStartDate != null
                                ? DateFormat('dd/MM/yyyy').format(selectedStartDate!)
                                : 'Chưa chọn',
                            style: const TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.calendar_today, color: Colors.black),
                            onPressed: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: selectedStartDate ?? DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                setState(() {
                                  selectedStartDate = picked;
                                  if (durationChoice == '6 tháng') {
                                    selectedEndDate = picked.add(const Duration(days: 180));
                                  } else if (durationChoice == '1 năm') {
                                    selectedEndDate = picked.add(const Duration(days: 365));
                                  } else if (durationChoice == '2 năm') {
                                    selectedEndDate = picked.add(const Duration(days: 730));
                                  }
                                });
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: durationChoice,
                        decoration: InputDecoration(
                          labelText: 'Thời hạn hợp đồng',
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                        items: ['6 tháng', '1 năm', '2 năm']
                            .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              durationChoice = value;
                              if (selectedStartDate != null) {
                                if (value == '6 tháng') {
                                  selectedEndDate = selectedStartDate!.add(const Duration(days: 180));
                                } else if (value == '1 năm') {
                                  selectedEndDate = selectedStartDate!.add(const Duration(days: 365));
                                } else if (value == '2 năm') {
                                  selectedEndDate = selectedStartDate!.add(const Duration(days: 730));
                                }
                              }
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Đến ngày: ${selectedEndDate != null ? DateFormat('dd/MM/yyyy').format(selectedEndDate!) : 'Chưa có'}',
                        style: const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: rentCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Tiền thuê',
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: depositCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Tiền cọc',
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: status,
                        decoration: InputDecoration(
                          labelText: 'Trạng thái',
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        style: const TextStyle(color: Colors.black),
                        items: ['Hoạt động', 'Hết hạn'].map((s) {
                          return DropdownMenuItem(
                            value: s == 'Hoạt động' ? 'active' : 'terminated',
                            child: Text(s, style: const TextStyle(color: Colors.black)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) setState(() => status = value);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Hủy', style: TextStyle(color: Colors.black)),
              ),
              ElevatedButton(
                onPressed: () async {
                  if ([idCtrl.text, selectedBuildingId, selectedRoomId, selectedTenantId, selectedStartDate, selectedEndDate]
                      .any((e) => e == null || (e is String && e.isEmpty))) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
                    );
                    return;
                  }

                  final contractNumber = idCtrl.text.trim();
                  final rent = int.tryParse(rentCtrl.text) ?? 0;
                  final deposit = int.tryParse(depositCtrl.text) ?? 0;

                  if (rent <= 0 || deposit < 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tiền thuê và cọc phải là số hợp lệ')),
                    );
                    return;
                  }

                  final service = ref.read(contractServiceProvider);
                  final newContract = Contract(
                    id: contract?.id ?? '',
                    contractNumber: contractNumber,
                    buildingId: selectedBuildingId!,
                    roomId: selectedRoomId!,
                    tenantId: selectedTenantId!,
                    startDate: selectedStartDate!.toIso8601String(),
                    endDate: selectedEndDate!.toIso8601String(),
                    monthlyRent: rent,
                    depositPaid: deposit,
                    status: status,
                    createdBy: createdBy,
                  );

                  if (contract == null) {
                    await service.addContract(newContract);
                  } else {
                    await service.updateContract(newContract);
                  }

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Lưu'),
              ),
            ],
          );
        },
      ),
    );
  }

  String _translateStatus(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return 'Hoạt động';
      case 'terminated':
        return 'Hết hạn';
      default:
        return status;
    }
  }
}