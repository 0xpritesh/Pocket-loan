import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pocketloan/routes/app_routes.dart';

class ApplyLoanScreen extends StatefulWidget {
  const ApplyLoanScreen({super.key});

  @override
  State<ApplyLoanScreen> createState() => _ApplyLoanScreenState();
}

class _ApplyLoanScreenState extends State<ApplyLoanScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController amountController = TextEditingController();

  double availableLimit = 50000;
  double takenLoan = 0;
  double maxLimit = 50000;

  @override
  void initState() {
    super.initState();
    loadLoanData();
  }

  Future<void> loadLoanData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    availableLimit = prefs.getDouble('loanLimit') ?? 50000;
    takenLoan = prefs.getDouble('takenLoan') ?? 0;
    setState(() {});
  }

  Future<void> submitApplication() async {
    if (_formKey.currentState!.validate()) {
      double requestedAmount = double.tryParse(amountController.text) ?? 0;

      if (requestedAmount > availableLimit) {
        Get.snackbar(
          "Limit Exceeded",
          "You can only take up to ₹$availableLimit",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      availableLimit -= requestedAmount;
      takenLoan += requestedAmount;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('loanLimit', availableLimit);
      await prefs.setDouble('takenLoan', takenLoan);

      List<String> loans = prefs.getStringList('loanApplications') ?? [];
      Map<String, dynamic> newLoan = {
        "amount": requestedAmount,
        "status": "Approved",
        "emi": (requestedAmount / 5).round(),
        "monthsRemaining": 5,
        "totalMonths": 5,
        "date": DateTime.now().toIso8601String(),
      };
      loans.add(jsonEncode(newLoan));
      await prefs.setStringList('loanApplications', loans);

      Get.snackbar(
        "Success",
        "Loan of ₹$requestedAmount submitted!",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      await Future.delayed(const Duration(seconds: 2));
      Get.offAllNamed(AppRoutes.dashboardScreen, arguments: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    double usagePercent = (takenLoan / maxLimit).clamp(0, 1);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ✅ Dynamic Header with Gradient & Progress Bar
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    height: 220,
                    width: 360,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors:
                            availableLimit < 5000
                                ? [Colors.red.shade400, Colors.red.shade700]
                                : [
                                  const Color(0xFF4A67FF),
                                  const Color(0xFF2A49E8),
                                ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                        topLeft: Radius.circular(40),

                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Available Loan Limit",
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "₹${availableLimit.toStringAsFixed(0)}",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        availableLimit < 5000
                            ? "Low balance! Repay to apply again"
                            : "Get funds instantly in your account",
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// ✅ Loan Usage Progress Bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: usagePercent,
                          minHeight: 10,
                          backgroundColor: Colors.white24,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            availableLimit < 5000
                                ? Colors.redAccent
                                : Colors.greenAccent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Used: ₹${takenLoan.toStringAsFixed(0)} / ₹$maxLimit",
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ).animate().fadeIn(duration: 600.ms, curve: Curves.easeIn),

            const SizedBox(height: 30),

            /// ✅ Glassmorphic Loan Form
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Apply for Loan",
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),

                          /// ✅ Input Field
                          TextFormField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.poppins(fontSize: 16),
                            decoration: InputDecoration(
                              labelText: 'Loan Amount (INR)',
                              labelStyle: GoogleFonts.poppins(),
                              prefixIcon: const Icon(Icons.currency_rupee),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 18,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            validator:
                                (value) =>
                                    value!.isEmpty
                                        ? 'Please enter an amount'
                                        : null,
                          ),
                          const SizedBox(height: 24),

                          /// ✅ Gradient Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: submitApplication,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF4A67FF),
                                      Color(0xFF2A49E8),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Container(
                                  height: 55,
                                  width: 360,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Submit Application",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ).animate().scale(duration: 500.ms),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
