import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketloan/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final aadharController = TextEditingController();
  final panController = TextEditingController();
  final addressController = TextEditingController();
  final incomeController = TextEditingController();

  RxString selectedGender = ''.obs;
  RxString maritalStatus = ''.obs;
  RxString employmentType = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

   Future<void> updateUser() async {
  if (nameController.text.isEmpty ||
      dobController.text.isEmpty ||
      aadharController.text.length != 12 ||
      panController.text.length != 10 ||
      addressController.text.isEmpty ||
      incomeController.text.isEmpty ||
      selectedGender.value.isEmpty ||
      maritalStatus.value.isEmpty ||
      employmentType.value.isEmpty) {
    Get.snackbar("Error", "Please fill all fields correctly",
        backgroundColor: Colors.red, colorText: Colors.white);
    return;
  }

    // ✅ Aadhar Validation (12 digits)
    if (!RegExp(r'^\d{12}$').hasMatch(aadharController.text)) {
      Get.snackbar("Error", "Aadhar must be 12 digits",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // ✅ PAN Validation (e.g., ABCDE1234F)
    if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$').hasMatch(panController.text.toUpperCase())) {
      Get.snackbar("Error", "Invalid PAN format (e.g., ABCDE1234F)",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('name', nameController.text);
  await prefs.setString('dob', dobController.text);
  await prefs.setString('aadhar', aadharController.text);
  await prefs.setString('pan', panController.text);
  await prefs.setString('address', addressController.text);
  await prefs.setString('income', incomeController.text);
  await prefs.setString('gender', selectedGender.value);
  await prefs.setString('maritalStatus', maritalStatus.value);
  await prefs.setString('employmentType', employmentType.value);

  await prefs.setBool('isPersonalInfoCompleted', true); // ✅ Mark as completed

  Get.snackbar("Success", "Information saved",
      backgroundColor: Colors.green, colorText: Colors.white);

  await Future.delayed(const Duration(seconds: 1));
  Get.offNamed(AppRoutes.documentVerification);
}}
