import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/tenant_model.dart';
import '../../providers/tenant_provider.dart';
import '../../providers/building_provider.dart';

class TenantListScreen extends HookConsumerWidget {
  const TenantListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buildingsAsync = ref.watch(buildingListProvider);
    final selectedBuildingId = useState<String?>(null);

    final tenantAsync = selectedBuildingId.value == null
        ? ref.watch(allTenantsProvider)
        : ref.watch(tenantsByBuildingProvider(selectedBuildingId.value!));

    final tenantService = ref.read(tenantServiceProvider);

    final adminEmail = useState<String?>(null);
    final adminPassword = useState<String?>(null);

    useEffect(() {
      () async {
        final prefs = await SharedPreferences.getInstance();
        adminEmail.value = prefs.getString('adminEmail');
        adminPassword.value = prefs.getString('adminPassword');
      }();
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danh sách người thuê',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          buildingsAsync.when(
            data: (buildings) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DropdownButton<String?>(
                value: selectedBuildingId.value,
                onChanged: (value) => selectedBuildingId.value = value,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                underline: Container(height: 2, color: Colors.black),
                items: [
                  const DropdownMenuItem<String?>(
                    value: null,
                    child: Text('Tất cả'),
                  ),
                  ...buildings.map(
                    (b) => DropdownMenuItem<String>(
                      value: b.id,
                      child: Text(b.buildingName),
                    ),
                  ),
                ],
              ),
            ),
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: CircularProgressIndicator(color: Colors.black),
            ),
            error: (e, _) => const SizedBox(),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: tenantAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.black)),
        error: (e, _) => Center(child: Text('Lỗi: $e', style: const TextStyle(color: Colors.black))),
        data: (tenants) => tenants.isEmpty
            ? const Center(child: Text('Chưa có người thuê nào', style: TextStyle(color: Colors.black)))
            : ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: tenants.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final t = tenants[index];
                  return InkWell(
                    onTap: () => _showTenantDetailDialog(context, t),
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
                                  t.fullName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text('SĐT: ${t.phone}', style: const TextStyle(color: Colors.black87)),
                                Text('Email: ${t.email}', style: const TextStyle(color: Colors.black87)),
                                Text('Trạng thái: ${_translateStatus(t.status)}',
                                    style: const TextStyle(color: Colors.black87)),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.black),
                                onPressed: () {
                                  _showTenantDialog(context, ref, adminEmail.value, adminPassword.value, tenant: t);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text('Xác nhận xóa'),
                                      content: Text('Bạn có chắc muốn xóa "${t.fullName}"?'),
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
                                    await tenantService.deleteTenant(t.id);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () => _showTenantDialog(context, ref, adminEmail.value, adminPassword.value),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showTenantDetailDialog(BuildContext context, Tenant tenant) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        title: Text(
          'Thông tin chi tiết - ${tenant.fullName}',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Họ tên', tenant.fullName),
              _buildDetailRow('SĐT', tenant.phone),
              _buildDetailRow('Email', tenant.email),
              _buildDetailRow('Giới tính', tenant.gender),
              _buildDetailRow('Nghề nghiệp', tenant.occupation),
              _buildDetailRow('Nơi làm việc', tenant.workplace),
              _buildDetailRow('Thu nhập hàng tháng', '${tenant.monthlyIncome.toString()} VNĐ'),
              _buildDetailRow('Trạng thái', _translateStatus(tenant.status)),
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
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _showTenantDialog(
    BuildContext context,
    WidgetRef ref,
    String? adminEmail,
    String? adminPassword, {
    Tenant? tenant,
  }) {
    final nameCtrl = TextEditingController(text: tenant?.fullName ?? '');
    final phoneCtrl = TextEditingController(text: tenant?.phone ?? '');
    final emailCtrl = TextEditingController(text: tenant?.email ?? '');
    final occupationCtrl = TextEditingController(text: tenant?.occupation ?? '');
    final workplaceCtrl = TextEditingController(text: tenant?.workplace ?? '');
    final incomeCtrl = TextEditingController(text: tenant?.monthlyIncome.toString() ?? '');
    String status = tenant?.status ?? 'active';
    String? gender = tenant?.gender;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        title: Text(
          tenant == null ? 'Thêm người thuê' : 'Chỉnh sửa người thuê',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameCtrl,
                    decoration: InputDecoration(
                      labelText: 'Họ tên',
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
                    controller: phoneCtrl,
                    decoration: InputDecoration(
                      labelText: 'Số điện thoại',
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
                    controller: emailCtrl,
                    decoration: InputDecoration(
                      labelText: 'Email',
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
                    value: gender,
                    decoration: InputDecoration(
                      labelText: 'Giới tính',
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
                    items: const [
                      DropdownMenuItem(value: 'Nam', child: Text('Nam')),
                      DropdownMenuItem(value: 'Nữ', child: Text('Nữ')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                    validator: (value) => value == null ? 'Vui lòng chọn giới tính' : null,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: occupationCtrl,
                    decoration: InputDecoration(
                      labelText: 'Nghề nghiệp',
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
                    controller: workplaceCtrl,
                    decoration: InputDecoration(
                      labelText: 'Nơi làm việc',
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
                    controller: incomeCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Thu nhập hàng tháng',
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
                    items: ['Hoạt động', 'Không hoạt động'].map((s) {
                      return DropdownMenuItem(
                        value: s == 'Hoạt động' ? 'active' : 'inactive',
                        child: Text(s, style: const TextStyle(color: Colors.black)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        status = value == 'Hoạt động' ? 'active' : 'inactive';
                      });
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
              final fullName = nameCtrl.text.trim();
              final phone = phoneCtrl.text.trim();
              final email = emailCtrl.text.trim();
              final occupation = occupationCtrl.text.trim();
              final workplace = workplaceCtrl.text.trim();
              final monthlyIncome = int.tryParse(incomeCtrl.text.trim()) ?? 0;

              if (fullName.isEmpty || phone.isEmpty || email.isEmpty || gender == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin bắt buộc')),
                );
                return;
              }

              final service = ref.read(tenantServiceProvider);
              if (tenant == null) {
                if (adminEmail == null || adminPassword == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Không tìm thấy thông tin tài khoản admin')),
                  );
                  return;
                }

                final newTenant = Tenant(
                  id: '',
                  accountId: null,
                  fullName: fullName,
                  phone: phone,
                  email: email,
                  gender: gender!, // Non-null assertion since validated
                  occupation: occupation,
                  workplace: workplace,
                  monthlyIncome: monthlyIncome,
                  status: status,
                  currentRoomId: null,
                );
                await service.addTenant(
                  newTenant,
                  adminEmail: adminEmail,
                  adminPassword: adminPassword,
                );
              } else {
                final updated = tenant.copyWith(
                  fullName: fullName,
                  phone: phone,
                  email: email,
                  gender: gender!, // Non-null assertion since validated
                  occupation: occupation,
                  workplace: workplace,
                  monthlyIncome: monthlyIncome,
                  status: status,
                );
                await service.updateTenant(updated);
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
      ),
    );
  }

  String _translateStatus(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return 'Hoạt động';
      case 'inactive':
        return 'Không hoạt động';
      default:
        return status;
    }
  }
}