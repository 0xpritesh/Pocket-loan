// // lib/screens/admin/active_loans.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pocketloan/controller/admin_controller.dart';

// class ActiveLoansScreen extends StatelessWidget {
//   final AdminController adminController = Get.put(AdminController());

//   ActiveLoansScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final loans = adminController.activeLoans;
//       return ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: loans.length,
//         itemBuilder: (context, index) {
//           final loan = loans[index];
//           return Card(
//             margin: const EdgeInsets.only(bottom: 12),
//             elevation: 3,
//             child: ListTile(
//               title: Text('Loan ID: ${loan.id}'),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 8),
//                   Text('User ID: ${loan.userId}'),
//                   Text('Amount: ₹${loan.amount.toStringAsFixed(2)}'),
//                   Text('Status: ${loan.status}'),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     });
//   }
// }