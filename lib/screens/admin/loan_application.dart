// // lib/screens/admin/loan_applications.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pocketloan/controller/admin_controller.dart';

// class LoanApplicationsScreen extends StatelessWidget {
//   final AdminController adminController = Get.put(AdminController());

//   LoanApplicationsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: adminController.loanApplications.length,
//         itemBuilder: (context, index) {
//           final loan = adminController.loanApplications[index];
//           return Card(
//             margin: const EdgeInsets.only(bottom: 16),
//             elevation: 3,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Loan ID: ${loan.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 8),
//                   Text('User ID: ${loan.userId}'),
//                   Text('Amount: ₹${loan.amount.toStringAsFixed(2)}'),
//                   Text('Status: ${loan.status}'),
//                   const SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       if (loan.status == 'pending') ...[
//                         ElevatedButton(
//                           onPressed: () => adminController.approveLoan(loan.id),
//                           child: const Text('Approve'),
//                           style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                         ),
//                         const SizedBox(width: 8),
//                         ElevatedButton(
//                           onPressed: () => adminController.rejectLoan(loan.id),
//                           child: const Text('Reject'),
//                           style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                         ),
//                       ] else
//                         Chip(
//                           label: Text(
//                             loan.status.toUpperCase(),
//                             style: const TextStyle(color: Colors.white),
//                           ),
//                           backgroundColor:
//                               loan.status == 'approved' ? Colors.green : Colors.red,
//                         ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
