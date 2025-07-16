// // lib/screens/admin/user_profiles.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pocketloan/controller/admin_controller.dart';

// class UserProfilesScreen extends StatelessWidget {
//   final AdminController adminController = Get.put(AdminController());

//   UserProfilesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final users = adminController.userProfiles;
//       return ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           final user = users[index];
//           return Card(
//             elevation: 2,
//             margin: const EdgeInsets.only(bottom: 12),
//             child: ListTile(
//               leading: CircleAvatar(
//                 child: Text(user.name[0].toUpperCase()),
//               ),
//               title: Text(user.name),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Email: ${user.email}'),
//                   Text('User ID: ${user.id}'),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     });
//   }
// }
