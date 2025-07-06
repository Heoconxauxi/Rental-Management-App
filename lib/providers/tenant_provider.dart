import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/tenant_service.dart';
import '../models/tenant_model.dart';

/// Provider cho service
final tenantServiceProvider = Provider<TenantService>((ref) {
  return TenantService();
});

/// Stream tất cả tenants (realtime)
final allTenantsProvider = StreamProvider<List<Tenant>>((ref) {
  return ref.read(tenantServiceProvider).getAllTenantsStream();
});

/// Future tenants theo buildingId (không realtime)
final tenantsByBuildingProvider = FutureProvider.family<List<Tenant>, String>((ref, buildingId) async {
  return await ref.read(tenantServiceProvider).getTenantsByBuilding(buildingId);
});
