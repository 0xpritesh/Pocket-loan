import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketloan/model/loan_model.dart';

class LoanDetailsCard extends StatelessWidget {
  final LoanModel loan;
  const LoanDetailsCard({super.key, required this.loan});

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

  double calculateEMI(double principal, double annualInterestRate, int months) {
    final r = (annualInterestRate / 12) / 100;
    final emi = (principal * r * pow(1 + r, months)) / (pow(1 + r, months) - 1);
    return emi;
  }

  @override
  Widget build(BuildContext context) {
    final emi = calculateEMI(loan.amount, loan.interestRate, loan.months);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Loan ID: ${loan.id}", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("User ID: ${loan.userId}"),
            Text("Loan Amount: ₹${loan.amount.toStringAsFixed(2)}"),
            Text("Duration: ${loan.months} months"),
            Text("Interest Rate: ${loan.interestRate}% / year"),
            const SizedBox(height: 8),
            Text(
              "Monthly EMI: ₹${emi.toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("Total Repayment: ₹${(emi * loan.months).toStringAsFixed(2)}"),
            const SizedBox(height: 10),
            const Text("Documents:", style: TextStyle(fontWeight: FontWeight.w500)),
            ...loan.documents.map((doc) => Text("- $doc")),
            const SizedBox(height: 8),
            Text("Status: ${loan.status.capitalize}",
                style: TextStyle(
                  color: getStatusColor(loan.status),
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}
