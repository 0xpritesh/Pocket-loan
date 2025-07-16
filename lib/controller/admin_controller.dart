// import 'package:get/get.dart';
// import 'package:pocketloan/model/loan_model.dart';
// import 'package:pocketloan/model/support_model.dart';
// import 'package:pocketloan/model/user_model.dart';


// class AdminController extends GetxController {
//   // List of all loan applications (mocked)
//   RxList<LoanModel> loanApplications = <LoanModel>[].obs;

//   // List of user profiles (mocked)
//   RxList<UserModel> userProfiles = <UserModel>[].obs;

//   // Active approved loans
//   RxList<LoanModel> activeLoans = <LoanModel>[].obs;

//   // Support requests (mocked)
//   RxList<SupportRequest> supportRequests = <SupportRequest>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadMockData(); // Initial mock data
//   }

//   void loadMockData() {
//     loanApplications.assignAll([
//       LoanModel(
//         id: 'L001',
//         userId: 'U001',
//         amount: 250000,
//         status: 'pending',
//         documents: ['pan.pdf', 'aadhaar.pdf'],
//       ),
//       LoanModel(
//         id: 'L002',
//         userId: 'U002',
//         amount: 150000,
//         status: 'approved',
//         documents: ['all_docs.zip'],
//       ),
//     ]);

//     userProfiles.assignAll([
//       UserModel(id: 'U001', name: 'Amit Sharma', email: 'amit@gmail.com'),
//       UserModel(id: 'U002', name: 'Riya Mehta', email: 'riya@yahoo.com'),
//     ]);

//     activeLoans.assignAll(
//       loanApplications.where((loan) => loan.status == 'approved').toList(),
//     );

//     supportRequests.assignAll([
//       SupportRequest(
//         id: 'S001',
//         userEmail: 'amit@gmail.com',
//         message: 'I need help with my application.',
//       ),
//     ]);
//   }

//   // Approve a loan
//   void approveLoan(String loanId) {
//     final index = loanApplications.indexWhere((loan) => loan.id == loanId);
//     if (index != -1) {
//       loanApplications[index].status = 'approved';
//       loanApplications.refresh();
//       loadMockData();
//     }
//   }

//   // Reject a loan
//   void rejectLoan(String loanId) {
//     final index = loanApplications.indexWhere((loan) => loan.id == loanId);
//     if (index != -1) {
//       loanApplications[index].status = 'rejected';
//       loanApplications.refresh();
//       loadMockData();
//     }
//   }
// }
