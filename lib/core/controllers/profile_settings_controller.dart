// Created By Amit Jangid 21/09/21

import 'package:get/get.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

class ProfileSettingsController extends GetxController {
  String? selectedSetting, selectedSorting;

  @override
  void onInit() async {
    super.onInit();

    SecureSharedPref pref = await SecureSharedPref.getInstance();
    selectedSetting = await pref.getString("contactListBy")??kMyLocationAndDepartment;
    selectedSorting = await pref.getString("sortContactListBy")??kAlphabetWiseSorting;
    update([kProfileSettings]);
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    GailConnectServices.to.hitCountApi(
        activity: 'Profile Settings', activityScreen: "/profileSettings");
  }

  onSettingsChanged(String? _selectedSetting) async {
    selectedSetting = _selectedSetting;

    SecureSharedPref pref = await SecureSharedPref.getInstance();
    await pref.putString("contactListBy",_selectedSetting!);
    update([kProfileSettings]);
  }

  onSortingChanged(String? _selectedSorting)  async{
    selectedSorting = _selectedSorting;
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    await pref.putString("sortContactListBy",_selectedSorting!);

    update([kProfileSettings]);

  }
}
