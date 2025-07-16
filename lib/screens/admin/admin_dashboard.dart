// // lib/screens/admin/admin_dashboard_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pocketloan/controller/admin_controller.dart';
// import 'package:pocketloan/screens/admin/active_loan.dart';
// import 'package:pocketloan/screens/admin/loan_application.dart';
// import 'package:pocketloan/screens/admin/support_request.dart';
// import 'package:pocketloan/screens/admin/user_profile.dart';


// class AdminDashboardScreen extends StatelessWidget {
//   final AdminController adminController = Get.put(AdminController());

//   AdminDashboardScreen({super.key});

//   final List<Widget> _adminTabs =  [
//     LoanApplicationsScreen(),
//     ActiveLoansScreen(),
//     UserProfilesScreen(),
//     SupportRequestsScreen(),
//   ];

//   final List<String> _tabTitles = [
//     'Loan Applications',
//     'Active Loans',
//     'User Profiles',
//     'Support Requests',
//   ];

//   final RxInt _selectedTab = 0.obs;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Scaffold(
//         appBar: AppBar(
//           title: Text(_tabTitles[_selectedTab.value]),
//         ),
//         body: _adminTabs[_selectedTab.value],
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _selectedTab.value,
//           onTap: (index) => _selectedTab.value = index,
//           selectedItemColor: Colors.deepPurple,
//           unselectedItemColor: Colors.grey,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.list_alt),
//               label: 'Applications',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.check_circle),
//               label: 'Active Loans',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.people),
//               label: 'Users',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.support_agent),
//               label: 'Support',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
