class UtilityReading {
  final String id;
  final String roomId;
  final int readingMonth;
  final int readingYear;
  final Electricity electricity;
  final Water water;
  final DateTime readingDate;
  final String recordedBy;
  final String notes;
  final DateTime createdAt;

  UtilityReading({
    required this.id,
    required this.roomId,
    required this.readingMonth,
    required this.readingYear,
    required this.electricity,
    required this.water,
    required this.readingDate,
    required this.recordedBy,
    required this.notes,
    required this.createdAt,
  }) {
    if (electricity.current < electricity.previous) {
      throw Exception('Current electricity reading must be greater than or equal to previous');
    }
    if (water.current < water.previous) {
      throw Exception('Current water reading must be greater than or equal to previous');
    }
  }

  List<Object?> get props => [
        id,
        roomId,
        readingMonth,
        readingYear,
        electricity,
        water,
        readingDate,
        recordedBy,
        notes,
        createdAt,
      ];
}

class Electricity {
  final int previous;
  final int current;
  final int usage;

  const Electricity({
    required this.previous,
    required this.current,
    required this.usage,
  });

  List<Object?> get props => [previous, current, usage];
}

class Water {
  final int previous;
  final int current;
  final int usage;

  const Water({
    required this.previous,
    required this.current,
    required this.usage,
  });

  List<Object?> get props => [previous, current, usage];
}