import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:rental_management_app/providers/auth_provider.dart';
import 'package:rental_management_app/providers/payment_provider.dart';

class StatisticsScreen extends ConsumerStatefulWidget {
  const StatisticsScreen({super.key});

  @override
  ConsumerState<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends ConsumerState<StatisticsScreen> {
  int? selectedMonth;
  int? selectedYear;
  final List<int> months = List.generate(12, (index) => index + 1);
  final List<int> years = List.generate(10, (index) => DateTime.now().year - 5 + index);

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    selectedMonth = now.month;
    selectedYear = now.year;
  }

  @override
 Widget build(BuildContext context) {
    final ref = this.ref;
    final userAsync = ref.watch(appUserProvider);

    return userAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.black)),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('Lỗi: $e', style: TextStyle(color: Colors.black))),
      ),
      data: (user) {
        if (user == null) {
          return const Scaffold(
            body: Center(child: Text('Không tìm thấy người dùng', style: TextStyle(color: Colors.black))),
          );
        }

        final filter = {'month': selectedMonth, 'year': selectedYear};
        final totalPaymentsAsync = ref.watch(totalPaymentsAmountProvider(filter));
        final paymentStatusAsync = ref.watch(paymentStatusCountsProvider(filter));

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Thống kê thanh toán',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            elevation: 1,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    DropdownButton<int>(
                      value: selectedMonth,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      underline: Container(height: 1, color: Colors.black),
                      items: [
                        const DropdownMenuItem<int>(
                          value: null,
                          child: Text('Tất cả tháng'),
                        ),
                        ...months.map((m) => DropdownMenuItem<int>(
                              value: m,
                              child: Text('Tháng $m'),
                            )),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedMonth = value;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    DropdownButton<int>(
                      value: selectedYear,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      underline: Container(height: 1, color: Colors.black),
                      items: [
                        const DropdownMenuItem<int>(
                          value: null,
                          child: Text('Tất cả năm'),
                        ),
                        ...years.map((y) => DropdownMenuItem<int>(
                              value: y,
                              child: Text('$y'),
                            )),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tổng quan thanh toán',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        title: 'Tổng tiền thu',
                        value: totalPaymentsAsync.when(
                          data: (total) => NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(total),
                          loading: () => '...',
                          error: (e, _) => 'Lỗi',
                        ),
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Trạng thái hóa đơn',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 16),
                paymentStatusAsync.when(
                  data: (counts) => Column(
                    children: [
                      SizedBox(height: 200, child: _buildPaymentStatusChart(counts)),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          LegendDot(color: Colors.green, text: 'Đã thanh toán'),
                          SizedBox(width: 16),
                          LegendDot(color: Colors.red, text: 'Chưa thanh toán'),
                        ],
                      ),
                    ],
                  ),
                  loading: () => const Center(child: CircularProgressIndicator(color: Colors.black)),
                  error: (e, _) => Text('Lỗi: $e', style: const TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard({required String title, required String value, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.black87)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildPaymentStatusChart(Map<String, int> counts) {
    final paid = counts['paid'] ?? 0;
    final unpaid = counts['unpaid'] ?? 0;
    final total = (paid + unpaid).toDouble();

    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(
            color: Colors.green,
            value: paid.toDouble(),
            title: total == 0 ? '0%' : '${((paid / total) * 100).toStringAsFixed(1)}%',
            radius: 60,
            titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          PieChartSectionData(
            color: Colors.red,
            value: unpaid.toDouble(),
            title: total == 0 ? '0%' : '${((unpaid / total) * 100).toStringAsFixed(1)}%',
            radius: 60,
            titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class LegendDot extends StatelessWidget {
  final Color color;
  final String text;

  const LegendDot({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.black)),
      ],
    );
  }
}
