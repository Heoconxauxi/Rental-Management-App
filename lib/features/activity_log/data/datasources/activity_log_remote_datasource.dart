import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/activity_log_model.dart';
import '../../domain/entities/activity_log.dart';

abstract class ActivityLogRemoteDataSource {
  Future<List<ActivityLog>> getLogsByUser(String userId);
  Future<ActivityLog> getLogById(String logId);
  Future<void> addLog(ActivityLog log);
  Future<void> deleteLog(String logId);
}

class ActivityLogRemoteDataSourceImpl implements ActivityLogRemoteDataSource {
  final FirebaseFirestore firestore;

  ActivityLogRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<ActivityLog>> getLogsByUser(String userId) async {
    final snapshot = await firestore
        .collection('activityLogs')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => ActivityLogModel.fromMap(doc.data()).toEntity())
        .toList();
  }

  @override
  Future<ActivityLog> getLogById(String logId) async {
    final doc = await firestore.collection('activityLogs').doc(logId).get();
    if (!doc.exists) {
      throw Exception('Log not found');
    }
    return ActivityLogModel.fromMap(doc.data()!).toEntity();
  }

  @override
  Future<void> addLog(ActivityLog log) async {
    final model = ActivityLogModel.fromEntity(log);
    await firestore.collection('activityLogs').doc(log.id).set(model.toMap());
  }

  @override
  Future<void> deleteLog(String logId) async {
    await firestore.collection('activityLogs').doc(logId).delete();
  }
}