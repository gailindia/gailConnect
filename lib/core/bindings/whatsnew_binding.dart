import 'package:gail_connect/core/controllers/whatsnew_controllers.dart';
import 'package:get/get.dart';

class WhatsNewBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WhatsNewController());
  }
}
