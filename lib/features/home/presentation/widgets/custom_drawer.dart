import 'package:flutter/material.dart';
import 'package:rental_management_app/core/constants/assets_manager.dart';
import 'package:rental_management_app/features/home/presentation/pages/home_page.dart';
import 'package:rental_management_app/features/home/presentation/pages/notifications_page.dart';

class CustomDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;
  final VoidCallback onLogout;

  const CustomDrawer({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildHeader(),
          _buildMenuItem(
            icon: Icons.home,
            text: 'Trang chủ',
            onTap: () => Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => HomePage())
            ),
          ),
          _buildMenuItem(
            icon: Icons.notifications,
            text: 'Thông báo',
            onTap: () => Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => NotificationPage2())
            ),
          ),
          _buildMenuItem(
            icon: Icons.settings,
            text: 'Cài đặt',
            onTap: () => Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => HomePage())
            ),
          ),
          const Spacer(),
          _buildMenuItem(
            icon: Icons.logout,
            text: 'Đăng xuất',
            onTap: onLogout,
            color: Colors.redAccent,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text(userName, style: const TextStyle(fontWeight: FontWeight.bold)),
      accountEmail: Text(userEmail),
      currentAccountPicture: const CircleAvatar(
        backgroundImage: AssetImage(IconAssets.google),
      ),
      decoration: const BoxDecoration(color: Colors.black),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.black87),
      title: Text(text, style: TextStyle(color: color ?? Colors.black87)),
      onTap: onTap,
    );
  }
}
