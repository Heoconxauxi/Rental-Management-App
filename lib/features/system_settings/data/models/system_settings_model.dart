import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_management_app/features/system_settings/domain/entities/system_settings.dart';

class SystemSettingsModel extends SystemSettings {
  SystemSettingsModel({
    required super.id,
    super.buildingId,
    required super.settings,
    required super.updatedBy,
    required super.updatedAt,
  });

  factory SystemSettingsModel.fromMap(Map<String, dynamic> map) {
    return SystemSettingsModel(
      id: map['id'] as String? ?? 'UnknownID',
      buildingId: map['buildingId'] as String?,
      settings: Setting(
        electricityDefaultPrice: (map['settings']?['electricityDefaultPrice'] as num?)?.toDouble(),
        waterDefaultPrice: (map['settings']?['waterDefaultPrice'] as num?)?.toDouble(),
        invoiceDueDays: map['settings']?['invoiceDueDays'] as int?,
        autoGenerateInvoice: map['settings']?['autoGenerateInvoice'] as bool?,
        paymentReminderDays: map['settings']?['paymentReminderDays'] as int?,
        contractReminderDays: map['settings']?['contractReminderDays'] as int?,
        lateFee: (map['settings']?['lateFee'] as num?)?.toDouble(),
        lateFeePercentage: (map['settings']?['lateFeePercentage'] as num?)?.toDouble(),
        companyInfo: map['settings']?['companyInfo'] != null
            ? CompanyInfo(
                name: map['settings']['companyInfo']['name'] as String? ?? 'UnknownName',
                address: map['settings']['companyInfo']['address'] as String? ?? 'UnknownAddress',
                phone: map['settings']['companyInfo']['phone'] as String? ?? 'UnknownPhone',
                email: map['settings']['companyInfo']['email'] as String? ?? 'UnknownEmail',
                taxCode: map['settings']['companyInfo']['taxCode'] as String? ?? 'UnknownTaxCode',
              )
            : null,
        electricityPrice: (map['settings']?['electricityPrice'] as num?)?.toDouble(),
        waterPrice: (map['settings']?['waterPrice'] as num?)?.toDouble(),
        serviceFee: (map['settings']?['serviceFee'] as num?)?.toDouble(),
        internetFee: (map['settings']?['internetFee'] as num?)?.toDouble(),
        cleaningFee: (map['settings']?['cleaningFee'] as num?)?.toDouble(),
        parkingFee: (map['settings']?['parkingFee'] as num?)?.toDouble(),
        securityFee: (map['settings']?['securityFee'] as num?)?.toDouble(),
      ),
      updatedBy: map['updatedBy'] as String? ?? 'UnknownUpdater',
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'buildingId': buildingId,
      'settings': {
        'electricityDefaultPrice': settings.electricityDefaultPrice,
        'waterDefaultPrice': settings.waterDefaultPrice,
        'invoiceDueDays': settings.invoiceDueDays,
        'autoGenerateInvoice': settings.autoGenerateInvoice,
        'paymentReminderDays': settings.paymentReminderDays,
        'contractReminderDays': settings.contractReminderDays,
        'lateFee': settings.lateFee,
        'lateFeePercentage': settings.lateFeePercentage,
        'companyInfo': settings.companyInfo != null
            ? {
                'name': settings.companyInfo!.name,
                'address': settings.companyInfo!.address,
                'phone': settings.companyInfo!.phone,
                'email': settings.companyInfo!.email,
                'taxCode': settings.companyInfo!.taxCode,
              }
            : null,
        'electricityPrice': settings.electricityPrice,
        'waterPrice': settings.waterPrice,
        'serviceFee': settings.serviceFee,
        'internetFee': settings.internetFee,
        'cleaningFee': settings.cleaningFee,
        'parkingFee': settings.parkingFee,
        'securityFee': settings.securityFee,
      },
      'updatedBy': updatedBy,
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  SystemSettings toEntity() => this;

  static SystemSettingsModel fromEntity(SystemSettings entity) {
    return SystemSettingsModel(
      id: entity.id,
      buildingId: entity.buildingId,
      settings: Setting(
        electricityDefaultPrice: entity.settings.electricityDefaultPrice,
        waterDefaultPrice: entity.settings.waterDefaultPrice,
        invoiceDueDays: entity.settings.invoiceDueDays,
        autoGenerateInvoice: entity.settings.autoGenerateInvoice,
        paymentReminderDays: entity.settings.paymentReminderDays,
        contractReminderDays: entity.settings.contractReminderDays,
        lateFee: entity.settings.lateFee,
        lateFeePercentage: entity.settings.lateFeePercentage,
        companyInfo: entity.settings.companyInfo != null
            ? CompanyInfo(
                name: entity.settings.companyInfo!.name,
                address: entity.settings.companyInfo!.address,
                phone: entity.settings.companyInfo!.phone,
                email: entity.settings.companyInfo!.email,
                taxCode: entity.settings.companyInfo!.taxCode,
              )
            : null,
        electricityPrice: entity.settings.electricityPrice,
        waterPrice: entity.settings.waterPrice,
        serviceFee: entity.settings.serviceFee,
        internetFee: entity.settings.internetFee,
        cleaningFee: entity.settings.cleaningFee,
        parkingFee: entity.settings.parkingFee,
        securityFee: entity.settings.securityFee,
      ),
      updatedBy: entity.updatedBy,
      updatedAt: entity.updatedAt,
    );
  }
}