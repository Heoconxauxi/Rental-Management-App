import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rental_management_app/providers/notification_provider.dart';
import '../../../models/invoice_model.dart';
import '../../../models/payment_model.dart';
import '../../../providers/building_provider.dart';
import '../../../providers/payment_provider.dart';
import '../../../providers/room_provider.dart';
import '../../../providers/tenant_provider.dart';
import '../../providers/user_provider.dart';

class PaymentCreateScreen extends ConsumerStatefulWidget {
  final Invoice invoice;

  const PaymentCreateScreen({super.key, required this.invoice});

  @override
  ConsumerState<PaymentCreateScreen> createState() => _PaymentCreateScreenState();
}

class _PaymentCreateScreenState extends ConsumerState<PaymentCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String _paymentMethod = 'cash';

  @override
  void initState() {
    super.initState();
    _amountController.text = widget.invoice.totalAmount.toString();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paymentService = ref.read(paymentServiceProvider);
    final rooms = ref.watch(roomListProvider).value ?? [];
    final buildings = ref.watch(buildingListProvider).value ?? [];
    final tenants = ref.watch(allTenantsProvider).value ?? [];
    final users = ref.watch(allUsersProvider).value ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thanh toán hóa đơn',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Hóa đơn: ${widget.invoice.invoiceMonth}/${widget.invoice.invoiceYear}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Số tiền thanh toán',
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
                readOnly: true,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _paymentMethod,
                decoration: InputDecoration(
                  labelText: 'Phương thức thanh toán',
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
                  DropdownMenuItem(value: 'cash', child: Text('Tiền mặt')),
                  DropdownMenuItem(value: 'bank', child: Text('Chuyển khoản')),
                  DropdownMenuItem(value: 'other', child: Text('Khác')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _paymentMethod = value);
                  }
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.payment, color: Colors.white),
                  label: const Text('Xác nhận thanh toán', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    final payment = Payment(
                      id: '',
                      invoiceId: widget.invoice.id,
                      amount: widget.invoice.totalAmount,
                      paymentDate: DateTime.now().toIso8601String(),
                      paymentMethod: _paymentMethod,
                    );

                    final notificationService = ref.read(notificationServiceProvider);
                    final tenant = tenants.firstWhereOrNull((t) => t.id == widget.invoice.tenantId);
                    final room = rooms.firstWhereOrNull((r) => r.id == widget.invoice.roomId);
                    final building = buildings.firstWhereOrNull((b) => b.id == widget.invoice.buildingId);
                    final formattedAmount = NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(widget.invoice.totalAmount);
                    final paymentDate = DateTime.now();
                    final formattedDate = '${paymentDate.day.toString().padLeft(2, '0')}/${paymentDate.month.toString().padLeft(2, '0')}/${paymentDate.year} ${paymentDate.hour.toString().padLeft(2, '0')}:${paymentDate.minute.toString().padLeft(2, '0')}';
                    final paymentMethodText = _paymentMethod == 'cash' ? 'Tiền mặt' : _paymentMethod == 'bank' ? 'Chuyển khoản' : 'Khác';

                    try {
                      // Thêm thanh toán
                      await paymentService.addPayment(payment);

                      if (mounted) {
                        // Gửi thông báo cho tenant
                        if (tenant != null && tenant.accountId != null && tenant.accountId!.isNotEmpty) {
                          await notificationService.sendNotification(
                            title: 'Thanh toán hóa đơn thành công',
                            content: 'Bạn đã thanh toán hóa đơn tháng ${widget.invoice.invoiceMonth}/${widget.invoice.invoiceYear} '
                                'cho phòng ${room?.roomNumber ?? 'Không rõ'}, tòa ${building?.buildingName ?? 'Không rõ'}. '
                                'Số tiền: $formattedAmount. Phương thức: $paymentMethodText. '
                                'Thời gian: $formattedDate.',
                            targetType: 'tenant',
                            targetId: tenant.accountId!,
                          );
                        }

                        // Tìm managerId
                        String? managerId;
                        if (tenant != null && tenant.accountId != null) {
                          final user = users.firstWhereOrNull((u) => u.id == tenant.accountId);
                          if (user != null && tenant.currentRoomId != null) {
                            final tenantRoom = rooms.firstWhereOrNull((r) => r.id == tenant.currentRoomId);
                            if (tenantRoom != null) {
                              final tenantBuilding = buildings.firstWhereOrNull((b) => b.id == tenantRoom.buildingId);
                              if (tenantBuilding != null) {
                                managerId = tenantBuilding.managerId;
                              }
                            }
                          }
                        }

                        // Gửi thông báo cho manager
                        if (managerId != null) {
                          await notificationService.sendNotification(
                            title: 'Thanh toán hóa đơn mới',
                            content: 'Người thuê ${tenant?.fullName ?? 'Không rõ'} đã thanh toán hóa đơn '
                                'tháng ${widget.invoice.invoiceMonth}/${widget.invoice.invoiceYear} '
                                'cho phòng ${room?.roomNumber ?? 'Không rõ'}, tòa ${building?.buildingName ?? 'Không rõ'}. '
                                'Số tiền: $formattedAmount. Phương thức: $paymentMethodText. '
                                'Thời gian: $formattedDate.',
                            targetType: 'manager',
                            targetId: managerId,
                          );
                        }

                        // Hiển thị thông báo thành công và đóng màn hình
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Thanh toán thành công')),
                        );
                      }
                    } catch (e) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Lỗi khi xử lý thanh toán: $e')),
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}