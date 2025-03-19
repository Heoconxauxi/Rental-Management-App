import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/utility_reading_model.dart';
import '../../domain/entities/utility_reading.dart';

abstract class UtilityReadingRemoteDataSource {
  Future<List<UtilityReading>> getReadingsByRoom(String roomId);
  Future<UtilityReading> getReadingById(String readingId);
  Future<void> addReading(UtilityReading reading);
  Future<void> updateReading(UtilityReading reading);
  Future<void> deleteReading(String readingId);
}

class UtilityReadingRemoteDataSourceImpl implements UtilityReadingRemoteDataSource {
  final FirebaseFirestore firestore;

  UtilityReadingRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<UtilityReading>> getReadingsByRoom(String roomId) async {
    final snapshot = await firestore
        .collection('utilityReadings')
        .where('roomId', isEqualTo: roomId)
        .get();
    return snapshot.docs
        .map((doc) => UtilityReadingModel.fromMap(doc.data()).toEntity())
        .toList();
  }

  @override
  Future<UtilityReading> getReadingById(String readingId) async {
    final doc = await firestore.collection('utilityReadings').doc(readingId).get();
    if (!doc.exists) {
      throw Exception('Reading not found');
    }
    return UtilityReadingModel.fromMap(doc.data()!).toEntity();
  }

  @override
  Future<void> addReading(UtilityReading reading) async {
    final model = UtilityReadingModel.fromEntity(reading);
    await firestore.collection('utilityReadings').doc(reading.id).set(model.toMap());
  }

  @override
  Future<void> updateReading(UtilityReading reading) async {
    final model = UtilityReadingModel.fromEntity(reading);
    await firestore.collection('utilityReadings').doc(reading.id).update(model.toMap());
  }

  @override
  Future<void> deleteReading(String readingId) async {
    await firestore.collection('utilityReadings').doc(readingId).delete();
  }
}