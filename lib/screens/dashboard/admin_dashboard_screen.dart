import 'package:flutter/material.dart';
import 'package:rental_management_app/screens/building/building_list_screen.dart';
import 'package:rental_management_app/screens/contract/contract_list_screen.dart';
import 'package:rental_management_app/screens/invoice/invoice_list_screen.dart';
import 'package:rental_management_app/screens/notification/notification_list_screen.dart';
import 'package:rental_management_app/screens/tenant/tenant_list_screen.dart';
import 'package:rental_management_app/screens/profile/profile_screen.dart';
import 'package:rental_management_app/screens/user/user_list_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    BuildingListScreen(),
    ContractListScreen(),
    TenantListScreen(),
    InvoiceListScreen(),
    UserListScreen(),
    NotificationListScreen(),
    ProfileScreen(),
  ];

  final List<BottomNavigationBarItem> _items = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.apartment),
      label: 'Building',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.description),
      label: 'Contract',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      label: 'Tenant',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.receipt_long),
      label: 'Invoice',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.group),
      label: 'User',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications),
      label: 'Notification',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _items,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
