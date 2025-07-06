import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/building_service.dart';
import '../models/building_model.dart';

/// Provider cho service
final buildingServiceProvider = Provider<BuildingService>((ref) {
  return BuildingService();
});

/// StreamProvider cho danh sách building (realtime)
final buildingListProvider = StreamProvider<List<Building>>((ref) {
  final service = ref.read(buildingServiceProvider);
  return service.getAllBuildingsStream();
});
