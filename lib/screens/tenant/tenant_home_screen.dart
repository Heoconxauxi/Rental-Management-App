import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../models/building_model.dart';
import '../../../models/room_model.dart';
import '../../../models/tenant_model.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/building_provider.dart';
import '../../../providers/invoice_provider.dart';
import '../../../providers/room_provider.dart';
import '../../../providers/tenant_provider.dart';

class TenantHomeScreen extends ConsumerWidget {
  const TenantHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(appUserProvider);

    return userAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Lỗi: $e'))),
      data: (user) {
        if (user == null) {
          return const Scaffold(body: Center(child: Text('Không tìm thấy người dùng')));
        }

        final tenantAsync = ref.watch(allTenantsProvider);

        return tenantAsync.when(
          loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (e, _) => Scaffold(body: Center(child: Text('Lỗi khi tải tenant: $e'))),
          data: (tenants) {
            final tenant = tenants.firstWhere(
              (t) => t.accountId == user.id,
              orElse: () => const Tenant(
                id: '',
                fullName: '',
                phone: '',
                email: '',
                gender: '',
                occupation: '',
                workplace: '',
                monthlyIncome: 0,
                status: '',
              ),
            );

            if (tenant.id.isEmpty) {
              return const Scaffold(body: Center(child: Text('Không tìm thấy tenant')));
            }

            final roomAsync = ref.watch(roomListProvider);

            return roomAsync.when(
              loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
              error: (e, _) => Scaffold(body: Center(child: Text('Lỗi khi tải phòng: $e'))),
              data: (rooms) {
                final room = rooms.firstWhere(
                  (r) => r.currentTenantId == tenant.id,
                  orElse: () => const Room(
                    id: '',
                    buildingId: '',
                    roomNumber: '',
                    roomType: '',
                    area: 0,
                    basePrice: 0,
                    depositAmount: 0,
                    status: '',
                    maxOccupants: 0,
                    floor: 0,
                    amenities: {},
                  ),
                );

                if (room.id.isEmpty) {
                  return const Scaffold(body: Center(child: Text('Không tìm thấy phòng')));
                }

                final buildingAsync = ref.watch(buildingListProvider);

                return buildingAsync.when(
                  loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
                  error: (e, _) => Scaffold(body: Center(child: Text('Lỗi khi tải building: $e'))),
                  data: (buildings) {
                    final building = buildings.firstWhere(
                      (b) => b.id == room.buildingId,
                      orElse: () => const Building(
                        id: '',
                        buildingName: '',
                        address: '',
                        totalRooms: 0,
                        managerId: '',
                        status: '',
                      ),
                    );

                    final invoiceAsync = ref.watch(invoicesByTenantProvider(tenant.id));

                    return Scaffold(
                      appBar: AppBar(
                        title: const Text('Home'),
                      ),
                      body: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                context.push('/building-detail', extra: building);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 2.0),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tòa nhà: ${building.buildingName}',
                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text('Địa chỉ: ${building.address}', style: const TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            InkWell(
                              onTap: () {
                                context.push('/room-detail', extra: room);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 2.0),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Phòng: ${room.roomNumber} (Tầng ${room.floor})',
                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 4),
                                    Text('Diện tích: ${room.area} m²', style: const TextStyle(fontSize: 18)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Hóa đơn:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: 250,
                                    child: invoiceAsync.when(
                                      loading: () => const Center(child: CircularProgressIndicator()),
                                      error: (e, _) => Center(child: Text('Lỗi khi tải hóa đơn: $e')),
                                      data: (invoices) {
                                        if (invoices.isEmpty) {
                                          return const Center(child: Text('Không có hóa đơn nào', style: TextStyle(fontSize: 18)));
                                        }
                                        return ListView.builder(
                                          itemCount: invoices.length,
                                          itemBuilder: (context, index) {
                                            final invoice = invoices[index];
                                            return Card(
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(color: Colors.black, width: 1.5),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: ListTile(
                                                title: Text('Tháng ${invoice.invoiceMonth}/${invoice.invoiceYear}',
                                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                                subtitle: Text('Tổng tiền: ${invoice.totalAmount} VND',
                                                    style: const TextStyle(fontSize: 16)),
                                                trailing: Icon(
                                                  invoice.status == 'paid' ? Icons.check_circle : Icons.pending,
                                                  color: Colors.black,
                                                  size: 28,
                                                ),
                                                onTap: () {
                                                  context.push('/invoice-detail', extra: invoice);
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}