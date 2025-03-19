import 'package:flutter/material.dart';
import 'package:rental_management_app/features/auth/presentation/widgets/background_gradient.dart';
import 'package:rental_management_app/features/auth/presentation/widgets/login_form.dart';
import 'package:rental_management_app/features/auth/presentation/widgets/social_login_button.dart';
import 'package:rental_management_app/features/home/presentation/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  void _onGoogleLogin() {

  }

  void _onFacebookLogin() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGradient(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                const Text(
                  "RENTAL MANAGEMENT",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 28, 
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 3,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                LoginForm(
                  emailController: emailController,
                  passwordController: passwordController,
                  onLogin: _onLogin,
                ),
                const SizedBox(height: 32),
                SocialLoginButtons(
                  onGoogleLogin: _onGoogleLogin,
                  onFacebookLogin: _onFacebookLogin,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}