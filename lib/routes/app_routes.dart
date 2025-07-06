import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_management_app/models/building_model.dart';
import 'package:rental_management_app/models/invoice_model.dart';
import 'package:rental_management_app/models/room_model.dart';
import 'package:rental_management_app/screens/building/admin_building_detail_screen.dart';
import 'package:rental_management_app/screens/building/building_detail_screen.dart';
import 'package:rental_management_app/screens/building/building_list_screen.dart';
import 'package:rental_management_app/screens/contract/contract_list_screen.dart';
import 'package:rental_management_app/screens/invoice/invoice_detail_screen.dart';
import 'package:rental_management_app/screens/invoice/invoice_list_screen.dart';
import 'package:rental_management_app/screens/payment/payment_list_screen.dart';
import 'package:rental_management_app/screens/profile/change_password_screen.dart';
import 'package:rental_management_app/screens/room/admin_room_detail_screen.dart';
import 'package:rental_management_app/screens/room/room_detail_screen.dart';
import 'package:rental_management_app/screens/room/room_list_screen.dart';
import 'package:rental_management_app/screens/statistic/statistic.dart';
import 'package:rental_management_app/screens/tenant/tenant_list_screen.dart';

import '../providers/auth_provider.dart';
import '../screens/auth/forgot_password_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(firebaseAuthStateProvider).asData?.value;

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/buildings',
        builder: (context, state) => const BuildingListScreen(),
      ),
      GoRoute(
        path: '/rooms/:buildingId',
        builder: (context, state) {
          final building = state.extra as Building;
          return RoomListScreen(buildingId: building.id);
        },
      ),
      GoRoute(
        path: '/tenants',
        builder: (context, state) => const TenantListScreen(),
      ),
      GoRoute(
        path: '/contracts',
        builder: (context, state) => const ContractListScreen(),
      ),
      GoRoute(
        path: '/invoices',
        builder: (context, state) => const InvoiceListScreen(),
      ),
      GoRoute(
        path: '/payments',
        builder: (context, state) => const PaymentListScreen(),
      ),
      GoRoute(
        path: '/statistic',
        builder: (context, state) => const StatisticsScreen(),
      ),
      GoRoute(
        path: '/building-detail',
        builder: (context, state) {
          final building = state.extra as Building;
          return BuildingDetailScreen(building: building);
        }, 
      ),
      GoRoute(
        path: '/room-detail',
        builder: (context, state) {
          final room = state.extra as Room;
          return RoomDetailScreen(room: room);
        }, 
      ),
      GoRoute(
        path: '/invoice-detail',
        builder: (context, state) {
          final invoice = state.extra as Invoice;
          return InvoiceDetailScreen(invoice: invoice);
        },
      ),
      GoRoute(
        path: '/change-password',
        builder: (context, state) => const ChangePasswordScreen(),
      ),

      GoRoute(
        path: '/admin-building-detail',
        builder: (context, state) {
          final building = state.extra as Building;
          return AdminBuildingDetailScreen(building: building);
        },
      ),
      GoRoute(
        path: '/admin-room-detail',
        builder: (context, state) {
          final room = state.extra as Room;
          return AdminRoomDetailScreen(room: room);
        },
      ),
    ],
    redirect: (context, state) {
      final isAuthRoute = [
        '/login',
        '/forgot-password',
      ].contains(state.matchedLocation);

      if (authState == null && !isAuthRoute) {
        return '/login';
      }

      if (authState != null && isAuthRoute) {
        return '/';
      }

      return null;
    }
  );
});