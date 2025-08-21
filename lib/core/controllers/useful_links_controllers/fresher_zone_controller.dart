// Created By Amit Jangid 14/09/21

import 'package:flutter/material.dart';
import 'package:gail_connect/models/fresher_zone_model.dart';
import 'package:gail_connect/utils/utils.dart';
import 'package:get/get.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:multiutillib/multiutillib.dart';

import '../../../ui/widgets/show_custom_dialog_box.dart';

class FresherZoneController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  TextEditingController searchTextController = TextEditingController();
  String _searchResult = '';
  List<FresherZoneModel> usersFiltered = [];

  bool isLoading = true;
  bool search = false;

  // List<Employee> _empList = [];
  List<FresherZoneModel> fresherzoneList = [];

  @override
  void onInit() {
    super.onInit();
    _checkConnectivity();
    usersFiltered.clear();
    fresherzoneList.clear();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    // calling get emp list method
    getFresherZoneList();
  }

  _checkConnectivity() async {
    if (!await checkConnectivity()) {
      // calling show custom dialog box method
      showCustomDialogBox(
          context: Get.context!,
          title: kInfo,
          description: kInternetNotAvailable);

      isLoading = false;
      update([kBannerDetails]);
    }
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(
    //     activity: kVehicleSearchScreen, activityScreen: "/vehicleSearch");
  }

  // getFresherZoneList() async {
  //   isLoading = true;
  //   // await showProgressDialog(Get.context!);
  //   // await showProgressDialog(Get.context!, message: kMsgGettingData);
  //   fresherzoneList = await GailConnectServices.to.getFresherZoneApi(type);
  //   fresherzoneList.sort((a, b) {
  //     return a.sno!.compareTo(b.sno!);
  //   });

  //   // calling get employees list from db method

  //   isLoading = false;
  //   // await hideProgressDialog();
  //   // update([kFresherZone]);
  //   update([kFresherGuidebook]);
  // }
  getFresherZoneList() async {
    isLoading = true;
    String type = Get.arguments[1];
    print("TYPE" + type);
    // await showProgressDialog(Get.context!);
    // await showProgressDialog(Get.context!, message: kMsgGettingData);
    fresherzoneList = await GailConnectServices.to.getFresherZoneApi(type);
    // fresherzoneList.sort((a, b) {
    //   return a.sno!.compareTo(b.sno!);
    // });

    // calling get employees list from db method

    isLoading = false;
    // await hideProgressDialog();
    // update([kFresherZone]);
    update([kFresherGuidebook]);
  }

  @override
  void dispose() {
    searchTextController.dispose();
    animationController.dispose();

    super.dispose();
  }

// e.isCaseInsensitiveContainsAny(query
//                   .toString())
  void searchFZ(String value) {
    _searchResult = value;
    usersFiltered = fresherzoneList
        .where((list) =>
            list.module!.toString().isCaseInsensitiveContainsAny(_searchResult)
            // .where((list) => list.module!.toString().contains(_searchResult)
            ||
            list.pathToAccess!.toString().contains(_searchResult))
        .toList();
    update([kFresherGuidebook]);
  }

  clearFZ() {
    // setState(() {
    searchTextController.clear();
    _searchResult = '';
    usersFiltered = fresherzoneList;
    update([kFresherGuidebook]);
    // });
  }
}
