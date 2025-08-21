// Created By Amit Jangid 20/09/21

import 'package:get/get.dart';
import 'package:gail_connect/models/bws_bill_details.dart';
import 'package:gail_connect/models/bws_dash_details.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class BwsBillDetailsController extends GetxController {
  bool isLoading = true;
  late BwsDashDetails bwsDashDetails;

  List<BwsBillDetails> bwsBillDetailsList = [];

  @override
  void onInit() {
    super.onInit();

    bwsDashDetails = Get.arguments;

    // calling get bws bill details method
    getBwsBillDetails();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kBWSBillDetailsScreen);
  }

  getBwsBillDetails() async {
    isLoading = true;
    update([kBillDetailsSystem]);

    // calling get bws bill details api method
    bwsBillDetailsList = await GailConnectServices.to
        .getBwsBillDetailsApi(receiptNo: bwsDashDetails.receiptNo!);

    isLoading = false;
    update([kBillDetailsSystem]);
  }
}
