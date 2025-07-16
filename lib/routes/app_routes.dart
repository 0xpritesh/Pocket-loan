import 'package:get/get.dart';
// import 'package:pocketloan/screens/admin/active_loan.dart';
// import 'package:pocketloan/screens/admin/loan_application.dart';
// import 'package:pocketloan/screens/admin/support_request.dart';
// import 'package:pocketloan/screens/admin/user_profile.dart';
import 'package:pocketloan/screens/auth/login_screen.dart';
import 'package:pocketloan/screens/auth/register_screen.dart';
// import 'package:pocketloan/screens/loan/apply_loan.dart';
import 'package:pocketloan/screens/loan/document_verification.dart';
import 'package:pocketloan/screens/loan/loan_details.dart';
import 'package:pocketloan/screens/loan/loan_status.dart';
import 'package:pocketloan/screens/loan/personal_info.dart';
import 'package:pocketloan/screens/loan/repay_loan.dart';
import 'package:pocketloan/screens/splash_screen.dart';
import 'package:pocketloan/screens/home_screen.dart';

class AppRoutes {
  static const String dashboardScreen = '/dashboard';
  static const String loanForm = '/loan-form';
  static const splash = '/splash';
  static const String success = '/success';
  static const String documentVerification = '/verify-documents';
  static const String loanOffer = '/loan-offer';
  static const String register = '/register';
  static const String login = '/login';
  static const String loanDetails = '/loan-details';
  static const String loanStatus = '/loan-status';
  static const String adminDashboard = '/admin-dashboard';
  static const String loanApplications = '/admin/loan-applications';
  static const String activeLoans = '/admin/active-loans';
  static const String userProfiles = '/admin/user-profiles';
  static const String supportRequests = '/admin/support-requests';
  static const String personalInfo = '/personal-info';
  static const String applyLoan = '/apply-loan';
    static const String personalInfoScreen = '/personal-info';
      static const String documentVerificationScreen = '/document-verification';
      



  static List<GetPage> routes = [
    GetPage(
      name: documentVerification,
      page: () =>  DocumentVerificationScreen(),
    ),

    GetPage(name: dashboardScreen, page: () => DashboardScreen()),
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: '/repay-loan', page: () => RepayLoanScreen()),
    GetPage(name: personalInfo, page: () => PersonalInfoScreen()),
    GetPage(name: register, page: () => RegisterScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: loanDetails, page: () => const LoanDetailsScreen()),
    GetPage(name: AppRoutes.loanStatus, page: () => LoanStatusScreen()),
    // GetPage(name: loanApplications, page: () => LoanApplicationsScreen()),
    // GetPage(name: activeLoans, page: () => ActiveLoansScreen()),
    // GetPage(name: userProfiles, page: () => UserProfilesScreen()),
    // GetPage(name: supportRequests, page: () => SupportRequestsScreen()),
  ];
}
 