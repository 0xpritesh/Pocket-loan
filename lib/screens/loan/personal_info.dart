import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocketloan/controller/user_controller.dart';
import '../../routes/app_routes.dart';

class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({super.key});
  final UserController userController = Get.put(UserController());

  final List<String> genderOptions = ['Male', 'Female', 'Other'];
  final List<String> maritalOptions = ['Single', 'Married'];
  final List<String> employmentOptions = ['Salaried', 'Self-employed', 'Unemployed'];

  Future<void> _savePersonalInfo() async {
    await userController.updateUser();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isProfileCompleted', true);

    Get.snackbar("Success", "Profile saved successfully",
        backgroundColor: Colors.green, colorText: Colors.white);

    Get.offAllNamed(AppRoutes.documentVerificationScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: AppBar(
        title: Text("Personal Information",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Fill in your personal details",
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold))
                .animate()
                .fadeIn(duration: 500.ms)
                .slideY(begin: -0.2, duration: 500.ms),
            const SizedBox(height: 20),

            _buildTextField("Full Name", userController.nameController)
                .animate().fadeIn(duration: 400.ms).slideX(begin: -0.3),
            const SizedBox(height: 12),

            _buildTextField(
              "Date of Birth",
              userController.dobController,
              readOnly: true,
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  userController.dobController.text =
                      "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
                }
              },
            ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.3),
            const SizedBox(height: 12),

            _buildDropdown("Gender", genderOptions, userController.selectedGender)
                .animate().fadeIn(duration: 500.ms),
            const SizedBox(height: 12),

            _buildTextField(
              "Aadhar Number",
              userController.aadharController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(12)
              ],
            ).animate().fadeIn(duration: 600.ms),
            const SizedBox(height: 12),

            _buildTextField(
              "PAN Number",
              userController.panController,
              keyboardType: TextInputType.text,
              inputFormatters: [
                UpperCaseTextFormatter(),
                LengthLimitingTextInputFormatter(10)
              ],
            ).animate().fadeIn(duration: 700.ms),
            const SizedBox(height: 12),

            _buildTextField("Address", userController.addressController, maxLines: 2)
                .animate().fadeIn(duration: 800.ms),
            const SizedBox(height: 12),

            _buildDropdown("Marital Status", maritalOptions, userController.maritalStatus)
                .animate().fadeIn(duration: 900.ms),
            const SizedBox(height: 12),

            _buildDropdown("Employment Type", employmentOptions, userController.employmentType)
                .animate().fadeIn(duration: GetNumUtils(1).seconds),
            const SizedBox(height: 12),

            _buildTextField("Annual Income (₹)", userController.incomeController,
                keyboardType: TextInputType.number)
                .animate().fadeIn(duration: GetNumUtils(1.1).seconds),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _savePersonalInfo,
                icon: const Icon(Icons.save),
                label: Text("Save Information",
                    style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                ),
              ).animate().scale(duration: 500.ms),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: GoogleFonts.poppins(fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: readOnly ? const Icon(Icons.calendar_today, color: Colors.blueAccent) : null,
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, RxString selectedValue) {
    return Obx(() => DropdownButtonFormField<String>(
          value: selectedValue.value.isEmpty ? null : selectedValue.value,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (value) => selectedValue.value = value ?? '',
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: GoogleFonts.poppins(),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: Colors.white,
          ),
        ));
  }
}

/// ✅ PAN Uppercase Formatter
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
