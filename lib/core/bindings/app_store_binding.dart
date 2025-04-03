import 'package:gail_connect/core/controllers/app_store_controller.dart';
import 'package:get/get.dart';

class AppStoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppStoreController());
  }
}
