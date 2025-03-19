import 'package:flutter/material.dart';
import 'package:rental_management_app/core/constants/assets_manager.dart';

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback onGoogleLogin;
  final VoidCallback onFacebookLogin;

  const SocialLoginButtons({
    super.key,
    required this.onGoogleLogin,
    required this.onFacebookLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          icon: Image.asset(IconAssets.google, height: 20),
          label: const Text("Đăng nhập bằng Google", style: TextStyle(color: Colors.black)),
          onPressed: onGoogleLogin,
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF1877f2)),
          icon: const Icon(Icons.facebook, color: Colors.white),
          label: const Text("Đăng nhập bằng Facebook", style: TextStyle(color: Colors.white)),
          onPressed: onFacebookLogin,
        ),
      ],
    );
  }
}