import 'package:gail_connect/models/app_store_model.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AppStoreController extends GetxController {
  List<AppStoreModel> appStoreList = [];
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    // calling get guest house details method
    getAppStoreUrl();
  }

  void getAppStoreUrl() async {
    isLoading = true;
    // update([kGuestHouses]);

    // calling get guest houses list from db method
    appStoreList = await GailConnectServices.to.getAppStoreApiData();

    isLoading = false;
    update(['appStore']);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
