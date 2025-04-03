import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../utils/constants/app_constants.dart';

class FresherCategoryController extends GetxController {
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();

    update([kFresherCategory]);
    // calling get bis helpdesk calls list method
  }
}
