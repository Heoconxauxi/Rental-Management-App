import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../models/contract_model.dart';
import '../../models/invoice_model.dart';
import '../../providers/building_provider.dart';
import '../../providers/contract_provider.dart';
import '../../providers/invoice_provider.dart';
import '../../providers/notification_provider.dart';
import '../../providers/room_provider.dart';
import '../../providers/tenant_provider.dart';

class InvoiceListScreen extends ConsumerStatefulWidget {
  const InvoiceListScreen({super.key});

  @override
  ConsumerState<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends ConsumerState<InvoiceListScreen> {
  String? selectedBuildingId;

  @override
  Widget build(BuildContext context) {
    final invoicesAsync = ref.watch(allInvoicesProvider);
    final invoiceService = ref.read(invoiceServiceProvider);
    final buildings = ref.watch(buildingListProvider).value ?? [];
    final tenants = ref.watch(allTenantsProvider).value ?? [];
    final rooms = ref.watch(roomListProvider).value ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Danh sách hóa đơn',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton<String?>(
              value: selectedBuildingId,
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
              onChanged: (value) {
                setState(() {
                  selectedBuildingId = value;
                });
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: invoicesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.black)),
        error: (e, _) => Center(child: Text('Lỗi: $e', style: const TextStyle(color: Colors.black))),
        data: (invoices) {
          final filtered = selectedBuildingId == null
              ? invoices
              : invoices.where((i) => i.buildingId == selectedBuildingId).toList();

          final grouped = <String, List<Invoice>>{};
          for (var invoice in filtered) {
            grouped.putIfAbsent(invoice.tenantId, () => []).add(invoice);
          }

          if (grouped.isEmpty) {
            return const Center(child: Text('Không có hóa đơn nào', style: TextStyle(color: Colors.black)));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemCount: grouped.length,
            itemBuilder: (context, index) {
              final tenantId = grouped.keys.elementAt(index);
              final invoices = grouped[tenantId]!;
              final tenant = tenants.firstWhereOrNull((t) => t.id == tenantId);

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ExpansionTile(
                  title: Text(
                    'Người thuê: ${tenant?.fullName ?? 'Không rõ'}',
                    style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.white,
                  collapsedBackgroundColor: Colors.white,
                  children: invoices.map((invoice) {
                    final room = rooms.firstWhereOrNull((r) => r.id == invoice.roomId);
                    final building = buildings.firstWhereOrNull((b) => b.id == invoice.buildingId);
                    final statusText = invoice.status == 'paid' ? 'Đã thanh toán' : 'Chưa thanh toán';
                    final statusColor = invoice.status == 'paid' ? Colors.green : Colors.red;

                    return GestureDetector(
                      onTap: () {
                        if (invoices.isNotEmpty) {
                          context.push('/invoice-detail', extra: invoice);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hóa đơn ${invoice.invoiceMonth}/${invoice.invoiceYear}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('Tòa: ${building?.buildingName ?? 'Không rõ'}', style: const TextStyle(color: Colors.black87)),
                            Text('Phòng: ${room?.roomNumber ?? 'Không rõ'}', style: const TextStyle(color: Colors.black87)),
                            Text(
                              'Tổng: ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(invoice.totalAmount)}',
                              style: const TextStyle(color: Colors.black87),
                            ),
                            Text(
                              'Trạng thái: $statusText',
                              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.black),
                                  onPressed: () => _showInvoiceDialog(context, ref, invoice: invoice),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    final confirm = await showDialog<bool>(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        backgroundColor: Colors.white,
                                        title: const Text('Xác nhận xóa', style: TextStyle(color: Colors.black)),
                                        content: Text(
                                          'Xóa hóa đơn ${invoice.invoiceMonth}/${invoice.invoiceYear}?',
                                          style: const TextStyle(color: Colors.black),
                                        ),
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
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                            ),
                                            child: const Text('Xóa'),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (confirm == true) {
                                      try {
                                        await invoiceService.deleteInvoice(invoice.id);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Xóa hóa đơn thành công')),
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Lỗi khi xóa hóa đơn: $e')),
                                        );
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () => _showInvoiceDialog(context, ref),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showInvoiceDialog(BuildContext context, WidgetRef ref, {Invoice? invoice}) {
    final now = DateTime.now();
    final contractId = ValueNotifier(invoice?.contractId ?? '');
    final roomId = ValueNotifier(invoice?.roomId ?? '');
    final tenantId = ValueNotifier(invoice?.tenantId ?? '');
    final buildingId = ValueNotifier(invoice?.buildingId ?? '');

    final monthCtrl = TextEditingController(text: invoice?.invoiceMonth.toString() ?? now.month.toString());
    final yearCtrl = TextEditingController(text: invoice?.invoiceYear.toString() ?? now.year.toString());
    final roomRentCtrl = TextEditingController(text: invoice?.fees.roomRent.toString() ?? '');
    final electricityCtrl = TextEditingController(text: invoice?.fees.electricity.toString() ?? '');
    final waterCtrl = TextEditingController(text: invoice?.fees.water.toString() ?? '');
    final serviceCtrl = TextEditingController(text: invoice?.fees.serviceFee.toString() ?? '');
    final parkingCtrl = TextEditingController(text: invoice?.fees.parkingFee.toString() ?? '');
    String status = invoice?.status ?? 'unpaid';

    final contracts = ref.watch(allContractsProvider).value ?? [];
    final tenants = ref.watch(allTenantsProvider).value ?? [];
    final rooms = ref.watch(roomListProvider).value ?? [];
    final buildings = ref.watch(buildingListProvider).value ?? [];

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Colors.white,
        title: Text(
          invoice == null ? 'Thêm hóa đơn' : 'Chỉnh sửa hóa đơn',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: contractId.value.isEmpty ? null : contractId.value,
                    decoration: InputDecoration(
                      labelText: 'Hợp đồng',
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
                    items: contracts.map((c) {
                      final tenant = tenants.firstWhereOrNull((t) => t.id == c.tenantId);
                      return DropdownMenuItem(
                        value: c.id,
                        child: Text('HĐ: ${c.contractNumber} - ${tenant?.fullName ?? 'Không rõ'}'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        contractId.value = val ?? '';
                        final selected = contracts.firstWhere(
                          (c) => c.id == val,
                          orElse: () => Contract(
                            id: '',
                            contractNumber: '',
                            roomId: '',
                            tenantId: '',
                            buildingId: '',
                            startDate: '',
                            endDate: '',
                            monthlyRent: 0,
                            depositPaid: 0,
                            status: '',
                            createdBy: '',
                          ),
                        );
                        roomId.value = selected.roomId;
                        tenantId.value = selected.tenantId;
                        buildingId.value = selected.buildingId;
                        roomRentCtrl.text = selected.monthlyRent.toString();
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: monthCtrl,
                    decoration: InputDecoration(
                      labelText: 'Tháng',
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
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: yearCtrl,
                    decoration: InputDecoration(
                      labelText: 'Năm',
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
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: roomRentCtrl,
                    decoration: InputDecoration(
                      labelText: 'Tiền thuê phòng',
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
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: electricityCtrl,
                    decoration: InputDecoration(
                      labelText: 'Tiền điện',
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
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: waterCtrl,
                    decoration: InputDecoration(
                      labelText: 'Tiền nước',
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
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: serviceCtrl,
                    decoration: InputDecoration(
                      labelText: 'Phí dịch vụ',
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
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: parkingCtrl,
                    decoration: InputDecoration(
                      labelText: 'Phí gửi xe',
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
                    keyboardType: TextInputType.number,
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
                    items: const [
                      DropdownMenuItem(value: 'paid', child: Text('Đã thanh toán')),
                      DropdownMenuItem(value: 'unpaid', child: Text('Chưa thanh toán')),
                    ],
                    onChanged: (value) => setState(() => status = value!),
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
              final invoiceMonth = int.tryParse(monthCtrl.text.trim()) ?? 0;
              final invoiceYear = int.tryParse(yearCtrl.text.trim()) ?? 0;
              final roomRent = int.tryParse(roomRentCtrl.text.trim()) ?? 0;
              final electricity = int.tryParse(electricityCtrl.text.trim()) ?? 0;
              final water = int.tryParse(waterCtrl.text.trim()) ?? 0;
              final serviceFee = int.tryParse(serviceCtrl.text.trim()) ?? 0;
              final parkingFee = int.tryParse(parkingCtrl.text.trim()) ?? 0;
              final total = roomRent + electricity + water + serviceFee + parkingFee;

              if (contractId.value.isEmpty || invoiceMonth < 1 || invoiceMonth > 12 || invoiceYear < 2000 || total <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vui lòng nhập đầy đủ và đúng thông tin')),
                );
                return;
              }

              final fees = Fees(
                roomRent: roomRent,
                electricity: electricity,
                water: water,
                serviceFee: serviceFee,
                parkingFee: parkingFee,
              );

              final service = ref.read(invoiceServiceProvider);
              final notificationService = ref.read(notificationServiceProvider);

              try {
                if (invoice == null) {
                  final newInvoice = Invoice(
                    id: '',
                    contractId: contractId.value,
                    roomId: roomId.value,
                    tenantId: tenantId.value,
                    buildingId: buildingId.value,
                    invoiceMonth: invoiceMonth,
                    invoiceYear: invoiceYear,
                    fees: fees,
                    totalAmount: total,
                    status: status,
                    paymentDate: status == 'paid' ? DateTime.now().toIso8601String() : null,
                  );
                  await service.addInvoice(newInvoice);

                  final tenantService = ref.read(tenantServiceProvider);
                  final tenant = await tenantService.getTenantById(tenantId.value);
                  if (tenant != null && tenant.accountId != null && tenant.accountId!.isNotEmpty) {
                    final room = rooms.firstWhereOrNull((r) => r.id == roomId.value);
                    final building = buildings.firstWhereOrNull((b) => b.id == buildingId.value);
                    final dueDate = DateTime.now().add(const Duration(days: 7));
                    final formattedDueDate = '${dueDate.day.toString().padLeft(2, '0')}/${dueDate.month.toString().padLeft(2, '0')}/${dueDate.year}';
                    final formattedTotal = NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(total);

                    await notificationService.sendNotification(
                      title: 'Hóa đơn mới tháng $invoiceMonth/$invoiceYear',
                      content: 'Hóa đơn mới cho phòng ${room?.roomNumber ?? 'Không rõ'}, tòa ${building?.buildingName ?? 'Không rõ'}. '
                          'Tổng tiền: $formattedTotal. Vui lòng thanh toán trước ngày $formattedDueDate.',
                      targetType: 'tenant',
                      targetId: tenant.accountId!,
                    );
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Thêm hóa đơn thành công')),
                  );
                } else {
                  final updated = invoice.copyWith(
                    contractId: contractId.value,
                    roomId: roomId.value,
                    tenantId: tenantId.value,
                    buildingId: buildingId.value,
                    invoiceMonth: invoiceMonth,
                    invoiceYear: invoiceYear,
                    fees: fees,
                    totalAmount: total,
                    status: status,
                    paymentDate: status == 'paid' ? (invoice.paymentDate ?? DateTime.now().toIso8601String()) : null,
                  );
                  await service.updateInvoice(updated);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cập nhật hóa đơn thành công')),
                  );
                }
                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Lỗi: $e')),
                );
              }
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
}