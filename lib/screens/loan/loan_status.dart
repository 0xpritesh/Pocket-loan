import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanStatusScreen extends StatefulWidget {
  const LoanStatusScreen({super.key});

  @override
  State<LoanStatusScreen> createState() => _LoanStatusScreenState();
}

class _LoanStatusScreenState extends State<LoanStatusScreen> {
  List<Map<String, dynamic>> loanApplications = [];

  @override
  void initState() {
    super.initState();
    loadLoanApplications();
  }

  Future<void> loadLoanApplications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> loans = prefs.getStringList('loanApplications') ?? [];
    loanApplications =
        loans.map((e) => jsonDecode(e) as Map<String, dynamic>).toList();
    setState(() {});
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "approved":
        return Colors.green;
      case "pending":
        return Colors.orange;
      case "rejected":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case "approved":
        return Icons.check_circle;
      case "pending":
        return Icons.hourglass_bottom;
      case "rejected":
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      
      body: loanApplications.isEmpty
          ? Center(
              child: Text(
                "No loan applications yet",
                style: GoogleFonts.poppins(
                    fontSize: 18, color: Colors.grey.shade700),
              ).animate().fadeIn(duration: 400.ms),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: loanApplications.length,
              itemBuilder: (context, index) {
                final loan = loanApplications[index];
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
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: getStatusColor(loan['status'])
                          .withOpacity(0.15),
                      radius: 28,
                      child: Icon(
                        getStatusIcon(loan['status']),
                        color: getStatusColor(loan['status']),
                        size: 28,
                      ),
                    ),
                    title: Text(
                      "₹${loan['amount']}",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Applied on: ${loan['date'].toString().split('T')[0]}",
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          Text(
                            "EMI: ₹${loan['emi']} | ${loan['monthsRemaining']} of ${loan['totalMonths']} months",
                            style: GoogleFonts.poppins(
                                fontSize: 13, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    trailing: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: getStatusColor(loan['status']).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        loan['status'],
                        style: GoogleFonts.poppins(
                          color: getStatusColor(loan['status']),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ).animate().slideX(begin: 1, duration: 500.ms);
              },
            ),
    );
  }
}
