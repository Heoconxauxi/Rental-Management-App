import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/system_settings_model.dart';
import '../../domain/entities/system_settings.dart';

abstract class SystemSettingsRemoteDataSource {
  Future<SystemSettings> getSettingsById(String settingsId);
  Future<SystemSettings> getSettingsByBuilding(String buildingId);
  Future<void> addSettings(SystemSettings settings);
  Future<void> updateSettings(SystemSettings settings);
  Future<void> deleteSettings(String settingsId);
}

class SystemSettingsRemoteDataSourceImpl implements SystemSettingsRemoteDataSource {
  final FirebaseFirestore firestore;

  SystemSettingsRemoteDataSourceImpl({required this.firestore});

  @override
  Future<SystemSettings> getSettingsById(String settingsId) async {
    final doc = await firestore.collection('systemSettings').doc(settingsId).get();
    if (!doc.exists) {
      throw Exception('Settings not found');
    }
    return SystemSettingsModel.fromMap(doc.data()!).toEntity();
  }

  @override
  Future<SystemSettings> getSettingsByBuilding(String buildingId) async {
    final snapshot = await firestore
        .collection('systemSettings')
        .where('buildingId', isEqualTo: buildingId)
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) {
      throw Exception('Settings not found for building');
    }
    return SystemSettingsModel.fromMap(snapshot.docs.first.data()).toEntity();
  }

  @override
  Future<void> addSettings(SystemSettings settings) async {
    final model = SystemSettingsModel.fromEntity(settings);
    await firestore.collection('systemSettings').doc(settings.id).set(model.toMap());
  }

  @override
  Future<void> updateSettings(SystemSettings settings) async {
    final model = SystemSettingsModel.fromEntity(settings);
    await firestore.collection('systemSettings').doc(settings.id).update(model.toMap());
  }

  @override
  Future<void> deleteSettings(String settingsId) async {
    await firestore.collection('systemSettings').doc(settingsId).delete();
  }
}