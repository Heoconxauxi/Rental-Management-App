class Room {
  final String id;
  final String buildingId;
  final String roomNumber;
  final String roomType;
  final double area;
  final double basePrice;
  final double depositAmount;
  final String status;
  final String description;
  final Amenities amenities;
  final int maxOccupants;
  final int floor;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CurrentTenant? currentTenant;

  const Room({
    required this.id,
    required this.buildingId,
    required this.roomNumber,
    required this.roomType,
    required this.area,
    required this.basePrice,
    required this.depositAmount,
    required this.status,
    required this.description,
    required this.amenities,
    required this.maxOccupants,
    required this.floor,
    required this.createdAt,
    required this.updatedAt,
    this.currentTenant,
  });

  List<Object?> get props => [
        id,
        buildingId,
        roomNumber,
        roomType,
        area,
        basePrice,
        depositAmount,
        status,
        description,
        amenities,
        maxOccupants,
        floor,
        createdAt,
        updatedAt,
        currentTenant,
      ];
}

class Amenities {
  final bool wifi;
  final bool airConditioner;
  final bool fridge;
  final bool washingMachine;
  final bool balcony;
  final bool privateToilet;
  final bool hotWater;

  const Amenities({
    required this.wifi,
    required this.airConditioner,
    required this.fridge,
    required this.washingMachine,
    required this.balcony,
    required this.privateToilet,
    required this.hotWater,
  });

  List<Object?> get props => [
        wifi,
        airConditioner,
        fridge,
        washingMachine,
        balcony,
        privateToilet,
        hotWater,
      ]; 
}

class CurrentTenant {
  final String tenantId;
  final String tenantName;
  final String contractId;
  final DateTime moveInDate;

  const CurrentTenant({
    required this.tenantId,
    required this.tenantName,
    required this.contractId,
    required this.moveInDate,
  });

  List<Object?> get props => [tenantId, tenantName, contractId, moveInDate];
}