import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  /// ✅ Auto login check
  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      bool isProfileCompleted = prefs.getBool('isProfileCompleted') ?? false;
      bool isDocumentVerified = prefs.getBool('isDocumentVerified') ?? false;

      if (isProfileCompleted && isDocumentVerified) {
        Get.offAllNamed(AppRoutes.dashboardScreen);
      } else if (!isProfileCompleted) {
        Get.offAllNamed(AppRoutes.personalInfoScreen);
      } else {
        Get.offAllNamed(AppRoutes.documentVerificationScreen);
      }
    }
  }

  /// ✅ Register user
  void register() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar("Error", "All fields are required",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', nameController.text.trim());
    await prefs.setString('userEmail', emailController.text.trim());
    await prefs.setString('userPhone', phoneController.text.trim());
    await prefs.setString('registeredPassword', passwordController.text);
    Get.snackbar("Success", "Account created successfully!",
        backgroundColor: Colors.green, colorText: Colors.white);
    await Future.delayed(const Duration(seconds: 1));
    Get.offAllNamed(AppRoutes.login);
  }

  /// ✅ Login user
  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('userEmail') ?? '';
    final savedPassword = prefs.getString('registeredPassword') ?? '';

    if (email == savedEmail && password == savedPassword) {
      await prefs.setBool('isLoggedIn', true);

      bool isProfileCompleted = prefs.getBool('isProfileCompleted') ?? false;
      bool isDocumentVerified = prefs.getBool('isDocumentVerified') ?? false;

      if (isProfileCompleted && isDocumentVerified) {
        Get.offAllNamed(AppRoutes.dashboardScreen);
      } else if (!isProfileCompleted) {
        Get.offAllNamed(AppRoutes.personalInfoScreen);
      } else {
        Get.offAllNamed(AppRoutes.documentVerificationScreen);
      }
    } else {
      Get.snackbar("Login Failed", "Invalid email or password",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  /// ✅ Logout
  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed(AppRoutes.login);
  }
}
