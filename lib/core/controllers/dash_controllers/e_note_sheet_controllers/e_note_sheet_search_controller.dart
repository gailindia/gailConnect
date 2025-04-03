// Created By Amit Jangid 22/10/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/models/e_note_sheet_details.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class ENoteSheetSearchController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  bool isLoading = false;
  List<ENoteSheetDetails> eNoteSheetSearchList = [];

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kENoteSearchScreen);
  }

  getENoteSheetSearchList() async {
    if (searchController.value.text.isNotEmpty) {
      isLoading = true;
      update([kENoteSheetSearch]);

      // calling get fms detail by id api method
      eNoteSheetSearchList = await GailConnectServices.to
          .getENoteSheetSearchApi(text: searchController.value.text);

      isLoading = false;
      update([kENoteSheetSearch]);
    }
  }

  clearSearchText() {
    searchController.clear();
    eNoteSheetSearchList = [];

    update([kFmsSearch]);
  }
}
