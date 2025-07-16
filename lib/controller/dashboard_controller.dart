import 'package:get/get.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;
  List<String> tabTitles = ["Apply Loan", "Loan Status", "Repay Loan", "Profile"];

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
