import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../core/services/auth_service.dart';
import '../models/user_model.dart';

// Service
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// authStateProvider dùng AuthService
final authStateProvider = StreamProvider<User?>((ref) {
  final auth = ref.read(authServiceProvider);
  return auth.userChanges;
});

// firebaseAuth trực tiếp (cho go_router)
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firebaseAuthStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

// appUserProvider lấy thông tin từ Firestore
final appUserProvider = FutureProvider<AppUser?>((ref) async {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return null;
  return ref.read(authServiceProvider).getUserData(user.uid);
});
