import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketloan/screens/loan/apply_loan.dart';
import 'package:pocketloan/screens/loan/loan_status.dart';
import 'package:pocketloan/screens/loan/repay_loan.dart';
import 'package:pocketloan/screens/profile_setting.dart';

class DashboardScreen extends StatelessWidget {
  final RxInt selectedIndex = 0.obs;

  final List<String> tabTitles = [
    "Apply Loan",
    "Loan Status",
    "Repay Loan",
    "Profile"
  ];

  final List<Widget> pages = [
    ApplyLoanScreen(),
    LoanStatusScreen(),
    RepayLoanScreen(),
    ProfileScreen(),
  ];

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Check if navigation argument exists
    int initialTab = Get.arguments ?? 0;
    selectedIndex.value = initialTab;

    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(tabTitles[selectedIndex.value]),
            actions: [
             
            ],
          ),
          body: pages[selectedIndex.value],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: BottomNavigationBar(
                currentIndex: selectedIndex.value,
                onTap: (index) => selectedIndex.value = index,
                backgroundColor: Colors.white,
                selectedItemColor: Colors.blueAccent,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Apply'),
                  BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'Status'),
                  BottomNavigationBarItem(icon: Icon(Icons.payments_outlined), label: 'Repay'),
                  BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
                ],
              ),
            ),
          ),
        ));
  }
}
