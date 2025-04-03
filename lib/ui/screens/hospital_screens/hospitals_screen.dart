// Created By Amit Jangid 31/08/21

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/hospital.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/no_records_found.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/initial_text_container.dart';
import 'package:gail_connect/core/controllers/hospitals_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../styles/color_controller.dart';
import '../../widgets/custom_dialogs/show_custom_confirmation_dialog_box.dart';

class HospitalsScreen extends StatefulWidget {
  const HospitalsScreen({Key? key}) : super(key: key);



  @override
  State<StatefulWidget> createState() => _HospitalsScreen();
}

class _HospitalsScreen extends State<HospitalsScreen> with WidgetsBindingObserver{


  HospitalsController hospitalsController = Get.put(HospitalsController());

  int count = 0;
  bool isOpen = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if(Platform.isAndroid) {
    //   print("didChangeAppLifecycleState :: $state  $count");

      if(state == AppLifecycleState.resumed){
        checkPermissionStatus();
        count++;
      }
      // MainDashController().requestPermission();
    // }

  }

  checkPermissionStatus() async {
    print("inside isAndroid");
    var statusNoti = await Permission.location.status;
    var statusActvity = await Permission.locationWhenInUse.status;
    print("statusNoti  :: $statusNoti");
    if(Platform.isIOS){
      hospitalsController.checkOnResumeIos();
    }else {
      if (statusNoti == PermissionStatus.granted ||
          statusActvity == PermissionStatus.granted) {
        if(count<0) {
          hospitalsController.checkLocationPermission();
        }
      } else {
        // Navigator.pop(Get.context!, "");
        if (!isOpen) {
          showConfirmationDialog(
            Get.context!,
            title: "Grant Permission",
            description:
            "In order to access the Location, you first need to grant 'Location' permission in app settings. Click YES to go to app settings.",
            onPositivePressed: () async {
              openAppSettings();
              Navigator.pop(Get.context!, "");
            }, onNegativePressed: () async {
            // await getHospitalsList();
            Navigator.pop(Get.context!, "");
          },
          );
          isOpen = true;
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();

  }



  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // hospitalsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return GetBuilder<HospitalsController>(
      id: kHospitals,
      init: hospitalsController,
      builder: (_hospitalsController) => Scaffold(
        backgroundColor: colorController.kBgPopupColor,
        appBar: CustomAppBar(
            title: '$kHospitals ${_hospitalsController.selectedFilter}',
            isHospitalScreen: true),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MaterialCard(
              borderRadius: 12,
              padding: const EdgeInsets.only(),
              margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autocorrect: false,
                      controller: _hospitalsController.searchHospitalController,
                      // calling on hospital search method
                      onChanged: _hospitalsController.onHospitalSearch,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: textStyle14Normal,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        prefixIcon: Icon(Feather.search),
                        hintText: kEnterHospitalNameOrLocation,
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 14, horizontal: 6),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.clear, color: Colors.black),
                    onPressed: () => _hospitalsController.clearHospitalSearch(),
                  ),
                ],
              ),
            ),
            if (_hospitalsController.isLoading) ...[
              // const Expanded(child: LoadingWidget()),
            ] else if (_hospitalsController.filteredHospitalsList.isEmpty) ...[
              const Expanded(child: NoRecordsFound()),
            ] else ...[
              verticalSpace12,
              Expanded(
                child: ListView.builder(
                  itemCount: _hospitalsController.filteredHospitalsList.length,
                  padding:
                  const EdgeInsets.only(left: 12, right: 12, bottom: 36),
                  itemBuilder: (context, _position) {
                    final Hospital _hospital =
                    _hospitalsController.filteredHospitalsList[_position];

                    final String _name = _hospital.hospitalName!.trim();

                    return MaterialCard(
                      borderRadius: 12,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 12, bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InitialTextContainer(text: _name),
                          horizontalSpace6,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(_name,
                                              style: textStyle15Bold.copyWith(
                                                  color: colorController
                                                      .kPrimaryDarkColor)),
                                          verticalSpace6,
                                          Text(_hospital.hospitalLoc!,
                                              style: textStyle14Normal),
                                          if (_hospital.distance != null && _hospitalsController.selectedFilter == '- Near Me') ...[
                                            Text('${_hospital.distance!} km',
                                                style: textStyle14Normal),
                                          ],
                                        ],
                                      ),
                                    ),
                                    horizontalSpace6,
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        if (_hospital.latitude != null &&
                                            _hospital.latitude!.isNotEmpty) ...[
                                          InkWell(
                                            // calling open map method
                                            onTap: () => _hospitalsController
                                                .openMap(hospital: _hospital),
                                            child: Icon(
                                              MaterialCommunityIcons
                                                  .google_maps,
                                              size: 28,
                                              color: colorController
                                                  .kPrimaryDarkColor,
                                            ),
                                          ),
                                          verticalSpace18,
                                        ],
                                        InkWell(
                                          // calling show address dialog method
                                          onTap: () => _hospitalsController
                                              .showAddressDialog(
                                            address: _hospital.hospitalAdd!,
                                            location: _hospital.hospitalName!,
                                          ),
                                          child: Icon(
                                            FontAwesome.address_card_o,
                                            size: 28,
                                            color: colorController
                                                .kPrimaryDarkColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              /*Expanded(
                child: StackedCardCarousel(
                  initialOffset: 0,
                  spaceBetweenItems: 106,
                  applyTextScaleFactor: false,
                  type: StackedCardCarouselType.fadeOutStack,
                  items: _hospitalsController.filteredHospitalsList.map(
                    (Hospital _hospital) {
                      final String _name = _hospital.hospitalName!.trim();

                      return SizedBox(
                        height: 116,
                        child: MaterialCard(
                          borderRadius: 12,
                          margin: const EdgeInsets.all(12),
                          padding: const EdgeInsets.only(top: 8, left: 8, right: 12, bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InitialTextContainer(text: _name),
                              horizontalSpace6,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(_name, style: textStyle15Bold.copyWith(color: kPrimaryDarkColor)),
                                              verticalSpace6,
                                              Text(_hospital.hospitalLoc!, style: textStyle14Normal),
                                              if (_hospital.distance != null) ...[
                                                Text('${_hospital.distance!} km', style: textStyle14Normal),
                                              ],
                                            ],
                                          ),
                                        ),
                                        horizontalSpace6,
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            if (_hospital.latitude != null && _hospital.latitude!.isNotEmpty) ...[
                                              InkWell(
                                                // calling open map method
                                                onTap: () => _hospitalsController.openMap(hospital: _hospital),
                                                child: const Icon(
                                                  MaterialCommunityIcons.google_maps,
                                                  size: 28,
                                                  color: kPrimaryDarkColor,
                                                ),
                                              ),
                                              verticalSpace18,
                                            ],
                                            InkWell(
                                              // calling show address dialog method
                                              onTap: () => _hospitalsController.showAddressDialog(
                                                address: _hospital.hospitalAdd!,
                                                location: _hospital.hospitalName!,
                                              ),
                                              child: const Icon(
                                                FontAwesome.address_card_o,
                                                size: 28,
                                                color: kPrimaryDarkColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),*/
              /*Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 48),
                  itemCount: _hospitalsController.filteredHospitalsList.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey[300]),
                  itemBuilder: (context, _position) {
                    final Hospital _hospital = _hospitalsController.filteredHospitalsList[_position];
                    final String _name = _hospital.hospitalName!;

                    return SizedBox(
                      height: 200,
                      child: MaterialCard(
                        borderRadius: 12,
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.only(top: 6, left: 12, right: 18, bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InitialTextContainer(text: _name, fontSize: 36),
                            horizontalSpace6,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(_name, style: textStyle18Bold.copyWith(color: kPrimaryDarkColor)),
                                      ),
                                      horizontalSpace6,
                                      InkWell(
                                        // calling open map method
                                        onTap: () => _hospitalsController.openMap(hospital: _hospital),
                                        child: const Icon(
                                          MaterialCommunityIcons.google_maps,
                                          size: 30,
                                          color: kPrimaryDarkColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  verticalSpace6,
                                  Text(_hospital.hospitalLoc!, style: textStyle14Normal),
                                ],
                              ),
                            ),
                            InkWell(
                              // calling show address dialog method
                              onTap: () => _hospitalsController.showAddressDialog(
                                context: context,
                                address: _hospital.hospitalAdd!,
                              ),
                              child: const Icon(
                                FontAwesome.address_card_o,
                                size: 30,
                                color: kPrimaryDarkColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),*/
            ],
          ],
        ),
      ),
    );
  }

}
