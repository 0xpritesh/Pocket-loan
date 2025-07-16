import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/auth_controller.dart';
import '../../routes/app_routes.dart';
import '../../widget/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  LoginScreen({super.key});

  Future<void> _handleLogin() async {
    authController.login();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isProfileCompleted = prefs.getBool('isProfileCompleted') ?? false;
    bool isDocumentVerified = prefs.getBool('isDocumentVerified') ?? false;

    if (isProfileCompleted && isDocumentVerified) {
      Get.offAllNamed(AppRoutes.dashboardScreen);
    } else if (!isProfileCompleted) {
      Get.offAllNamed(AppRoutes.personalInfoScreen);
    } else if (!isDocumentVerified) {
      Get.offAllNamed(AppRoutes.documentVerificationScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Icon(Icons.account_circle, size: 100, color: Color(0xFF1565C0))
                  .animate().scale(duration: 600.ms, curve: Curves.easeOutBack).fadeIn(duration: 500.ms),

              const SizedBox(height: 16),
              Text("Welcome Back",
                  style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold))
                  .animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, duration: 600.ms),

              const SizedBox(height: 8),
              Text("Login to continue",
                  style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16))
                  .animate().fadeIn(duration: 800.ms),

              const SizedBox(height: 32),
              CustomTextField(controller: authController.emailController, label: 'Email', hint: 'Enter your email')
                  .animate().slideX(begin: -0.5, duration: 500.ms).fadeIn(duration: 400.ms),

              const SizedBox(height: 16),
              CustomTextField(controller: authController.passwordController, label: 'Password', hint: 'Enter your password', obscureText: true)
                  .animate().slideX(begin: 0.5, duration: 500.ms).fadeIn(duration: 400.ms),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  onPressed: _handleLogin,
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF4A67FF), Color(0xFF2A49E8)], begin: Alignment.centerLeft, end: Alignment.centerRight),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      height: 50, alignment: Alignment.center,
                      child: Text('Login', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ).animate().scale(duration: 500.ms),
              ),

              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.register),
                child: Text("Don't have an account? Register", style: GoogleFonts.poppins(color: Colors.blueAccent)),
              ).animate().fadeIn(duration: 600.ms),
            ],
          ),
        ),
      ),
    );
  }
}
