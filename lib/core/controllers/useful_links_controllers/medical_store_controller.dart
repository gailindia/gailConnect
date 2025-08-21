// // // Created By Amit Jangid on 25/11/21

// // import 'package:flutter/material.dart';
// // import 'package:gail_connect/config/routes.dart';
// // import 'package:gail_connect/models/bis_helpdesk_calls.dart';
// // import 'package:gail_connect/models/medical_store.dart';
// // import 'package:gail_connect/rest/gail_connect_services.dart';
// // import 'package:gail_connect/utils/constants/app_constants.dart';
// // import 'package:get/get.dart';

// // class MedicalStoreController extends GetxController {
// //   final TextEditingController searchController = TextEditingController();

// //   bool isLoading = true;
// //   String selectedCallStatus = kAll;

// //   MedicalStore? selectedUserCall;

// //   List<MedicalStore> _userCallsList = [];
// //   List<MedicalStore> filteredUserCallsList = [];

// //   @override
// //   void onInit() {
// //     super.onInit();

// //     // calling get bis helpdesk calls list method
// //     getMedicalStoreList();
// //   }

// //   @override
// //   void onReady() {
// //     super.onReady();

// //     // calling hit count api method
// //     GailConnectServices.to.hitCountApi(activity: kBISHelpdeskCallsScreen);
// //   }

// //   getMedicalStoreList() async {
// //     isLoading = true;
// //     update([kMedicalStoreDetails]);

// //     // calling get bis helpdesk calls list api method
// //     _userCallsList = await GailConnectServices.to.getMedicalStoreListApi();
// //     filteredUserCallsList = _userCallsList;

// //     isLoading = false;
// //     update([kBISHelpdeskCalls]);
// //   }

// //   onUserCallSelected({required MedicalStore userCall}) {
// //     selectedUserCall = userCall;
// //     update([kMedicalStoreDetails]);

// //     Get.toNamed(kDispensaryRoute);
// //   }

// //   onUserCallsSearch(String _searchQuery) {
// //     if (_searchQuery.isNotEmpty) {
// //       final List<MedicalStore> _tempUserCallsList = [];

// //       for (final MedicalStore _calls in _userCallsList) {
// //         if (_calls.callId!.toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
// //             _calls.desc!.toString().toLowerCase().contains(_searchQuery.toLowerCase())) {
// //           _tempUserCallsList.add(_calls);
// //         }
// //       }

// //       filteredUserCallsList = _tempUserCallsList;
// //       update([kBISHelpdeskCalls]);
// //     } else {
// //       filteredUserCallsList = _userCallsList;
// //       update([kBISHelpdeskCalls]);
// //     }
// //   }

// //   onUserCallStatusSelected(String? _selectedCallStatus) {
// //     selectedCallStatus = _selectedCallStatus!;
// //     update([kBISHelpdeskCalls]);

// //     if (_selectedCallStatus.toLowerCase() == kAll.toLowerCase()) {
// //       filteredUserCallsList = _userCallsList;
// //       update([kBISHelpdeskCalls]);
// //     } else {
// //       final List<BISHelpdeskCalls> _tempUserCallList = [];

// //       for (final BISHelpdeskCalls _userCall in _userCallsList) {
// //         if (_userCall.status!.toLowerCase() == _selectedCallStatus.toLowerCase()) {
// //           _tempUserCallList.add(_userCall);
// //         }
// //       }

// //       filteredUserCallsList = _tempUserCallList;
// //       update([kBISHelpdeskCalls]);
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     searchController.dispose();

// //     super.dispose();
// //   }
// // }

// //--------------------------------------===============================----------------------------

// // Created By Amit Jangid 06/09/21

// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:gail_connect/models/medical_store.dart';
// import 'package:get/get.dart';
// import 'package:location/location.dart';
// import 'package:gail_connect/models/city.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:gail_connect/models/hospital.dart';
// import 'package:multiutillib/utils/string_extension.dart';
// import 'package:gail_connect/rest/gail_connect_services.dart';
// import 'package:gail_connect/utils/constants/app_constants.dart';
// import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
// import 'package:gail_connect/ui/widgets/custom_dialogs/show_address_dialog_box.dart';
// import 'package:gail_connect/ui/widgets/custom_dialogs/show_custom_confirmation_dialog_box.dart';

// class MedicalStoreController extends GetxController {
//   bool isLoading = false;
//   String selectedFilter = '';

//   final TextEditingController searchCityController = TextEditingController();
//   final TextEditingController searchHospitalController =
//       TextEditingController();

//   LocationData? _userPosition;

//   List<City> _citiesList = [];
//   List<City> filteredCityList = [];

//   List<Hospital> _hospitalsList = [];
//   List<Hospital> filteredHospitalsList = [];

//   // List<MedicalStore> _userCallsList = [];

//   @override
//   void onInit() {
//     super.onInit();

//     // calling check location permission method
//     _checkLocationPermission();
//   }

//   @override
//   void onReady() {
//     super.onReady();

//     // calling hit count api method
//     GailConnectServices.to.hitCountApi(activity: kHospitalsScreen);
//   }

//   getMedicalStoreList() async {
//     isLoading = true;
//     update([kMedicalStoreDetails]);

//     // calling get bis helpdesk calls list api method
//     // _userCallsList = await GailConnectServices.to.getMedicalStoreListApi();
//     // filteredUserCallsList = _userCallsList;

//     isLoading = false;
//     update([kBISHelpdeskCalls]);
//   }

//   getHospitalsList() async {
//     isLoading = true;
//     update([kHospitals]);

//     // calling get cities list from db method
//     _citiesList = await CityDb.getCitiesListFromDb();

//     // calling get hospitals list from db method
//     _hospitalsList = await HospitalDb.getHospitalsListFromDb();

//     if (_userPosition != null) {
//       final double _userLat = _userPosition!.latitude!;
//       final double _userLng = _userPosition!.longitude!;

//       for (final Hospital _hospital in _hospitalsList) {
//         if (_hospital.latitude != null && _hospital.latitude!.isNotEmpty) {
//           final double _hospitalLat = _hospital.latitude!.toDouble!;
//           final double _hospitalLng = _hospital.longitude!.toDouble!;

//           // calling distance between method
//           final double _distance =
//               _distanceBetween(_userLat, _userLng, _hospitalLat, _hospitalLng);

//           _hospital.distance = (_distance / 1000).toStringAsFixed(2);
//         }
//       }

//       _hospitalsList.sort((Hospital _hospital1, Hospital _hospital2) =>
//           _hospital1.distance?.toDouble!
//               .compareTo(_hospital2.distance?.toDouble ?? 1000) ??
//           1);
//     }

//     filteredHospitalsList = _hospitalsList;
//     filteredCityList = _citiesList;
//     update([kSelectCity]);

//     isLoading = false;
//     update([kHospitals]);

//     // calling hide progress dialog method
//     await hideProgressDialog();
//   }

//   _checkLocationPermission() async {
//     // calling request permission method
//     final PermissionStatus _permissionStatus =
//         await Location.instance.requestPermission();

//     if (_permissionStatus == PermissionStatus.denied ||
//         _permissionStatus == PermissionStatus.deniedForever) {
//       // calling get hospitals list method
//       getHospitalsList();
//     } else if (_permissionStatus == PermissionStatus.granted ||
//         _permissionStatus == PermissionStatus.grantedLimited) {
//       // calling check location services method
//       await _checkLocationServices();
//     }
//   }

//   double _distanceBetween(double startLatitude, double startLongitude,
//       double endLatitude, double endLongitude) {
//     const _earthRadius = 6378137.0;
//     final _dLat = _toRadians(endLatitude - startLatitude);
//     final _dLon = _toRadians(endLongitude - startLongitude);

//     final _a = pow(sin(_dLat / 2), 2) +
//         pow(sin(_dLon / 2), 2) *
//             cos(_toRadians(startLatitude)) *
//             cos(_toRadians(endLatitude));

//     final _c = 2 * asin(sqrt(_a));

//     return _earthRadius * _c;
//   }

//   static _toRadians(double degree) => degree * pi / 180;

//   _checkLocationServices() async {
//     // calling service enabled method
//     final bool _isServiceEnabled = await Location.instance.serviceEnabled();

//     if (!_isServiceEnabled) {
//       await showConfirmationDialog(
//         Get.context!,
//         title: kLocationService,
//         description: kMsgEnableLocationService,
//         onNegativePressed: () async {
//           Get.back();

//           // calling get hospitals from server method;
//           await getHospitalsList();
//         },
//         onPositivePressed: () async {
//           Get.back();

//           await Location().requestService().then((value) async {
//             isLoading = true;
//             selectedFilter = '- $kNearMe';
//             update([kHospitals]);

//             // calling get current location method
//             await getCurrentLocation();

//             // calling get hospitals from server method;
//             await getHospitalsList();
//           });
//         },
//       );
//     } else {
//       selectedFilter = '- $kNearMe';
//       update([kHospitals]);

//       // calling get current location method
//       await getCurrentLocation();

//       // calling get hospitals from server method;
//       await getHospitalsList();
//     }
//   }

//   getCurrentLocation() async {
//     isLoading = true;
//     update([kHospitals]);

//     // calling show progress dialog method
//     await showProgressDialog(Get.context!, message: kMsgPleaseWaitFetchingData);

//     // calling get location method
//     _userPosition = await Location.instance.getLocation();
//   }

//   clearHospitalSearch() {
//     selectedFilter = '- $kNearMe';
//     searchHospitalController.clear();

//     // calling on hospital search method
//     onHospitalSearch('');
//   }

//   onHospitalSearch(String _searchQuery) {
//     final List<Hospital> _tempHospitalList = [];

//     if (_searchQuery.isNotEmpty) {
//       for (final Hospital _hospital in _hospitalsList) {
//         if (_hospital.hospitalName!
//                 .toLowerCase()
//                 .contains(_searchQuery.toLowerCase()) ||
//             _hospital.hospitalLoc!
//                 .toLowerCase()
//                 .contains(_searchQuery.toLowerCase())) {
//           _tempHospitalList.add(_hospital);
//         }
//       }

//       filteredHospitalsList = _tempHospitalList;
//       update([kHospitals]);
//     } else {
//       filteredHospitalsList = _hospitalsList;
//       update([kHospitals]);
//     }
//   }

//   clearCitySearch() {
//     searchHospitalController.clear();

//     // calling on city search method
//     onCitySearch('');
//   }

//   onCitySearch(String _searchQuery) {
//     final List<City> _tempCityList = [];

//     if (_searchQuery.isNotEmpty) {
//       for (final City _city in _citiesList) {
//         if (_city.cityName!
//             .toLowerCase()
//             .contains(_searchQuery.toLowerCase())) {
//           _tempCityList.add(_city);
//         }
//       }

//       filteredCityList = _tempCityList;
//       update([kSelectCity]);
//     } else {
//       filteredCityList = _citiesList;
//       update([kSelectCity]);
//     }
//   }

//   onCitySelected({required City selectedCity}) {
//     isLoading = true;
//     selectedFilter = '- ${selectedCity.cityName!}';
//     update([kHospitals]);

//     final List<Hospital> _tempHospitalList = [];

//     if (selectedCity.cityName!.toLowerCase() == kAll.toLowerCase()) {
//       _tempHospitalList.addAll(_hospitalsList);
//     } else if (selectedCity.cityName!.toLowerCase() == kNearMe.toLowerCase()) {
//       /*for (final Hospital _hospital in _hospitalsList) {
//         if (_hospital.distance != null && _hospital.distance!.replaceNullWithDouble < 15) {
//           _tempHospitalList.add(_hospital);
//         }
//       }*/

//       _tempHospitalList.addAll(_hospitalsList);
//     } else {
//       for (final Hospital _hospital in _hospitalsList) {
//         if (_hospital.hospitalLoc!.toLowerCase() ==
//             selectedCity.cityName!.toLowerCase()) {
//           _tempHospitalList.add(_hospital);
//         }
//       }
//     }

//     filteredHospitalsList = _tempHospitalList;
//     isLoading = false;
//     update([kHospitals]);

//     Get.back();
//   }

//   openMap({required Hospital hospital}) async {
//     late Uri _uri;
//     final String _query = '${hospital.latitude},${hospital.longitude}';

//     if (Platform.isAndroid) {
//       _uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': _query});
//     } else if (Platform.isIOS) {
//       final _latLng = {'ll': _query};
//       _uri = Uri.https('maps.apple.com', '/', _latLng);
//     }

//     await launch(_uri.toString());
//   }

//   showAddressDialog({required String location, required String address}) {
//     // calling show custom general dialog box method
//     showCustomGeneralDialogBox(
//         context: Get.context!, title: location, description: address);
//   }

//   @override
//   void dispose() {
//     searchCityController.dispose();
//     searchHospitalController.dispose();

//     super.dispose();
//   }
// }
