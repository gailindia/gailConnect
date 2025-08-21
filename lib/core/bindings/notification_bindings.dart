import 'package:gail_connect/core/controllers/notification_controller.dart';
import 'package:get/get.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationController());
  }
}
