import 'package:gail_connect/core/controllers/useful_links_controllers/fresher_category_controller.dart';

import 'package:get/get.dart';

class FresherCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FresherCategoryController());
  }
}
