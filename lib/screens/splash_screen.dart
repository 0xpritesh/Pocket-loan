import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _navigateBasedOnLoginStatus();

    return Scaffold(
      backgroundColor: Colors.white, // Optional: Change to your theme color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// ✅ App Logo (Network Image)
            Image.network(
              'https://lh3.googleusercontent.com/A7SiBny1tPXErSRodE9T4U-3dZWzzEBw6YWTOWew0mPEq5wo0FVMbBEUuwYVJfxIIF0', // Replace with your image URL
              width: 150,
              height: 150,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const CircularProgressIndicator();
              },
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, size: 80, color: Colors.red);
              },
            ),

            const SizedBox(height: 16),

            

            const SizedBox(height: 16),

            const CircularProgressIndicator(), // Loading indicator
          ],
        ),
      ),
    );
  }

  void _navigateBasedOnLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2)); // Optional delay
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    bool isPersonalInfoCompleted = prefs.getBool('isPersonalInfoCompleted') ?? false;
    bool isDocumentVerified = prefs.getBool('isDocumentVerified') ?? false;

    if (!isLoggedIn) {
      Get.offAllNamed(AppRoutes.login);
    } else if (!isPersonalInfoCompleted) {
      Get.offAllNamed(AppRoutes.loanApplications);
    } else if (!isDocumentVerified) {
      Get.offAllNamed(AppRoutes.documentVerification);
    } else {
      Get.offAllNamed(AppRoutes.dashboardScreen);
    }
  }
}
