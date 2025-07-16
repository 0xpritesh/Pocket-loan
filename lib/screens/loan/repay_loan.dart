import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepayLoanScreen extends StatefulWidget {
  const RepayLoanScreen({super.key});

  @override
  State<RepayLoanScreen> createState() => _RepayLoanScreenState();
}

class _RepayLoanScreenState extends State<RepayLoanScreen> {
  List<Map<String, dynamic>> approvedLoans = [];

  @override
  void initState() {
    super.initState();
    loadApprovedLoans();
  }

  Future<void> loadApprovedLoans() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> loans = prefs.getStringList('loanApplications') ?? [];
    approvedLoans = loans
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .where((loan) => loan['status'] == 'Approved')
        .toList();
    setState(() {});
  }

  Future<void> payEMI(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    approvedLoans[index]['monthsRemaining']--;

    // ✅ If loan fully paid, mark as Completed & update loan limits
    if (approvedLoans[index]['monthsRemaining'] <= 0) {
      approvedLoans[index]['status'] = 'Completed';

      double availableLimit = prefs.getDouble('loanLimit') ?? 50000;
      double takenLoan = prefs.getDouble('takenLoan') ?? 0;
      double amount = approvedLoans[index]['amount'] ?? 0;

      takenLoan -= amount;
      availableLimit += amount;

      await prefs.setDouble('loanLimit', availableLimit);
      await prefs.setDouble('takenLoan', takenLoan);
    }

    // ✅ Update loanApplications list
    List<String> updatedLoans = prefs
        .getStringList('loanApplications')!
        .map((e) => jsonDecode(e) as Map<String, dynamic>)
        .map((loan) {
      if (loan['date'] == approvedLoans[index]['date']) {
        return approvedLoans[index];
      }
      return loan;
    }).map((loan) => jsonEncode(loan)).toList();

    await prefs.setStringList('loanApplications', updatedLoans);

    Get.snackbar(
      "Payment Successful",
      "You paid ₹${approvedLoans[index]['emi']}",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    loadApprovedLoans(); // Refresh UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
     
      body: approvedLoans.isEmpty
          ? Center(
              child: Text(
                "No approved loans to repay",
                style: GoogleFonts.poppins(
                    fontSize: 18, color: Colors.grey.shade700),
              ).animate().fadeIn(duration: 400.ms),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: approvedLoans.length,
              itemBuilder: (context, index) {
                final loan = approvedLoans[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Loan Amount: ₹${loan['amount']}",
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text("EMI: ₹${loan['emi']}",
                            style: GoogleFonts.poppins(fontSize: 15)),
                        Text(
                            "Remaining: ${loan['monthsRemaining']} of ${loan['totalMonths']} months",
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: Colors.grey[700])),
                        const SizedBox(height: 12),

                        /// ✅ Show Completed or Pay Button
                        loan['status'] == 'Completed'
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  "Loan Completed",
                                  style: GoogleFonts.poppins(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () => payEMI(index),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF4A67FF),
                                          Color(0xFF2A49E8)
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      child: Text(
                                        "Pay EMI ₹${loan['emi']}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ).animate().scale(duration: 500.ms),
                              ),
                      ],
                    ),
                  ),
                ).animate().slideX(begin: 1, duration: 500.ms);
              },
            ),
    );
  }
}
