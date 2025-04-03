// Created By Amit Jangid on 24/11/21

import 'dart:convert';
import 'dart:io';
import 'dart:math';
// import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gail_connect/models/address_details_model.dart';
import 'package:gail_connect/models/contact_details.dart';
import 'package:gail_connect/models/delivery_mode.dart';
import 'package:gail_connect/models/dependant_list.dart';
import 'package:gail_connect/models/pharmacy_list.dart';
import 'package:gail_connect/ui/widgets/acknowledge_dialog.dart';
import 'package:get/get.dart';
import 'package:gail_connect/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gail_connect/models/areas.dart';
import 'package:gail_connect/models/types.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:gail_connect/ui/widgets/show_custom_dialog_box.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../ui/screens/useful_links_screens/dispensary_screens/dispensary_dash_screen.dart';
import '../../../ui/widgets/custom_dialogs/custom_dialog_choose_file.dart';
import '../../../ui/widgets/custom_dialogs/show_custom_confirmation_dialog_box.dart';

class DispensaryController extends GetxController {
  static const String _tag = 'DispensaryController';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController descController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  double fileSize = 0;
  final GailConnectServices _gailConnectServices = GailConnectServices.to;

  var str;
  Areas? selectedArea;
  XFile? capturedImage;
  Types? selectedTypes;
  List<File> files = [];
  List<File> filePlace = [];
  File? file;
  String? selectedDependent,
      selectedMedicalStore,
      selectedDeliveryMode,
      selectAddressDetails;

  PickedFile? pickedFile;

  List<File> capturedImageList = [];

  List<ContactDetailsModel> mobileNo = [];
  String? mobileno, address;

  List<DependantListModel> dependantList = [];
  List<String> dependantlist = [];
  List<DeliveryMode> deliveryMode = [];
  List<String> deliverymode = [];
  String? delivery;
  List<PharmacyList> medicalStoreList = [];
  List<String> medicalstorelist = [];
  String? medicalstore;
  List<Types> typesList = [];
  List<PlatformFile> selectedFilesList = [];
  List<AddressDetailsModel> addressList = [];
  List<String> addresslist = [];
  bool isReady = true;

  @override
  void onReady() {
    super.onReady();
    // final SharedPrefs _sharedPrefs = SharedPrefs.to;
    // calling hit count api method
    print("DispensaryController onReady $selectedDependent");

    _gailConnectServices.hitCountApi(
        activity: "Cashless Medicine", activityScreen: "/dispensaryDash");

    // calling get areas  list method

    getDetails();
    isReady = true;
    // getMedicalStoreList();
  }

  @override
  void onInit() {
    print("DispensaryController onInit $selectedDependent");
    update([kDispensary]);

    pincodeController.addListener(() {
      if (pincodeController.text.length.toString() == "6") {
        validatePinCode(pincodeController.text.toString());

        update([kDispensary]);
      }
    });
    super.onInit();
  }

  void clearData() {
    cityController.clear();
    // mobileController.clear();
    pincodeController.clear();
    stateController.clear();
    addressController.clear();
  }

  // getCallApollo() async {
  //   // print(no);
  //   await launch("tel: +914047476988");
  // }
  launchDialer(String number) async {
    final String url = 'tel:$number';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Application unable to open dialer.';
    }
  }

  clearTypesSelection() {
    typesList = [];
    selectedTypes = null;
    // selectedDependent = null;
    // selectedArea = null;
    // selectedDeliveryMode = null;
    // selectedMedicalStore = null;
  }

  void validatePinCode(String pincode) async {
    await showProgressDialog(Get.context!, message: "Verifying Pincode");
    final String? status =
        await _gailConnectServices.getPinCodeVerifyApi(pincode: pincode);

    await hideProgressDialog();

    update([kDispensary]);
    if (status == kMsgNetworkIssue) {
      showCustomDialogBox(
          context: Get.context!,
          title: kWarning,
          description: "Unable to connect to network, Kindly try again !");
      // await hideProgressDialog();
    }

    str = status!.split(",");

    cityController.text = str[0].toString();
    stateController.text = str[3].toString();

    if (str[1] == "false") {
      pincodeController.clear();
      showCustomDialogBox(
          context: Get.context!,
          title: kWarning,
          description: "We are not available at this pincode");
    }
    // await hideProgressDialog();
    update([kDispensary]);
    // getAcknowledgeData();
    // update([kDispensary]);
  }

  getDetails() async {
    // calling show progress dialog method

    dependantlist.clear();
    await showProgressDialog(Get.context!, message: kMsgGettingData);

    // calling get all areas list api method
    dependantList = await _gailConnectServices.getAllDependantListApi();
    for (int i = 0; i < dependantList.length; i++) {
      dependantlist.add(dependantList[i].name.toString());
    }
    hideProgressDialog();
    addressList = await _gailConnectServices.getAllAddressDetails();

    if (addressList.isEmpty || addressList == "") {
      hideProgressDialog();
    } else {
      hideProgressDialog();
      addressController.text = addressList[0].addressDetails.toString() == "" ||
              addressList[0].addressDetails.toString() == null
          ? ""
          : addressList[0].addressDetails.toString();
      pincodeController.text = addressList[0].pin.toString() == "" ||
              addressList[0].pin.toString() == null
          ? ""
          : addressList[0].pin.toString();
    }

    for (int i = 0; i < addressList.length; i++) {
      addresslist.add(addressList[i].addressDetails.toString());
    }

    medicalStoreList = await _gailConnectServices.getAllMedicalStoreListApi();
    for (int i = 0; i < medicalStoreList.length; i++) {
      medicalstorelist.add(medicalStoreList[i].pharmacyName.toString());
      // +
      //     "\n" +
      //     medicalStoreList[i].address.toString());
    }
    if (medicalStoreList.length == 1) {
      medicalstore = medicalstorelist[0];
    }
    selectedMedicalStore = medicalstore;

    deliveryMode = await _gailConnectServices.getDeliveryModeApi();
    for (int i = 0; i < deliveryMode.length; i++) {
      deliverymode.add(deliveryMode[i].deliveryMode.toString());
      // +
      //     "\n" +
      //     medicalStoreList[i].address.toString());
    }
    if (deliveryMode.length == 1) {
      delivery = deliverymode[0];
    }

    selectedDeliveryMode = delivery;

    mobileNo = await _gailConnectServices.getContactDetailsApi();
    await hideProgressDialog();
    mobileno = mobileNo[0].mobileNo.toString();
    address = mobileNo[0].address.toString();

    mobileController.text = mobileno!;

    // calling hide progress dialog method
    await hideProgressDialog();

    // calling clear types selection method
    clearTypesSelection();
    update([kDispensary]);
    // getAcknowledgeData();
    // update([kDispensary]);
  }

  // static _toRadians(double degree) => degree * pi / 180;

  // _checkLocationServices() async {
  //   // calling service enabled method
  //   final bool _isServiceEnabled = await Location.instance.serviceEnabled();

  //   if (!_isServiceEnabled) {
  //     await showConfirmationDialog(
  //       Get.context!,
  //       title: kLocationService,
  //       description: kMsgEnableLocationService,
  //       onNegativePressed: () async {
  //         Get.back();

  //         // calling get hospitals from server method;
  //         await getHospitalsList();
  //       },
  //       onPositivePressed: () async {
  //         Get.back();

  //         await Location().requestService().then((value) async {
  //           isLoading = true;
  //           selectedFilter = '- $kNearMe';
  //           update([kHospitals]);

  //           // calling get current location method
  //           await getCurrentLocation();

  //           // calling get hospitals from server method;
  //           await getHospitalsList();
  //         });
  //       },
  //     );
  //   } else {
  //     selectedFilter = '- $kNearMe';
  //     update([kHospitals]);

  //     // calling get current location method
  //     await getCurrentLocation();

  //     // calling get hospitals from server method;
  //     await getHospitalsList();
  //   }
  // }

  // _checkLocationPermission() async {
  //   // calling request permission method
  //   final PermissionStatus _permissionStatus = await Location.instance.requestPermission();

  //   if (_permissionStatus == PermissionStatus.denied || _permissionStatus == PermissionStatus.deniedForever) {
  //     // calling get hospitals list method
  //     getHospitalsList();
  //   } else if (_permissionStatus == PermissionStatus.granted || _permissionStatus == PermissionStatus.grantedLimited) {
  //     // calling check location services method
  //     await _checkLocationServices();
  //   }
  // }

  openDialog(String s) async {
    showConfirmationDialog(
      Get.context!,
      title: "Grant Permission",
      description: s,
      onPositivePressed: () async {
        openAppSettings();
        Navigator.pop(Get.context!, "");
      },
      onNegativePressed: () {
        Navigator.pop(Get.context!, "");
      },
    );
  }

  checkPermission() async {
    var cameraPer = await Permission.camera.status;

    if (cameraPer.isDenied || cameraPer.isPermanentlyDenied) {
      openDialog(
        "In order to access the Medicine, you first need to grant 'Camera' permission in app settings. Click YES to go to app settings.",
      );
    } else {
      captureImage();
    }
  }

  checkFilePermission() async {
    var cameraPer = await Permission.photos.status;
    var cameraStorage = await Permission.storage.status;
    print("permissioncheck ${cameraPer}");
    // var cameraPer1 = await Permission.videos.status;
    // || cameraPer1.isDenied || cameraPer1.isPermanentlyDenied
    if (cameraPer.isGranted || cameraStorage.isGranted) {
      showChooseFilesDialogBox(
        Get.context!,
        FAQ: 'Photos',
        userManual: 'Files',
        onPositivePressed: () {
          Navigator.pop(Get.context!);
          chooseFiles(
            Get.context!,
          );
          // Get.to(PdfViewer(
          //   pdfurl:
          //   'https://gailebank.gail.co.in/common_api_jai/pdf/E_File_FAQ.pdf',
          //   title: "FAQ",
          //   type: "pdf",
          // ));
        },
        onVideoPressed: () {
          Navigator.pop(Get.context!);
          choosePhotos(Get.context!);
          // Get.to(ENoteSheetVideoListScreen());
        },
      );
    } else {
      openDialog(
          "In order to access the Medicine, you first need to grant 'Photos/Storage' permission in app settings. Click YES to go to app settings.");
    }
  }

  updateCapturedImages(int index) {
    files.removeAt(index);
    filePlace.removeAt(index);
    update([kDispensary]);
  }

  updateSelectedFilesList(PlatformFile file) {
    selectedFilesList.remove(file);
    update([kDispensary]);
  }

  // double _distanceBetween(double startLatitude, double startLongitude,
  //     double endLatitude, double endLongitude) {
  //   const _earthRadius = 6378137.0;
  //   final _dLat = _toRadians(endLatitude - startLatitude);
  //   final _dLon = _toRadians(endLongitude - startLongitude);

  //   final _a = pow(sin(_dLat / 2), 2) +
  //       pow(sin(_dLon / 2), 2) *
  //           cos(_toRadians(startLatitude)) *
  //           cos(_toRadians(endLatitude));

  //   final _c = 2 * asin(sqrt(_a));

  //   return _earthRadius * _c;
  // }

  // getMedicalStoreList() async {
  //   // calling show progress dialog method
  //   await showProgressDialog(Get.context!, message: kMsgGettingData);

  //   // calling get all areas list api method
  //   medicalStoreList = await _gailConnectServices.getAllMedicalStoreListApi();
  //   for (int i = 0; i < medicalStoreList.length; i++) {
  //     medicalstorelist.add(medicalStoreList[i].pharmacyName.toString());
  //     // "\n" +
  //     // medicalStoreList[i].address.toString()
  //   }

  //   // calling hide progress dialog method
  //   await hideProgressDialog();

  //   // calling clear types selection method
  //   clearTypesSelection();
  //   update([kDispensary]);
  // }

  getTypesListByArea() async {
    // calling clear types selection method
    clearTypesSelection();

    if (selectedArea != null) {
      // calling show progress dialog method
      await showProgressDialog(Get.context!, message: kMsgGettingTypesForArea);

      // calling get types list by area api method
      typesList = await _gailConnectServices.getTypesListByAreaApi(
          area: selectedArea?.value);

      // calling hide progress dialog method
      await hideProgressDialog();

      update([kDispensary]);
    } else {
      typesList = [];
      selectedTypes = null;
    }
  }

  onStoreSelected({required String? store}) async {
    // selectedArea = area;
    selectedMedicalStore = store;

    // calling get types list by area method
    // getTypesListByArea();
  }

  onPharmacySelected({required String? deliverymode}) async {
    // selectedArea = area;
    selectedDeliveryMode = deliverymode;

    // calling get types list by area method
    // getTypesListByArea();
  }

  onDeliveryModeSelected({required String? deliverymode}) async {
    // selectedArea = area;
    selectedDeliveryMode = deliverymode;

    // calling get types list by area method
    // getTypesListByArea();
  }

  onDependantSelected({required String? dependant}) async {
    // selectedArea = area;
    selectedDependent = dependant;
    // calling get types list by area method
    // getTypesListByArea();
  }

  onAddressDetailsSelectd(
      {required AddressDetailsModel? addressdetails,
      required BuildContext context}) async {
    Navigator.pop(context);
    selectAddressDetails = addressdetails!.addressDetails.toString();
    addressController.text = selectAddressDetails.toString();
    pincodeController.text = addressdetails.pin.toString();
  }

  onTypesSelected(Types? _selectedTypes) => selectedTypes = _selectedTypes;
  // onTypesSelected(Types? _selectedArea) => selectedArea = _selectedArea;
  // onTypesSelected(Types? _selectedDeliveryMode) => selectedDeliveryMode = _selectedDeliveryMode;
  // onTypesSelected(Types? _selectedDependent) => selectedDependent = _selectedDependent;
  // onTypesSelected(Types? _selectedMedicalStore) => selectedMedicalStore = _selectedMedicalStore;

  captureImage() async {
    try {
      // var status = await Permission.camera.status;

      // if (status.isGranted) {
      final ImagePicker _imagePicker = ImagePicker();
      //
      // selectedFilesList = [];
      capturedImageList.clear();
      capturedImage = await _imagePicker.pickImage(
        imageQuality: 80,
        source: ImageSource.camera,
      );

      if (capturedImage != null) {
        final XFile x = XFile(capturedImage!.path.toString());
        final File newFile =
            await getCompressedBase64(XFile(capturedImage!.path.toString()));

        if (Platform.isIOS) {
          capturedImageList.add(newFile);
        }
        if (Platform.isAndroid) {
          capturedImageList.add(newFile);
        }
        for (int i = 0; i < capturedImageList.length; i++) {
          files.add(File(capturedImageList[i].path));
          filePlace.add(File(capturedImageList[i].toString()));
        }
      } else {}

      update([kDispensary]);
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while choosing files',
      );
      // final String stacktrace = s.toString();
      await _gailConnectServices.submitExceptionApi(
        issue: e.toString(),
        trace: s.toString(),
        screen: "dispensary_add_call_controller",
      );
    }
  }

  Future<File> getCompressedBase64(XFile? photo) async {
    final File file = File(photo!.path);

    final double fileSizeInKiloByte = file.lengthSync() / 1000;
    if (fileSizeInKiloByte > 500) {
      final double compress = (500 / fileSizeInKiloByte) * 100;
      final XFile? result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        "${file.path}com.jpg",
        minHeight: 640,
        minWidth: 1136,
        quality: (compress.toInt()),
      );
      final File comFile = File(result!.path);
      final double comLengthKB = comFile.lengthSync() / 1000;
      return File(result.path);
    } else {
      return file;
    }
  }

  chooseFiles(BuildContext context) async {
    try {
      final FilePickerResult? _result = await FilePicker.platform.pickFiles(
        // type: FileType.image,
        allowMultiple: true,
        // allowedExtensions: ['jpg', 'jpeg', 'pdf'],
      );
      if (_result != null) {
        capturedImage = null;
        selectedFilesList = _result.files;
        // selectedFilesList = _result.filePlace;
        // file = File(capturedImage!.path);
        update([kDispensary]);
      }
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while choosing files',
      );
    }
  }

  choosePhotos(BuildContext context) async {
    try {
      final FilePickerResult? _result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
        // allowedExtensions: ['jpg', 'jpeg', 'pdf'],
      );
      if (_result != null) {
        capturedImage = null;
        selectedFilesList = _result.files;
        // selectedFilesList = _result.filePlace;
        // file = File(capturedImage!.path);
        update([kDispensary]);
      }
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while choosing files',
      );
    }
  }

  resetUi() {
    addressController.clear();
    mobileController.clear();
    remarksController.clear();
    pincodeController.clear();
    cityController.clear();
    stateController.clear();
    clearTypesSelection();
    selectedFilesList.clear();
    selectedDependent = "";
    selectedMedicalStore = "";
    selectedFilesList = [];
    files = [];

    update([kDispensary]);
  }

  getFileSize(File file, int decimals) async {
    // var file = File(filepath);
    final int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    final i = (log(bytes) / log(1024)).floor();

    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  Future<int> addNewCall() async {
    int a = 0;
    try {
      if (selectedDependent == null) {
        // calling show custom dialog box method
        showCustomDialogBox(
            context: Get.context!,
            title: kWarning,
            description: kMsgSelectDependant);

        return 0;
      }

      if (selectedMedicalStore == null) {
        // calling show custom dialog box method
        showCustomDialogBox(
            context: Get.context!,
            title: kWarning,
            description: kMsgSelectMedicalStore);

        return 0;
      }

      if (selectedDeliveryMode == null) {
        // calling show custom dialog box method
        showCustomDialogBox(
            context: Get.context!,
            title: kWarning,
            description: kMsgSelectDeliveryMode);

        return 0;
      }
      int bytes = 0;
      int totalBytes = 0;

      // if (bytes <= 0) return "0 B";

      if (files.isNotEmpty && selectedFilesList.isNotEmpty) {
        for (int i = 0; i < files.length; i++) {
          getFileSize(files[i], 1);
          bytes = await files[i].length();
          totalBytes = totalBytes + bytes;
        }

        for (int i = 0; i < selectedFilesList.length; i++) {
          bytes = selectedFilesList[i].size;
          totalBytes = totalBytes + bytes;
        }

        fileSize = totalBytes / (1024 * 1024); //(pow(1024, s));
      } else if (files.isEmpty && selectedFilesList.isNotEmpty) {
        for (int i = 0; i < selectedFilesList.length; i++) {
          bytes = selectedFilesList[i].size;
          totalBytes = totalBytes + bytes;
        }
        fileSize = totalBytes / (1024 * 1024); //(pow(1024, s));
      } else if (files.isNotEmpty && selectedFilesList.isEmpty) {
        for (int i = 0; i < files.length; i++) {
          getFileSize(files[i], 1);
          bytes = await files[i].length();
          totalBytes = totalBytes + bytes;
        }

        fileSize = totalBytes / (1024 * 1024); //(pow(1024, s));
      } else if (files.isEmpty && selectedFilesList.isEmpty) {
        fileSize = 0;
      }

      if (fileSize > 10) {
        showCustomDialogBox(
            context: Get.context!,
            title: kWarning,
            description: "Attachment's size should not exceed more than 10 MB");
        return 0;
      }

      if (selectedFilesList.isNotEmpty) {
        for (int i = 0; i < selectedFilesList.length; i++) {
          if (selectedFilesList[i].toString().toLowerCase().contains(".heic")) {
            showCustomDialogBox(
                context: Get.context!,
                title: kWarning,
                description:
                    ".HEIC files can't be uploaded. Kindly select any other file.");
            return 0;
          }
        }
      }

      await showProgressDialog(Get.context!);

      // calling request call api method
      final _response = await _gailConnectServices.submitMedicalApi(
        address: addressController.value.text,
        dependant: selectedDependent!.toString(),
        medicalstore: selectedMedicalStore!.toString(),
        mobile: mobileController.value.text,
        // remarks: remarksController.value.text,
        remarks: remarksController.value.text,
        pincode: pincodeController.value.text,
        deliverymode: selectedDeliveryMode.toString(),
        city: str[0],
        stateCode: str[2],
        state: str[3],
        capturedImages: files,
        uploadedFilesList: selectedFilesList,
      );

      if (_response != null) {
        final _responseBytesToString = await _response.stream.bytesToString();
        print("request id $_response");

        if (_response.statusCode == 200) {
          print("request id ${_response.statusCode} ");
          final String _message =
              json.decode(_responseBytesToString)["Message"].toString();
          final String _reqID =
              json.decode(_responseBytesToString)["RequestId"].toString();
          print("request id $_reqID");
          if (json
              .decode(_responseBytesToString)["Message"]
              .toString()
              .contains('Request ID')) {

            await showCustomDialogBox(
                context: Get.context!, title: kInfo, description: _message);
            resetUi();
            await hideProgressDialog();
            a = 1;

            DispensaryDashScreen(
              isSearch: false,
            );

            Get.back();
            return a;
          } else {
            print("else*******");
            await showCustomDialogBox(
                context: Get.context!, title: kWarning, description: _message);
          }
        } else {
          print("_message :: $_response");
          final String _message =
              json.decode(_responseBytesToString)[kJsonMessage].toString();

          // calling show custom dialog method
        }
      }

      // calling hide progress dialog method
      await hideProgressDialog();
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: _tag,
        exceptionMsg: 'exception while adding new call and making api call',
      );
    }
    return a;
  }

  @override
  void dispose() {
    descController.dispose();
    addressController.dispose();
    mobileController.dispose();
    pincodeController.dispose();
    remarksController.dispose();
    cityController.dispose();
    stateController.dispose();

    super.dispose();
  }

  void getCallPlaceOrderApi(String reqID, String city) async {
    final _responseplaceOrder = await _gailConnectServices.submitPlaceOrderApi(
      address: addressController.value.text,
      dependant: selectedDependent!.toString(),
      medicalstore: selectedMedicalStore!.toString(),
      mobile: mobileController.value.text,
      remarks: remarksController.value.text,
      pincode: pincodeController.value.text,
      deliverymode: selectedDeliveryMode.toString(),
      reqID: reqID,
      city: city,
      capturedImages: files,
      uploadedFilesList: selectedFilesList,
    );
    final _responseBytesToString =
        await _responseplaceOrder!.stream.bytesToString();

    if (_responseplaceOrder.statusCode == 200) {
      final String _data =
          json.decode(_responseBytesToString)['Message'].toString();

      if (_responseBytesToString == null) {
        await showCustomDialogBox(
            context: Get.context!, title: kInfo, description: "_data");
      } else {
        final String status = json
            .decode(_responseBytesToString)["ordersResult"]["Status"]
            .toString();
        if (json
                .decode(_responseBytesToString)["ordersResult"]["Status"]
                .toString() ==
            "true") {
          getpharmacyRequestStatus(
              reqID,
              json
                  .decode(_responseBytesToString)["ordersResult"]["Status"]
                  .toString(),
              json
                  .decode(_responseBytesToString)["ordersResult"]["ApOrderNo"]
                  .toString());
        } else {}
      }
    } else {
      final String _message =
          json.decode(_responseBytesToString)[kJsonMessage].toString();

      // calling show custom dialog method
      showCustomDialogBox(
          context: Get.context!, title: kInfo, description: _message);
    }
  }

  void getpharmacyRequestStatus(
      String reqID, String status, String orderID) async {
    try {
      final request = http.Request(
          'GET',
          Uri.parse(
              'https://gailebank.gail.co.in/common_api/api/GARMINDailies/pharmacyRequestStatus?orderNo=$reqID&status=$status&apolloOrderNo=$orderID'));

      final http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
      } else {}
    } catch (e) {}
  }

  void getAcknowledgeData() async {
    String? response;
    response = await GailConnectServices.to.getAcknowledeResponse();
    if (response == "Acknowledged") {
    } else {
      showCustomDialogAcknowledge(Get.context!,
          title: kWarning,
          description:
              'Please acknowledge receipt of previously ordered medicines before creating new request.',
          onNegativePressed: () {}, onPositivePressed: () {
        Navigator.pop(Get.context!);
      });

      update();
    }
  }
}
