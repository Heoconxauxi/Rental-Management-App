class SystemSettings {
  final String id;
  final String? buildingId;
  final Setting settings;
  final String updatedBy;
  final DateTime updatedAt;

  const SystemSettings({
    required this.id,
    this.buildingId,
    required this.settings,
    required this.updatedBy,
    required this.updatedAt,
  });

  List<Object?> get props => [
        id,
        buildingId,
        settings,
        updatedBy,
        updatedAt,
      ];
}

class Setting {
  final double? electricityDefaultPrice;
  final double? waterDefaultPrice;
  final int? invoiceDueDays;
  final bool? autoGenerateInvoice;
  final int? paymentReminderDays;
  final int? contractReminderDays;
  final double? lateFee;
  final double? lateFeePercentage;
  final CompanyInfo? companyInfo;
  final double? electricityPrice;
  final double? waterPrice;
  final double? serviceFee;
  final double? internetFee;
  final double? cleaningFee;
  final double? parkingFee;
  final double? securityFee;

  const Setting({
    this.electricityDefaultPrice,
    this.waterDefaultPrice,
    this.invoiceDueDays,
    this.autoGenerateInvoice,
    this.paymentReminderDays,
    this.contractReminderDays,
    this.lateFee,
    this.lateFeePercentage,
    this.companyInfo,
    this.electricityPrice,
    this.waterPrice,
    this.serviceFee,
    this.internetFee,
    this.cleaningFee,
    this.parkingFee,
    this.securityFee,
  });

  List<Object?> get props => [
        electricityDefaultPrice,
        waterDefaultPrice,
        invoiceDueDays,
        autoGenerateInvoice,
        paymentReminderDays,
        contractReminderDays,
        lateFee,
        lateFeePercentage,
        companyInfo,
        electricityPrice,
        waterPrice,
        serviceFee,
        internetFee,
        cleaningFee,
        parkingFee,
        securityFee,
      ];
}

class CompanyInfo {
  final String name;
  final String address;
  final String phone;
  final String email;
  final String taxCode;

  const CompanyInfo({
    required this.name,
    required this.address,
    required this.phone,
    required this.email,
    required this.taxCode,
  });

  List<Object?> get props => [name, address, phone, email, taxCode];
}