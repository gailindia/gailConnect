
import 'package:gail_connect/core/controllers/health_controller.dart';

import 'package:get/get.dart';

import '../controllers/emp_controllers/emp_attendance_controllers/emp_attendance_controller.dart';

class HealthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HealthController());
  }
}


class InoutBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(EmpAttendanceController());
    // TODO: implement dependencies
  }

}