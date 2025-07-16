import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketloan/model/loan_model.dart';

class LoanController extends GetxController {
  RxList<LoanModel> loanList = <LoanModel>[].obs;
  final String currentUserId = 'user_123';
  RxBool isSubmitting = false.obs;

  void submitLoanApplicationWithDocs({
    required double amount,
    required List<String> documents,
    int months = 12,
    double interestRate = 10.0,
  }) async {
    isSubmitting.value = true;

    final newLoan = LoanModel(
      id: 'LN${DateTime.now().millisecondsSinceEpoch}',
      userId: currentUserId,
      amount: amount,
      status: 'pending',
      documents: documents,
      months: months,
      interestRate: interestRate,
    );

    await Future.delayed(const Duration(seconds: 2));
    loanList.insert(0, newLoan);
    isSubmitting.value = false;

    // Auto-approve after 10 sec
    Future.delayed(const Duration(seconds: 10), () {
      updateLoanStatus(newLoan.id, 'approved');
    });

    Get.snackbar("Success", "Loan Submitted", backgroundColor: Colors.green, colorText: Colors.white);
    Get.toNamed('/loan-status');
  }

  void updateLoanStatus(String id, String newStatus) {
    final index = loanList.indexWhere((loan) => loan.id == id);
    if (index != -1) {
      final existing = loanList[index];
      loanList[index] = LoanModel(
        id: existing.id,
        userId: existing.userId,
        amount: existing.amount,
        status: newStatus,
        documents: existing.documents,
        months: existing.months,
        interestRate: existing.interestRate,
      );
    }
  }
}
