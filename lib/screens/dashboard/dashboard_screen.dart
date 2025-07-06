import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_management_app/screens/dashboard/admin_dashboard_screen.dart';
import 'package:rental_management_app/screens/dashboard/manager_dashboard_screen.dart';
import 'package:rental_management_app/screens/dashboard/tenant_dashboard_screen.dart';
import '../../providers/auth_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUserAsync = ref.watch(appUserProvider);

    return appUserAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Lỗi: $e'))),
      data: (user) {
        if (user == null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Chưa đăng nhập'),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        }

        switch (user.role) {
          case 'admin':
            return const AdminDashboardScreen();
          case 'manager':
            return const ManagerDashboardScreen();
          case 'tenant':
            return const TenantDashboardScreen();
          default:
            return const Scaffold(body: Center(child: Text('Vai trò không xác định')));
        }
      },
    );
  }
}
