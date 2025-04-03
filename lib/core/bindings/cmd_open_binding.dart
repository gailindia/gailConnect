import 'package:gail_connect/core/controllers/cmd_open_controller.dart';
import 'package:get/get.dart';

class CMDOpenHouseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CMDOpenHouseController());
  }
}
