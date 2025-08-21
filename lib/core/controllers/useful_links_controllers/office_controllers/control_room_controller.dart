// Created By Amit Jangid 10/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/control_room.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class ControlRoomController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool isLoading = true;

  List<ControlRoom> _controlRoomList = [];
  List<ControlRoom> filteredControlRoomList = [];

  late AnimationController animationController;
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    // calling get control room list method
    getControlRoomList();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: kControlRoomScreen);
  }

  getControlRoomList() async {
    isLoading = true;
    update([kControlRoom]);

    // calling get control room list from db method
    _controlRoomList = await ControlRoomDb.getControlRoomsListFromDb();
    filteredControlRoomList = _controlRoomList;

    isLoading = false;
    update([kControlRoom]);
  }

  onControlRoomSearch(String _searchQuery) async {
    if (_searchQuery.isNotEmpty) {
      final List<ControlRoom> _tempControlRoomList = [];

      for (final ControlRoom _controlRoom in _controlRoomList) {
        if (_controlRoom.location!
            .toLowerCase()
            .contains(_searchQuery.toLowerCase())) {
          _tempControlRoomList.add(_controlRoom);
        }
      }

      filteredControlRoomList = _tempControlRoomList;
      update([kControlRoom]);
    } else {
      filteredControlRoomList = _controlRoomList;
      update([kControlRoom]);
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    animationController.dispose();

    super.dispose();
  }
}
