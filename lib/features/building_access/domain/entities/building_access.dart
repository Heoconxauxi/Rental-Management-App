class BuildingAccess {
  final String id;
  final String accountId;
  final String buildingId;
  final String accessLevel;
  final String grantedBy;
  final DateTime grantedDate;

  const BuildingAccess({
    required this.id,
    required this.accountId,
    required this.buildingId,
    required this.accessLevel,
    required this.grantedBy,
    required this.grantedDate,
  });

  List<Object?> get props => [
        id,
        accountId,
        buildingId,
        accessLevel,
        grantedBy,
        grantedDate,
      ];
}