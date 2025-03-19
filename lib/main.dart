import 'package:flutter/material.dart';
// import 'package:rental_management_app/features/auth/presentation/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:rental_management_app/features/building/presentation/pages/building_form_page.dart';
import 'package:rental_management_app/features/building/presentation/pages/building_list_page.dart';
import 'package:rental_management_app/features/home/presentation/pages/home_page.dart';
import 'package:rental_management_app/features/room/presentation/pages/room_list_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rental Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue        
      ),
      debugShowCheckedModeBanner: false,
      home: const RoomListPage(buildingId: 'building_001',)
    );
  }
}