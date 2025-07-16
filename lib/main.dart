// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketloan/controller/auth_controller.dart';
import 'package:pocketloan/controller/loan_controller.dart';
import 'package:pocketloan/routes/app_routes.dart';
import 'package:pocketloan/themes/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController()); 
  Get.put(LoanController()); 
  runApp(LoanApp());
}
class LoanApp extends StatelessWidget {
  const LoanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Loan Application',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash, 
      getPages: AppRoutes.routes,
    );
  }
}
