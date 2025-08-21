// Created By Amit Jangid on 25/11/21

import 'package:flutter/material.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/models/bis_helpdesk_calls.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';

class BISHelpdeskCallsController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  bool isLoading = true;
  String selectedCallStatus = kAll;

  BISHelpdeskCalls? selectedUserCall;

  List<BISHelpdeskCalls> _userCallsList = [];
  List<BISHelpdeskCalls> filteredUserCallsList = [];

  @override
  void onInit() {
    super.onInit();

    // calling get bis helpdesk calls list method
    getBISHelpdeskCallsList();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kBISHelpdeskCallsScreen);
  }

  getBISHelpdeskCallsList() async {
    isLoading = true;
    update([kBISHelpdeskCalls]);

    // calling get bis helpdesk calls list api method
    _userCallsList = await GailConnectServices.to.getBISHelpdeskCallsListApi();
    filteredUserCallsList = _userCallsList;

    isLoading = false;
    update([kBISHelpdeskCalls]);
  }

  onUserCallSelected({required BISHelpdeskCalls userCall}) {
    selectedUserCall = userCall;
    update([kBISHelpdeskCalls]);

    Get.toNamed(kBISHelpdeskCallStatusDetailsRoute,
        arguments: selectedUserCall!.callId!);
  }

  onUserCallsSearch(String _searchQuery) {
    if (_searchQuery.isNotEmpty) {
      final List<BISHelpdeskCalls> _tempUserCallsList = [];

      for (final BISHelpdeskCalls _calls in _userCallsList) {
        if (_calls.callId!
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            _calls.desc!
                .toString()
                .toLowerCase()
                .contains(_searchQuery.toLowerCase())) {
          _tempUserCallsList.add(_calls);
        }
      }

      filteredUserCallsList = _tempUserCallsList;
      update([kBISHelpdeskCalls]);
    } else {
      filteredUserCallsList = _userCallsList;
      update([kBISHelpdeskCalls]);
    }
  }

  onUserCallStatusSelected(String? _selectedCallStatus) {
    selectedCallStatus = _selectedCallStatus!;
    update([kBISHelpdeskCalls]);

    if (_selectedCallStatus.toLowerCase() == kAll.toLowerCase()) {
      filteredUserCallsList = _userCallsList;
      update([kBISHelpdeskCalls]);
    } else {
      final List<BISHelpdeskCalls> _tempUserCallList = [];

      for (final BISHelpdeskCalls _userCall in _userCallsList) {
        if (_userCall.status!.toLowerCase() ==
            _selectedCallStatus.toLowerCase()) {
          _tempUserCallList.add(_userCall);
        }
      }

      filteredUserCallsList = _tempUserCallList;
      update([kBISHelpdeskCalls]);
    }
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }
}
