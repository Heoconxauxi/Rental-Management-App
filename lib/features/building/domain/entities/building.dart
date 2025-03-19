class Building {
  final String id;
  final String buildingName;
  final String address;
  final String district;
  final String city;
  final String description;
  final int totalRooms;
  final String managerId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String settingsId;

  const Building({
    required this.id,
    required this.buildingName,
    required this.address,
    required this.district,
    required this.city,
    required this.description,
    required this.totalRooms,
    required this.managerId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.settingsId,
  });

  List<Object?> get props => [
        id,
        buildingName,
        address,
        district,
        city,
        description,
        totalRooms,
        managerId,
        status,
        createdAt,
        updatedAt,
        settingsId,
      ];
}
