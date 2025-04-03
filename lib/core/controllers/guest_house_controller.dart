// Created By Amit Jangid 03/09/21

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gail_connect/models/guest_house.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/custom_dialogs/show_address_dialog_box.dart';

class GuestHouseController extends GetxController {
  bool isLoading = true;

  List<GuestHouse> _guestHouseList = [];
  List<GuestHouse> filteredGuestHouseList = [];

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    // calling get guest house details method
    getGuestHouseDetails();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    GailConnectServices.to.hitCountApi(
        activity: kGuestHouseScreen, activityScreen: '/guestHouse');
  }

  getGuestHouseDetails() async {
    await GailConnectServices.to.getGuestHouseDetailsApi();
    isLoading = true;
    update([kGuestHouses]);

    // calling get guest houses list from db method
    _guestHouseList = await GuestHouseDb.getGuestHousesListFromDb();
    filteredGuestHouseList = _guestHouseList;
    filteredGuestHouseList.sort((a, b) => a.location!.compareTo(b.location!));

    isLoading = false;
    update([kGuestHouses]);
  }

  // openMap({required GuestHouse guestHouse}) async {
  //   late Uri _uri;
  //   final String _query = '${guestHouse.latitude},${guestHouse.longitude}';
  //
  //   if (Platform.isAndroid) {
  //     _uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': _query});
  //   } else if (Platform.isIOS) {
  //     final _latLng = {'ll': _query};
  //     _uri = Uri.https('maps.apple.com', '/', _latLng);
  //   }
  //   print('${guestHouse.latitude},${guestHouse.longitude}');
  //   print(_uri.toString());
  //
  //   await launch(_uri.toString());
  // }

  void buildButtonSheet(BuildContext context,{required GuestHouse guestHouse}) async {
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
                    coords: Coords(guestHouse.latitude??0.0, guestHouse.longitude??0.0),
                    title: guestHouse.location??"",
                    description: guestHouse.address??"",
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



  openMap({required GuestHouse guestHouse}) async {
    late Uri _uri;
    final String _query = '${guestHouse.latitude},${guestHouse.longitude}';

    if (Platform.isAndroid) {
      _uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': _query});
      await launchUrl(Uri.parse( _uri.toString()));
    } else if (Platform.isIOS) {
      buildButtonSheet(Get.context!,guestHouse: guestHouse);
    }


  }

  onGuestHouseSearch(String _searchQuery) async {
    if (_searchQuery.isNotEmpty) {
      final List<GuestHouse> _tempGuestHouseList = [];

      for (final GuestHouse _guestHouse in _guestHouseList) {
        if (_guestHouse.location!
            .toLowerCase()
            .contains(_searchQuery.toLowerCase())) {
          _tempGuestHouseList.add(_guestHouse);
        }
      }

      filteredGuestHouseList = _tempGuestHouseList;
      update([kGuestHouses]);
    } else {
      filteredGuestHouseList = _guestHouseList;
      update([kGuestHouses]);
    }
  }

  showAddressDialog({required String location, required String address}) {
    // calling show custom general dialog box method
    showCustomGeneralDialogBox(
        context: Get.context!, title: location, description: address);
  }

  callNumber(String _number) async {
    final _callNo = 'tel:$_number';

    if (await canLaunch(_callNo)) {
      await launch(_callNo);
    }
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }
}
