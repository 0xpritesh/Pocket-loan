import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pocketloan/controller/auth_controller.dart';
import 'package:pocketloan/widget/custom_textfield.dart';
import '../../routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              /// ✅ Icon Animation
              const Icon(Icons.account_circle, size: 100, color: Color(0xFF1565C0))
                  .animate()
                  .scale(duration: 600.ms, curve: Curves.easeOutBack)
                  .fadeIn(duration: 500.ms),

              const SizedBox(height: 16),

              /// ✅ Title
              Text(
                "Register",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.3, duration: 600.ms),

              const SizedBox(height: 8),

              /// ✅ Subtitle
              Text(
                "Create your account",
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
              ).animate().fadeIn(duration: 700.ms),

              const SizedBox(height: 20),

              /// ✅ Full Name Field
              CustomTextField(
                controller: authController.nameController,
                label: 'Full Name',
                hint: 'John Doe',
              )
                  .animate()
                  .slideX(begin: -0.4, duration: 500.ms)
                  .fadeIn(duration: 400.ms),

              const SizedBox(height: 16),

              /// ✅ Email Field
              CustomTextField(
                controller: authController.emailController,
                label: 'Email Address',
                hint: 'you@example.com',
              )
                  .animate()
                  .slideX(begin: 0.4, duration: 500.ms)
                  .fadeIn(duration: 400.ms),

              const SizedBox(height: 16),

              /// ✅ Phone Field
              CustomTextField(
                controller: authController.phoneController,
                label: 'Phone Number',
                hint: '9876543210',
                keyboardType: TextInputType.phone,
              )
                  .animate()
                  .slideX(begin: -0.4, duration: 500.ms)
                  .fadeIn(duration: 400.ms),

              const SizedBox(height: 16),

              /// ✅ Password Field
              CustomTextField(
                controller: authController.passwordController,
                label: 'Password',
                hint: 'Create a password',
                obscureText: true,
              )
                  .animate()
                  .slideX(begin: 0.4, duration: 500.ms)
                  .fadeIn(duration: 400.ms),

              const SizedBox(height: 32),

              /// ✅ Gradient Register Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: authController.register,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 4,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF4A67FF), Color(0xFF2A49E8)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'Register',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ).animate().scale(duration: 500.ms),
              ),

              const SizedBox(height: 16),

              /// ✅ Already have account? Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already registered?",
                    style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.login),
                    child: Text(
                      "Login here",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF1565C0),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 700.ms),
            ],
          ),
        ),
      ),
    );
  }
}
