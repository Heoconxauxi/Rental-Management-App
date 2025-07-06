import 'package:flutter/material.dart';
import 'package:rental_management_app/screens/payment/payment_create_screen.dart';
import '../../../models/invoice_model.dart';

class InvoiceDetailScreen extends StatelessWidget {
  final Invoice invoice;

  const InvoiceDetailScreen({super.key, required this.invoice});

  @override
  Widget build(BuildContext context) {
    final fees = invoice.fees;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết hóa đơn'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionContainer(
              title: 'Thông tin hóa đơn',
              children: [
                _infoRow('Tháng/Năm:', '${invoice.invoiceMonth}/${invoice.invoiceYear}'),
                _infoRow('Tình trạng:', invoice.status == 'paid' ? 'Đã thanh toán' : 'Chưa thanh toán'),
                if (invoice.paymentDate != null)
                  _infoRow('Ngày thanh toán:', invoice.paymentDate!),
              ],
            ),
            const SizedBox(height: 16),
            _sectionContainer(
              title: 'Chi tiết phí',
              children: [
                _infoRow('Tiền thuê phòng:', '${fees.roomRent} VND'),
                _infoRow('Điện:', '${fees.electricity} VND'),
                _infoRow('Nước:', '${fees.water} VND'),
                _infoRow('Dịch vụ:', '${fees.serviceFee} VND'),
                _infoRow('Gửi xe:', '${fees.parkingFee} VND'),
                const Divider(thickness: 2),
                _infoRow('Tổng cộng:', '${invoice.totalAmount} VND', bold: true),
              ],
            ),
            const SizedBox(height: 24),

            if (invoice.status != 'paid')
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.payment),
                  label: const Text('Thanh toán ngay'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaymentCreateScreen(invoice: invoice),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _sectionContainer({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
