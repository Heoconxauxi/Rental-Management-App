import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/account_model.dart';
import '../../domain/entities/account.dart';

abstract class AccountRemoteDataSource {
  Future<Account> getAccountById(String accountId);
  Future<Account> getAccountByEmail(String email);
  Future<void> addAccount(Account account, String passwordHash);
  Future<void> updateAccount(Account account);
  Future<void> deleteAccount(String accountId);
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final FirebaseFirestore firestore;

  AccountRemoteDataSourceImpl({required this.firestore});

  @override
  Future<Account> getAccountById(String accountId) async {
    final doc = await firestore.collection('accounts').doc(accountId).get();
    if (!doc.exists) {
      throw Exception('Account not found');
    }
    return AccountModel.fromMap(doc.data()!).toEntity();
  }

  @override
  Future<Account> getAccountByEmail(String email) async {
    final snapshot = await firestore
        .collection('accounts')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    if (snapshot.docs.isEmpty) {
      throw Exception('Account not found');
    }
    return AccountModel.fromMap(snapshot.docs.first.data()).toEntity();
  }

  @override
  Future<void> addAccount(Account account, String passwordHash) async {
    final model = AccountModel.fromEntity(account, passwordHash: passwordHash);
    await firestore.collection('accounts').doc(account.id).set(model.toMap());
  }

  @override
  Future<void> updateAccount(Account account) async {
    final model = AccountModel.fromEntity(account);
    await firestore.collection('accounts').doc(account.id).update(model.toMap());
  }

  @override
  Future<void> deleteAccount(String accountId) async {
    await firestore.collection('accounts').doc(accountId).delete();
  }
}