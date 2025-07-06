import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/user_service.dart';
import '../models/user_model.dart';

/// Provider cho service
final userServiceProvider = Provider<UserService>((ref) => UserService());

/// Stream toàn bộ users
final allUsersProvider = StreamProvider<List<AppUser>>((ref) {
  return ref.read(userServiceProvider).getAllUsersStream();
});

/// Future lấy user theo ID
final userByIdProvider = FutureProvider.family<AppUser?, String>((ref, id) {
  return ref.read(userServiceProvider).getUserById(id);
});

/// Future lấy user theo tenant accountId
final usersByTenantIdProvider = FutureProvider.family<List<AppUser>, String>((ref, tenantAccountId) {
  return ref.read(userServiceProvider).getUsersByTenantId(tenantAccountId);
});

/// Future lấy user theo buildingId
final usersByBuildingIdProvider = FutureProvider.family<List<AppUser>, String>((ref, buildingId) {
  return ref.read(userServiceProvider).getUsersByBuildingId(buildingId);
});

final managerListProvider = StreamProvider<List<AppUser>>((ref) {
  final userService = ref.watch(userServiceProvider);
  return userService.getManagers();
});