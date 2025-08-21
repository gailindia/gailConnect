// Created By Amit Jangid 09/09/21

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:multiutillib/multiutillib.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gail_connect/models/office.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/custom_dialogs/show_address_dialog_box.dart';

class OfficesController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool isLoading = true;

  List<Office> _officesList = [];
  List<Office> filteredOfficesList = [];

  late AnimationController animationController;
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    // calling get offices list method
    getOfficesList();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    GailConnectServices.to
        .hitCountApi(activity: kOfficesScreen, activityScreen: "/officeDash");
  }

  getOfficesList() async {
    isLoading = true;
    update([kOffices]);

    // calling get offices list method
    // _officesList = await OfficeDb.getOfficesListFromDb();
    _officesList = await GailConnectServices.to.getOfficesListApi();
    filteredOfficesList = _officesList;

    isLoading = false;
    update([kOffices]);
  }

  onOfficesSearch(String _searchQuery) async {
    if (_searchQuery.isNotEmpty) {
      final List<Office> _tempOfficesList = [];

      for (final Office _office in _officesList) {
        if (_office.location!
            .toLowerCase()
            .contains(_searchQuery.toLowerCase())) {
          _tempOfficesList.add(_office);
        }
      }

      filteredOfficesList = _tempOfficesList;
      update([kOffices]);
    } else {
      filteredOfficesList = _officesList;
      update([kOffices]);
    }
  }

  callNumber(String _number) async {
    final _callNo = 'tel:$_number';

    if (await canLaunch(_callNo)) {
      await launch(_callNo);
    }
  }

  // openMap({required Office office}) async {
  //   late Uri _uri;
  //   final String _query = '${office.latitude},${office.longitude}';
  //
  //   if (Platform.isAndroid) {
  //     _uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': _query});
  //   } else if (Platform.isIOS) {
  //     final _latLng = {'ll': _query};
  //     // _uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': _query});
  //     _uri = Uri.https('maps.apple.com', '/', _latLng);
  //   }
  //
  //   await launch(_uri.toString());
  // }

  void buildButtonSheet(BuildContext context, {required Office office}) async {
    final List<AvailableMap> availableMaps = await MapLauncher.installedMaps;
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListView.builder(
            itemCount: availableMaps.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () async {
                  await MapLauncher.showMarker(
                    mapType: availableMaps[index].mapType,
                    coords: Coords(office.latitude.toDouble ?? 0.0,
                        office.longitude.toDouble ?? 0.0),
                    title: office.location ?? "",
                    description: office.address ?? "",
                  );
                  Navigator.pop(Get.context!);
                },
                child: ListTile(title: Text("${availableMaps[index].mapName}")),
              );
            });
      },
    );
  }

  openMap({required Office office}) async {
    late Uri _uri;
    final String _query = '${office.latitude},${office.longitude}';

    print('LATITUDE LONGITUDE ::  ${office.latitude},${office.longitude}');
    if (Platform.isAndroid) {
      _uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': _query});
      await launchUrl(Uri.parse(_uri.toString()));
    } else if (Platform.isIOS) {
      buildButtonSheet(Get.context!, office: office);
    }
  }

  showAddressDialog({required String location, required String address}) {
    // calling show custom general dialog box method
    showCustomGeneralDialogBox(
        context: Get.context!, title: location, description: address);
  }

  @override
  void dispose() {
    searchController.dispose();
    animationController.dispose();

    super.dispose();
  }
}
