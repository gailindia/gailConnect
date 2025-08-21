// Created By Amit Jangid 17/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/fms_detail.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class FmsSearchController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  bool isLoading = false;
  List<FmsDetail> fmsDetailsList = [];

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kFMSSearchScreen);
  }

  getFmsDetailList() async {
    if (searchController.value.text.isNotEmpty) {
      isLoading = true;
      update([kFmsSearch]);

      // calling get fms detail by id api method
      fmsDetailsList = await GailConnectServices.to
          .getFmsDetailByIdApi(id: searchController.value.text);

      isLoading = false;
      update([kFmsSearch]);
    }
  }

  clearSearchText() {
    fmsDetailsList = [];
    searchController.clear();

    update([kFmsSearch]);
  }
}
