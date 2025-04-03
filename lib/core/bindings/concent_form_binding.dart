
import 'package:gail_connect/core/controllers/concent_form_controller.dart';

import 'package:get/get.dart';

class ConcentFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ConcentFormController());
  }
}
