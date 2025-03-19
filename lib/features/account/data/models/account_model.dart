import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rental_management_app/features/account/domain/entities/account.dart';

class AccountModel extends Account {
  AccountModel({
    required super.id,
    required super.username,
    required super.email,
    required super.fullName,
    required super.phone,
    required super.role,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    super.lastLogin,
    required super.avatarUrl,
    required String passwordHash,
  }) : _passwordHash = passwordHash;

  final String _passwordHash;

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map['id'] as String? ?? 'UnknownID',
      username: map['username'] as String? ?? 'UnknownUsername',
      email: map['email'] as String? ?? 'UnknownEmail',
      passwordHash: map['passwordHash'] as String? ?? '',
      fullName: map['fullName'] as String? ?? 'UnknownName',
      phone: map['phone'] as String? ?? 'UnknownPhone',
      role: map['role'] as String? ?? 'UnknownRole',
      status: map['status'] as String? ?? 'Unknown',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastLogin: (map['lastLogin'] as Timestamp?)?.toDate(),
      avatarUrl: map['avatarUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'passwordHash': _passwordHash,
      'fullName': fullName,
      'phone': phone,
      'role': role,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'lastLogin': lastLogin != null ? Timestamp.fromDate(lastLogin!) : null,
      'avatarUrl': avatarUrl,
    };
  }

  Account toEntity() => this;

  static AccountModel fromEntity(Account entity, {String? passwordHash}) {
    return AccountModel(
      id: entity.id,
      username: entity.username,
      email: entity.email,
      passwordHash: passwordHash ?? '',
      fullName: entity.fullName,
      phone: entity.phone,
      role: entity.role,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      lastLogin: entity.lastLogin,
      avatarUrl: entity.avatarUrl,
    );
  }
}