// Created By Amit Jangid 06/09/21

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as location ;
import 'package:gail_connect/models/city.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gail_connect/models/hospital.dart';
import 'package:multiutillib/utils/string_extension.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:gail_connect/ui/widgets/custom_dialogs/show_address_dialog_box.dart';
import '../../ui/widgets/custom_dialogs/show_custom_confirmation_dialog_box.dart';
import '../../ui/widgets/custom_dialogs/show_message_wish_dialog.dart';

import '../../ui/styles/text_styles.dart';
import '../../utils/MapsLauncher.dart';

class HospitalsController extends GetxController {
  bool isLoading = false;
  String selectedFilter = '';

  final TextEditingController searchCityController = TextEditingController();
  final TextEditingController searchHospitalController =
  TextEditingController();

  location.LocationData? _userPosition;

  List<City> _citiesList = [];
  List<City> filteredCityList = [];

  List<Hospital> _hospitalsList = [];
  List<Hospital> filteredHospitalsList = [];

  @override
  void onInit() async{
    super.onInit();
    // if(Platform.isAndroid) {
    //   checkAppLocationPermission();
    // }if(Platform.isIOS){
      // calling check location permission method
      checkLocationPermission();
    // }
    // await getHospitalsList();
  }


  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    GailConnectServices.to
        .hitCountApi(activity: kHospitalsScreen, activityScreen: "/hospitals");
  }

  getHospitalsList() async {
    // final List<Hospital> _tempHospitalList = [];
    isLoading = true;
    update([kHospitals]);

    // calling get cities list from db method
    _citiesList = await GailConnectServices.to.getCitiesListApi();

    // calling get hospitals list from db method
    _hospitalsList = await GailConnectServices.to.getHospitalsListApi();

    print("_userPosition getHospitalsList ${_userPosition}");

    if (_userPosition != null) {
      final double _userLat = _userPosition!.latitude!;
      final double _userLng = _userPosition!.longitude!;

      for (final Hospital _hospital in _hospitalsList) {
        if (_hospital.latitude != null && _hospital.latitude!.isNotEmpty) {
          final double _hospitalLat = _hospital.latitude!.toDouble!;
          final double _hospitalLng = _hospital.longitude!.toDouble!;

          // calling distance between method
          final double _distance =
          _distanceBetween(_userLat, _userLng, _hospitalLat, _hospitalLng);

          _hospital.distance = (_distance / 1000).toStringAsFixed(2);
        }
      }

      _hospitalsList.sort((Hospital _hospital1, Hospital _hospital2) =>
      _hospital1.distance?.toDouble!
          .compareTo(_hospital2.distance?.toDouble ?? 1000) ??
          1);
    }

    filteredHospitalsList = _hospitalsList;
    filteredCityList = _citiesList;
    // _tempHospitalList.addAll(filteredHospitalsList);
    // print("_tempHospitalList :: ${_tempHospitalList.length}");
    update([kHospitals]);
    update([kSelectCity]);

    isLoading = false;


    // calling hide progress dialog method
    await hideProgressDialog();
  }

  checkLocationPermission() async {
    // calling request permission method
    location.PermissionStatus _permissionStatus =
    await location.Location.instance.requestPermission();

    var appPermission  = await Permission.location.status;
    print("_permissionStatus-----  :: $_permissionStatus");
    if (_permissionStatus == location.PermissionStatus.denied ||
        _permissionStatus == location.PermissionStatus.deniedForever ||
        appPermission == PermissionStatus.denied ||
        appPermission == PermissionStatus.permanentlyDenied) {
      // calling get hospitals list method
      await getHospitalsList();
    } else if (_permissionStatus == location.PermissionStatus.granted ||
        appPermission == PermissionStatus.granted) {
      ///TODO added on 129  _permissionStatus == location.PermissionStatus.grantedLimited ||
      // calling check location services method
      await checkLocationServices();
      // update([kHospitals]);
    }
  }

  checkOnResumeIos() async{
      var _isServiceEnabled = await location.Location.instance.hasPermission();
      print("_isServiceEnabled else if::  ${_isServiceEnabled.name}  ${PermissionStatus.denied}  ${location.PermissionStatus}" );
      if(_isServiceEnabled.name == 'denied' || _isServiceEnabled == "PermissionStatus.permanentlyDenied"){
        showConfirmationDialog(
          Get.context!,
          title: "Grant Permission",
          description:
          "In order to access the Location, you first need to grant 'Location' permission in app settings. Click YES to go to app settings.",
          // dividerColor: colorController.kPrimaryDarkColor,
          // positiveBtnStyle: buttonTextStyle,
          // positiveBtnColor: colorController.kPrimaryDarkColor,
          // negativeBtnColor: colorController.kPrimaryColor,
          onPositivePressed: () async {
            openAppSettings();
            Navigator.pop(Get.context!, "");
          }, onNegativePressed: () async{
          // await getHospitalsList();
          Navigator.pop(Get.context!, "");
        },
        );
      }else {
        selectedFilter = '- $kNearMe';

        print("selectedFilter ::  $selectedFilter");
        // calling get current location method
        await getCurrentLocation();

        // // calling get hospitals from server method;
        await getHospitalsList();
        update([kHospitals]);
      }
  }

  checkAppLocationPermission() async{
    var locationstatus = await Permission.location.status;
    location.PermissionStatus _permissionStatus =
    await location.Location.instance.hasPermission();
    print("locationstatus ::  $locationstatus  $_permissionStatus" );
    if(Platform.isAndroid) {
      if (locationstatus.isDenied || locationstatus.isPermanentlyDenied) {
        await showConfirmationDialog(
          Get.context!,
          title: "Grant Permission",
          description:
          "In order to access the Location, you first need to grant 'Location' permission in app settings. Click YES to go to app settings.",
          // dividerColor: colorController.kPrimaryDarkColor,
          // positiveBtnStyle: buttonTextStyle,
          // positiveBtnColor: colorController.kPrimaryDarkColor,
          // negativeBtnColor: colorController.kPrimaryColor,
          onPositivePressed: () async {
            openAppSettings();
            Navigator.pop(Get.context!, "");
          }, onNegativePressed: () async {
          selectedFilter = '';
          await getHospitalsList();
          Navigator.pop(Get.context!, "");
        },
        );
      } else {
        await checkLocationServices();
      }
    }else{
      await checkLocationServices();
    }
  }

  double _distanceBetween(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    const _earthRadius = 6378137.0;
    final _dLat = _toRadians(endLatitude - startLatitude);
    final _dLon = _toRadians(endLongitude - startLongitude);

    final _a = pow(sin(_dLat / 2), 2) +
        pow(sin(_dLon / 2), 2) *
            cos(_toRadians(startLatitude)) *
            cos(_toRadians(endLatitude));

    final _c = 2 * asin(sqrt(_a));

    return _earthRadius * _c;
  }

  static _toRadians(double degree) => degree * pi / 180;

  checkLocationServices() async {
    // calling service enabled method
    final bool _isServiceEnabled = await location.Location.instance.serviceEnabled();
    final bool _isAppServiceEnabled = await Permission.location.isGranted;
    print("_isServiceEnabled ::  $_isServiceEnabled" );
    if (!_isServiceEnabled) {
      print("_isServiceEnabled ::  $_isServiceEnabled" );
      await showConfirmationDialog(
        Get.context!,
        title: kLocationService,
        description: kMsgEnableLocationService,
        onNegativePressed: () async {
          Get.back();
          selectedFilter = '';
          // calling get hospitals from server method;
          await getHospitalsList();
        },
        onPositivePressed: () async {
          Get.back();
          await location.Location().requestService().then((value) async {
            isLoading = true;
            selectedFilter = '- $kNearMe';
            update([kHospitals]);
            if(Platform.isAndroid) {
              await checkAppLocationPermission();
              // calling get current location method
              await getCurrentLocation();
              // // calling get hospitals from server method;
              await getHospitalsList();
            }
          });
        },
      );
    } else if(!_isAppServiceEnabled){
      if(Platform.isIOS){
        var _isServiceEnabled = await location.Location.instance.hasPermission();
        print("_isServiceEnabled else if::  ${_isServiceEnabled}  ${PermissionStatus.denied}  ${location.PermissionStatus.denied}" );
        if(_isServiceEnabled == location.PermissionStatus.denied || _isServiceEnabled == location.PermissionStatus.deniedForever){
          showConfirmationDialog(
            Get.context!,
            title: "Grant Permission",
            description:
            "In order to access the Location, you first need to grant 'Location' permission in app settings. Click YES to go to app settings.",
            // dividerColor: colorController.kPrimaryDarkColor,
            // positiveBtnStyle: buttonTextStyle,
            // positiveBtnColor: colorController.kPrimaryDarkColor,
            // negativeBtnColor: colorController.kPrimaryColor,
            onPositivePressed: () async {
              openAppSettings();
              Navigator.pop(Get.context!, "");
            }, onNegativePressed: () async{
            selectedFilter = '';
            // await getHospitalsList();
            Navigator.pop(Get.context!, "");
          },
          );
        }else {
          selectedFilter = '- $kNearMe';
          await getCurrentLocation();
          // calling get hospitals from server method;
          await getHospitalsList();
          update([kHospitals]);
        }
      }else {
        await checkAppLocationPermission();
      }
    }
    else {
      print("_isServiceEnabled  else::  $_isServiceEnabled" );
      selectedFilter = '- $kNearMe';

      print("selectedFilter ::  $selectedFilter" );
      // calling get current location method
      await getCurrentLocation();

      // // calling get hospitals from server method;
      await getHospitalsList();
      update([kHospitals]);
    }
  }

  getCurrentLocation() async {
    isLoading = true;
    update([kHospitals]);

    // calling show progress dialog method
    await showProgressDialog(Get.context!, message: kMsgPleaseWaitFetchingData);

    // try{
      _userPosition = await location.Location.instance.getLocation();
      print("_userPosition :: $_userPosition");
    // }catch(ex){
    //
    // }
    // calling get location method


    isLoading = false;
    await hideProgressDialog();

  }

  clearHospitalSearch() {
    selectedFilter = '- $kNearMe';
    searchHospitalController.clear();

    // calling on hospital search method
    onHospitalSearch('');
  }

  onHospitalSearch(String _searchQuery) {
    final List<Hospital> _tempHospitalList = [];

    if (_searchQuery.isNotEmpty) {
      for (final Hospital _hospital in _hospitalsList) {
        if (_hospital.hospitalName!
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()) ||
            _hospital.hospitalLoc!
                .toLowerCase()
                .contains(_searchQuery.toLowerCase())) {
          _tempHospitalList.add(_hospital);
        }
      }

      filteredHospitalsList = _tempHospitalList;
      update([kHospitals]);
    } else {
      filteredHospitalsList = _hospitalsList;
      update([kHospitals]);
    }
  }

  clearCitySearch() {
    searchHospitalController.clear();

    // calling on city search method
    onCitySearch('');
  }

  onCitySearch(String _searchQuery) {
    final List<City> _tempCityList = [];

    if (_searchQuery.isNotEmpty) {
      for (final City _city in _citiesList) {
        if (_city.cityName!
            .toLowerCase()
            .contains(_searchQuery.toLowerCase())) {
          _tempCityList.add(_city);
        }
      }

      filteredCityList = _tempCityList;
      update([kSelectCity]);
    } else {
      filteredCityList = _citiesList;
      update([kSelectCity]);
    }
  }

  onCitySelected({required City selectedCity}) async {
    isLoading = true;

    update([kHospitals]);

    final List<Hospital> _tempHospitalList = [];


    if (selectedCity.cityName!.toLowerCase() == kAll.toLowerCase()) {
      selectedFilter = '- ${selectedCity.cityName!}';
      _tempHospitalList.addAll(_hospitalsList);
    } else if (selectedCity.cityName!.toLowerCase() == kNearMe.toLowerCase()) {
      print("selectedCity.cityName!.toLowerCase()");
      if(Platform.isIOS) {
        checkLocationServices();
      }else{
        await checkLocationServices();
      }
      /*for (final Hospital _hospital in _hospitalsList) {
        if (_hospital.distance != null && _hospital.distance!.replaceNullWithDouble < 15) {
          _tempHospitalList.add(_hospital);
        }
      }*/

      _tempHospitalList.addAll(_hospitalsList);
    } else {
      selectedFilter = '- ${selectedCity.cityName!}';
      for (final Hospital _hospital in _hospitalsList) {
        if (_hospital.hospitalLoc!.toLowerCase() ==
            selectedCity.cityName!.toLowerCase()) {
          _tempHospitalList.add(_hospital);
        }
      }
    }

    filteredHospitalsList = _tempHospitalList;
    isLoading = false;
    update([kHospitals]);

    Get.back();
  }




  void buildButtonSheet(BuildContext context,{required Hospital hospital}) async {
    final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView.builder(
            itemCount: availableMaps.length,
            itemBuilder: (BuildContext context, int index) {

              return InkWell(

                 onTap: () async{
                   await MapLauncher.showMarker(
                     mapType: availableMaps[index].mapType,
                     coords: Coords(hospital.latitude.toDouble??0.0, hospital.longitude.toDouble??0.0),
                     title: hospital.hospitalName??"",
                     description: hospital.hospitalAdd??"",
                   );
                   Navigator.pop(Get.context!);
                 },

                child: ListTile(
                    title: Text("${availableMaps[index].mapName}")),
              );
            });
      },
    );
  }

 

  openMap({required Hospital hospital}) async {
    late Uri _uri;
    final String _query = '${hospital.latitude},${hospital.longitude}';

    if (Platform.isAndroid) {
      _uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': _query});
      await launchUrl(Uri.parse( _uri.toString()));
    } else if (Platform.isIOS) {
      buildButtonSheet(Get.context!,hospital: hospital);
    }


  }

  showAddressDialog({required String location, required String address}) {
    // calling show custom general dialog box method
    showCustomGeneralDialogBox(
        context: Get.context!, title: location, description: address);
  }

  @override
  void dispose() {
    searchCityController.dispose();
    searchHospitalController.dispose();

    super.dispose();
  }
}
