import 'package:flutter/material.dart';
import 'package:rental_management_app/screens/contract/contract_list_screen.dart';
import 'package:rental_management_app/screens/invoice/invoice_list_screen.dart';
import 'package:rental_management_app/screens/notification/user_notification_screen.dart';
import 'package:rental_management_app/screens/profile/profile_screen.dart';
import 'package:rental_management_app/screens/tenant/tenant_list_screen.dart';
import 'package:rental_management_app/screens/user/user_list_screen.dart';


class ManagerDashboardScreen extends StatefulWidget {
  const ManagerDashboardScreen({super.key});

  @override
  State<ManagerDashboardScreen> createState() => _ManagerDashboardScreenState();
}

class _ManagerDashboardScreenState extends State<ManagerDashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    ContractListScreen(),
    TenantListScreen(),
    InvoiceListScreen(),
    UserListScreen(),
    UserNotificationScreen(),
    ProfileScreen(),
  ];

  final List<BottomNavigationBarItem> _items = const [
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
