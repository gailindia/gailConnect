// Created By Amit Jangid 21/09/21

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/profile_settings_controller.dart';

import '../styles/color_controller.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kHomeBgColor,
      appBar:  CustomAppBar(title: kProfileSettings),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 48),
        child: GetBuilder<ProfileSettingsController>(
          id: kProfileSettings,
          init: ProfileSettingsController(),
          builder: (_profileSettingsController) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MaterialCard(
                borderRadius: 12,
                padding: const EdgeInsets.only(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace12,
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, left: 12, right: 12, bottom: 18),
                        child: Text(
                          kChooseDefaultContactList,
                          style: textStyle18Bold.copyWith(
                              color: colorController.kPrimaryDarkColor),
                        ),
                      ),
                    ),
                    Divider(height: 2, color: colorController.kPrimaryDarkColor),
                    // verticalDividerDark,
                    RadioListTile<String>(
                      value: kMyLocation,
                      contentPadding: const EdgeInsets.only(),
                      groupValue: _profileSettingsController.selectedSetting,
                      onChanged: _profileSettingsController.onSettingsChanged,
                      title:  Text(kMyLocation, style: textStyle16Normal),
                    ),
                    RadioListTile<String>(
                      value: kMyDepartment,
                      contentPadding: const EdgeInsets.only(),
                      groupValue: _profileSettingsController.selectedSetting,
                      onChanged: _profileSettingsController.onSettingsChanged,
                      title:
                           Text(kMyDepartment, style: textStyle16Normal),
                    ),
                    RadioListTile<String>(
                      value: kMyLocationAndDepartment,
                      contentPadding: const EdgeInsets.only(),
                      groupValue: _profileSettingsController.selectedSetting,
                      onChanged: _profileSettingsController.onSettingsChanged,
                      title:  Text(kMyLocationAndDepartment,
                          style: textStyle16Normal),
                    ),
                    RadioListTile<String>(
                      value: kAllDGMAndAbove,
                      contentPadding: const EdgeInsets.only(),
                      groupValue: _profileSettingsController.selectedSetting,
                      onChanged: _profileSettingsController.onSettingsChanged,
                      title:
                           Text(kAllDGMAndAbove, style: textStyle16Normal),
                    ),
                    RadioListTile<String>(
                      value: kAllGMAndAbove,
                      contentPadding: const EdgeInsets.only(),
                      groupValue: _profileSettingsController.selectedSetting,
                      onChanged: _profileSettingsController.onSettingsChanged,
                      title:
                           Text(kAllGMAndAbove, style: textStyle16Normal),
                    ),
                    RadioListTile<String>(
                      value: kAllEDAndAbove,
                      contentPadding: const EdgeInsets.only(),
                      groupValue: _profileSettingsController.selectedSetting,
                      onChanged: _profileSettingsController.onSettingsChanged,
                      title:
                           Text(kAllEDAndAbove, style: textStyle16Normal),
                    ),
                  ],
                ),
              ),
              MaterialCard(
                borderRadius: 12,
                padding: const EdgeInsets.only(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace12,
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, left: 12, right: 12, bottom: 18),
                        child: Text(kSortListBy,
                            style: textStyle18Bold.copyWith(
                                color: colorController.kPrimaryDarkColor)),
                      ),
                    ),

                    Divider(height: 2, color: colorController.kPrimaryDarkColor),
                    // verticalDividerDark,
                    RadioListTile<String>(
                      value: kAlphabetWiseSorting,
                      contentPadding: const EdgeInsets.only(),
                      groupValue: _profileSettingsController.selectedSorting,
                      onChanged: _profileSettingsController.onSortingChanged,
                      title:  Text(kAlphabetWiseSorting,
                          style: textStyle16Normal),
                    ),
                    RadioListTile<String>(
                      value: kGradeWiseSorting,
                      contentPadding: const EdgeInsets.only(),
                      groupValue: _profileSettingsController.selectedSorting,
                      onChanged: _profileSettingsController.onSortingChanged,
                      title:  Text(kGradeWiseSorting,
                          style: textStyle16Normal),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
