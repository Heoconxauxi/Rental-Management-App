import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_management_app/features/utility_reading/domain/entities/utility_reading.dart';

class UtilityReadingModel extends UtilityReading {
  UtilityReadingModel({
    required super.id,
    required super.roomId,
    required super.readingMonth,
    required super.readingYear,
    required super.electricity,
    required super.water,
    required super.readingDate,
    required super.recordedBy,
    required super.notes,
    required super.createdAt,
  });

  factory UtilityReadingModel.fromMap(Map<String, dynamic> map) {
    return UtilityReadingModel(
      id: map['id'] as String? ?? 'UnknownID',
      roomId: map['roomId'] as String? ?? 'UnknownRoom',
      readingMonth: (map['readingMonth'] as int?) ?? 1,
      readingYear: (map['readingYear'] as int?) ?? 2023,
      electricity: Electricity(
        previous: (map['electricity']?['previous'] as int?) ?? 0,
        current: (map['electricity']?['current'] as int?) ?? 0,
        usage: (map['electricity']?['usage'] as int?) ?? 0,
      ),
      water: Water(
        previous: (map['water']?['previous'] as int?) ?? 0,
        current: (map['water']?['current'] as int?) ?? 0,
        usage: (map['water']?['usage'] as int?) ?? 0,
      ),
      readingDate: (map['readingDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      recordedBy: map['recordedBy'] as String? ?? 'UnknownRecorder',
      notes: map['notes'] as String? ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'roomId': roomId,
      'readingMonth': readingMonth,
      'readingYear': readingYear,
      'electricity': {
        'previous': electricity.previous,
        'current': electricity.current,
        'usage': electricity.usage,
      },
      'water': {
        'previous': water.previous,
        'current': water.current,
        'usage': water.usage,
      },
      'readingDate': Timestamp.fromDate(readingDate),
      'recordedBy': recordedBy,
      'notes': notes,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  UtilityReading toEntity() => this;

  static UtilityReadingModel fromEntity(UtilityReading entity) {
    return UtilityReadingModel(
      id: entity.id,
      roomId: entity.roomId,
      readingMonth: entity.readingMonth,
      readingYear: entity.readingYear,
      electricity: entity.electricity,
      water: entity.water,
      readingDate: entity.readingDate,
      recordedBy: entity.recordedBy,
      notes: entity.notes,
      createdAt: entity.createdAt,
    );
  }
}