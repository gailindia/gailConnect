import 'package:gail_connect/core/controllers/dependent_list_controller.dart';
import 'package:get/get.dart';

class DependentListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DependentListController());
  }
}
