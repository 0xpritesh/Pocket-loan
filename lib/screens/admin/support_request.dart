// // lib/screens/admin/support_requests.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pocketloan/controller/admin_controller.dart';

// class SupportRequestsScreen extends StatelessWidget {
//   final AdminController adminController = Get.put(AdminController());

//   SupportRequestsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final requests = adminController.supportRequests;
//       return ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: requests.length,
//         itemBuilder: (context, index) {
//           final request = requests[index];
//           return Card(
//             margin: const EdgeInsets.only(bottom: 16),
//             elevation: 3,
//             child: ListTile(
//               leading: const Icon(Icons.support_agent, color: Colors.indigo),
//               title: Text('Request ID: ${request.id}'),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 6),
//                   Text('Email: ${request.userEmail}'),
//                   const SizedBox(height: 4),
//                   Text('Message: ${request.message}'),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     });
//   }
// }
