import 'package:gail_connect/core/controllers/useful_links_controllers/fresher_zone_controller.dart';
import 'package:get/get.dart';

class FresherZoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FresherZoneController());
  }
}
