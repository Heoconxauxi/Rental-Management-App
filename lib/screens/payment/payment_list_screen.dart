import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/payment_model.dart';
import '../../providers/payment_provider.dart';

class PaymentListScreen extends ConsumerWidget {
  const PaymentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentsAsync = ref.watch(allPaymentsProvider);
    final paymentService = ref.read(paymentServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Danh sách thanh toán')),
      body: paymentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Lỗi: $e')),
        data: (payments) => payments.isEmpty
            ? const Center(child: Text('Chưa có thanh toán nào'))
            : ListView.builder(
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  final p = payments[index];
                  return ListTile(
                    title: Text('Hoá đơn: ${p.invoiceId}'),
                    subtitle: Text('Số tiền: ${p.amount} - Ngày: ${p.paymentDate}\nPhương thức: ${p.paymentMethod}'),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Xác nhận xoá'),
                            content: Text('Xoá thanh toán này?'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Huỷ')),
                              TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Xoá')),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          await paymentService.deletePayment(p.id);
                        }
                      },
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPaymentDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddPaymentDialog(BuildContext context, WidgetRef ref) {
    final invoiceIdCtrl = TextEditingController();
    final amountCtrl = TextEditingController();
    String paymentMethod = 'cash';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Thêm thanh toán'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: invoiceIdCtrl, decoration: const InputDecoration(labelText: 'Mã hoá đơn')),
              TextField(controller: amountCtrl, decoration: const InputDecoration(labelText: 'Số tiền'), keyboardType: TextInputType.number),
              DropdownButtonFormField<String>(
                value: paymentMethod,
                decoration: const InputDecoration(labelText: 'Phương thức'),
                items: ['cash', 'bank', 'momo'].map((method) => DropdownMenuItem(value: method, child: Text(method))).toList(),
                onChanged: (value) => paymentMethod = value!,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Huỷ')),
          ElevatedButton(
            onPressed: () async {
              final invoiceId = invoiceIdCtrl.text.trim();
              final amount = int.tryParse(amountCtrl.text.trim()) ?? 0;
              if (invoiceId.isEmpty || amount <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin hợp lệ')),
                );
                return;
              }
              final payment = Payment(
                id: '',
                invoiceId: invoiceId,
                amount: amount,
                paymentDate: '', // sẽ được set trong service
                paymentMethod: paymentMethod,
              );
              await ref.read(paymentServiceProvider).addPayment(payment);
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }
}
