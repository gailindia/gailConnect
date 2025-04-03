// Created By Amit Jangid on 17/12/21

// ignore_for_file: prefer_final_locals

import 'package:flutter/services.dart';
import 'package:gail_connect/ui/widgets/help_widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gail_connect/ui/widgets/acknowledge_dialog.dart';
import 'package:gail_connect/ui/widgets/elevated_button.dart';
import 'package:gail_connect/utils/utils.dart';
import 'package:get/get.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:multiutillib/utils/ui_helpers.dart';

import 'package:multiutillib/widgets/loading_widget.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:multiutillib/widgets/rich_text_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/routes.dart';
import '../../../../core/controllers/main_dash_controller.dart';
import '../../../../core/controllers/useful_links_controllers/dispensary_add_call_controller.dart';
import '../../../../core/controllers/useful_links_controllers/dispensary_controller.dart';
import '../../../../core/controllers/useful_links_controllers/dispensary_history_details_controller.dart';
import '../../../../main.dart';
import '../../../../models/address_details_model.dart';
import '../../../../models/dispensary_history.dart';
import '../../../../rest/gail_connect_services.dart';
import '../../../styles/color_controller.dart';
import '../../../styles/text_styles.dart';
import '../../../widgets/coloredSafeArea.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_dialogs/custom_dialog_choose_file.dart';
import '../../../widgets/fms_row_item.dart';
import '../../../widgets/no_records_found.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/primary_icon_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DispensaryDashScreen extends StatefulWidget {
  bool isSearch;

  DispensaryDashScreen({Key? key, required this.isSearch}) : super(key: key);

  @override
  State<DispensaryDashScreen> createState() => _DispensaryDashScreenState();
}

class _DispensaryDashScreenState extends State<DispensaryDashScreen> {
  // DispensaryDashController _dashController =
  //     Get.put(DispensaryDashController());
  DispensaryHistoryController _historyController =
      Get.put(DispensaryHistoryController());

  DispensaryController dispensaryController = Get.put(DispensaryController());
  dynamic argumentData = Get.arguments;

  int currentIndex = 0;
  int selindex = 0;
  bool? searchCashless;
  var one;
  ColorController colorController = Get.put(ColorController());

  List<Widget> bottomNavChildren = <Widget>[];
  Key dropDownKey = UniqueKey();

  void getSharedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    searchCashless = prefs.getBool('cashless');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init dash screen");

    dispensaryController.selectedDependent = 'Price';
    if (!dispensaryController.isReady) {
      dispensaryController.getDetails();
    }

    getSharedValue();
    bottomNavChildren.add(Dispensaryy(context));
    bottomNavChildren.add(DispensaryPendingg(context));
    bottomNavChildren.add(DispensaryHistoryy(context));
    getCheckConnectivity();
  }

  onBottomNavTapped(int _index) {
    Get.put(_historyController);
    _historyController.onInit();
    setState(() {
      currentIndex = _index;
    });
    if (_index < 1) {
      dispensaryController.getDetails();
      getAcknowledgeData();
    }
    if (_index == 2) {
      dispensaryController.isReady = false;
    }
    _historyController.update([kDispensaryDash]);
  }

  @override
  Widget build(BuildContext context) {
    return widget.isSearch
        ? GetBuilder<ColorController>(
            id: kDispensary,
            init: ColorController(),
            builder: (colorController) {
              return GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Scaffold(
                  backgroundColor: colorController.kBgPopupColor,
                  // backgroundColor: Colors.transparent,
                  appBar: widget.isSearch
                      ? CustomAppBar(
                          title: 'Cashless Medicine',
                        )
                      : null,
                  body: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 45.0),
                        child: bottomNavChildren[currentIndex],
                      ),
                      BottomNavigationBar(
                        landscapeLayout:
                            BottomNavigationBarLandscapeLayout.linear,
                        backgroundColor: Colors.transparent,
                        type: BottomNavigationBarType.fixed,
                        currentIndex: currentIndex,
                        showSelectedLabels: false,
                        showUnselectedLabels: false,
                        elevation: 0.0,
                        selectedItemColor: colorController.kSelectedColor,
                        unselectedItemColor: colorController.kUnselectedColor,
                        selectedLabelStyle: TextStyle(
                            fontSize: 0,
                            color: colorController.kSelectedColor,
                            fontWeight: FontWeight.bold),
                        unselectedLabelStyle: TextStyle(
                            fontSize: 0,
                            color: colorController.kUnselectedColor,
                            fontWeight: FontWeight.bold),
                        onTap: (index) {
                          onBottomNavTapped(index);
                        },
                        items: [
                          BottomNavigationBarItem(
                            icon: bottomButtonDesign(
                              0,
                              "Requisition",
                              "assets/icons/apps_icon.png",
                              "assets/icons/apps_icon.png",
                              colorController.kUnselectedColor,
                              colorController.kSelectedColor,
                              3,
                            ),
                            label: '',
                          ),
                          BottomNavigationBarItem(
                              icon: bottomButtonDesign(
                                1,
                                "In Process",
                                "assets/icons/employee_icon.png",
                                "assets/icons/employee_icon.png",
                                colorController.kUnselectedColor,
                                colorController.kSelectedColor,
                                3,
                              ),
                              label: ''),
                          BottomNavigationBarItem(
                              icon: bottomButtonDesign(
                                2,
                                "History",
                                "assets/icons/employee_icon.png",
                                "assets/icons/employee_icon.png",
                                colorController.kUnselectedColor,
                                colorController.kSelectedColor,
                                3,
                              ),
                              label: ''),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            })
        : GetBuilder<ColorController>(
            id: kDispensary,
            init: ColorController(),
            builder: (colorController) {
              return ColoredSafeArea(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: widget.isSearch
                        ? CustomAppBar(
                            title: 'Cashless Medicine',
                          )
                        : null,
                    body: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 45.0),
                          child: bottomNavChildren[currentIndex],
                        ),
                        BottomNavigationBar(
                          landscapeLayout:
                              BottomNavigationBarLandscapeLayout.linear,
                          backgroundColor: Colors.transparent,
                          type: BottomNavigationBarType.fixed,
                          currentIndex: currentIndex,
                          showSelectedLabels: false,
                          showUnselectedLabels: false,
                          elevation: 0.0,
                          selectedItemColor: colorController.kSelectedColor,
                          unselectedItemColor: colorController.kUnselectedColor,
                          selectedLabelStyle: TextStyle(
                              fontSize: 0,
                              color: colorController.kSelectedColor,
                              fontWeight: FontWeight.bold),
                          unselectedLabelStyle: TextStyle(
                              fontSize: 0,
                              color: colorController.kUnselectedColor,
                              fontWeight: FontWeight.bold),
                          onTap: (index) {
                            onBottomNavTapped(index);
                          },
                          items: [
                            BottomNavigationBarItem(
                              icon: bottomButtonDesign(
                                0,
                                "Requisition",
                                "assets/icons/apps_icon.png",
                                "assets/icons/apps_icon.png",
                                colorController.kUnselectedColor,
                                colorController.kSelectedColor,
                                3,
                              ),
                              label: '',
                            ),
                            BottomNavigationBarItem(
                                icon: bottomButtonDesign(
                                  1,
                                  "In Process",
                                  "assets/icons/employee_icon.png",
                                  "assets/icons/employee_icon.png",
                                  colorController.kUnselectedColor,
                                  colorController.kSelectedColor,
                                  3,
                                ),
                                label: ''),
                            BottomNavigationBarItem(
                                icon: bottomButtonDesign(
                                  2,
                                  "History",
                                  "assets/icons/employee_icon.png",
                                  "assets/icons/employee_icon.png",
                                  colorController.kUnselectedColor,
                                  colorController.kSelectedColor,
                                  3,
                                ),
                                label: ''),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
  }

  calculatePopupHeight(List<String> dependantlist) {
    int itemCount = dependantlist.length;
    double itemHeight = 50.0; // Assume each item has a height of 50
    double maxHeight = 200.0; // Set a maximum height for the dropdown

    // Calculate dynamic height based on item count
    double totalHeight = itemCount * itemHeight;
    return totalHeight > maxHeight ? maxHeight : totalHeight;
  }

  Widget Dispensaryy(var context) {
    final GailConnectServices _gailConnectServices = GailConnectServices.to;
    DispensaryController _dispensaryController =
        Get.put(DispensaryController());
    ColorController colorController = Get.put(ColorController());

    try {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Colors.transparent,

          // appBar: CustomAppBar(title: kDispensary),
          body: GetBuilder<DispensaryController>(
            id: kDispensary,
            init: dispensaryController,
            builder: (dispensaryController) {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(
                    top: 12, left: 12, right: 12, bottom: 48),
                child: Form(
                  key: dispensaryController.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(top: 9),
                              child: Text('$kUser:', style: textStyle18Bold)),
                          horizontalSpace6,
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.only(top: 9),
                            child: Text(
                                MainDashController
                                            .to.loggedInEmployee!.empName! ==
                                        null
                                    ? ""
                                    : MainDashController
                                        .to.loggedInEmployee!.empName!,
                                style: textStyle18Bold),
                          )),
                          HelpButton(
                              elevation: 0,
                              btnColor: Colors.transparent,
                              onPressed: () async {
                                dispensaryController
                                    .launchDialer("+914047476988");
                              },
                              text: "Help"),
                        ],
                      ),
                      verticalSpace12,
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: DropdownSearch<String>(
                              key: dropDownKey,
                              items: dispensaryController.dependantlist,
                              // label: kSelectDependant,

                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: kSelectDependant,
                                  hintText: kSelectDependant,
                                ),
                              ),
                              // dropdownSearchBaseStyle: textStyle13Normal,
                              // calling on area selected method
                              onChanged: (String? _dependant) =>
                                  dispensaryController.onDependantSelected(
                                      dependant: _dependant),
                              popupProps: PopupProps.menu(
                                constraints: BoxConstraints(
                                  maxHeight: calculatePopupHeight(
                                      dispensaryController
                                          .dependantlist), // Set the dynamic height
                                ),
                                itemBuilder: (BuildContext context, String item,
                                    bool isSelected) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 12),
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: isSelected
                                            ? Colors.blue
                                            : Colors.black,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              // emptyBuilder: (context, _searchString) =>
                              //     const Scaffold(body: NoRecordsFound()),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace18,
                      Row(
                        children: [
                          // const Expanded(
                          //     child: Text(kPharmacy, style: textStyle14Bold)),
                          // horizontalSpace6,
                          Expanded(
                            flex: 3,
                            child: DropdownSearch<String>(
                              enabled:
                                  dispensaryController.medicalstorelist.length >
                                          1
                                      ? true
                                      : false,

                              // mode: Mode.BOTTOM_SHEET,
                              // showAsSuffixIcons: true,
                              items: dispensaryController.medicalstorelist,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: kSelectPharmacy,
                                  hintText: kSelectPharmacy,
                                ),
                              ),
                              // label: kSelectPharmacy,
                              // dropdownSearchBaseStyle: textStyle13Normal,
                              selectedItem: dispensaryController.medicalstore,
                              onChanged: (String? _medicalStore) =>
                                  dispensaryController.onStoreSelected(
                                      store: _medicalStore),
                              // emptyBuilder: (context, _searchString) =>
                              //     const Scaffold(body: NoRecordsFound()),
                            ),
                          ),
                          horizontalSpace12,
                          Expanded(
                            flex: 3,
                            child: DropdownSearch<String>(
                              enabled:
                                  dispensaryController.deliverymode.length > 1
                                      ? true
                                      : false,
                              // mode: Mode.BOTTOM_SHEET,
                              // showAsSuffixIcons: true,
                              items: dispensaryController.deliverymode,
                              // label: kModeOfDelivery,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: kModeOfDelivery,
                                  hintText: kModeOfDelivery,
                                ),
                              ),
                              selectedItem: dispensaryController.delivery,
                              // calling on area selected method
                              onChanged: (String? _deliveryMode) =>
                                  dispensaryController.onDeliveryModeSelected(
                                      deliverymode: _deliveryMode),
                              // emptyBuilder: (context, _searchString) =>
                              //     const Scaffold(body: NoRecordsFound()),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace18,
                      verticalSpace18,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 13,
                            child: TextFormField(
                              minLines: 3,
                              maxLines: 5,
                              maxLength: 500,
                              autocorrect: false,
                              keyboardType: TextInputType.multiline,
                              controller:
                                  dispensaryController.addressController,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (_desc) => _desc!.isEmpty
                                  ? kMsgDescriptionIsRequired
                                  : null,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'[!@#$%^*()?"{}|<>]_'))
                              ],
                              decoration: const InputDecoration(
                                  labelText: kDeliveryAddress,
                                  contentPadding: EdgeInsets.all(12)),
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      searchAddress(
                                          dispensaryController, context);
                                    },
                                    child: const Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    )),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                      padding: const EdgeInsets.only(top: 30.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            dispensaryController.clearData();
                                          },
                                          child: const Icon(
                                            Icons.cancel,
                                            color: Colors.redAccent,
                                          ))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalSpace18,
                      Row(
                        children: [
                          // const Expanded(
                          //     child: Text(kMobile, style: textStyle14Bold)),
                          // horizontalSpace6,
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              minLines: 1,
                              maxLength: 10,
                              autocorrect: false,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: dispensaryController.mobileController,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (_desc) => _desc!.length != 10
                                  ? kMsgMobileIsRequired
                                  : null,
                              // initialValue: "hello",
                              decoration: const InputDecoration(
                                  labelText: kMobile,
                                  contentPadding: EdgeInsets.all(12)),
                            ),
                          ),
                          horizontalSpace12,
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              autofocus: false,
                              // initialValue:
                              minLines: 1,
                              maxLength: 6,
                              onChanged: (value) {},
                              autocorrect: false,
                              keyboardType: TextInputType.number,
                              controller:
                                  dispensaryController.pincodeController,
                              //TextEditingController(text: 'Initial value'),//
                              textCapitalization: TextCapitalization.sentences,
                              validator: (_desc) => _desc!.length != 6
                                  ? kMsgPincodeIsRequired
                                  : null,
                              decoration: const InputDecoration(
                                  labelText: kPincode,
                                  contentPadding: EdgeInsets.all(12)),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace18,
                      Row(
                        children: [
                          // const Expanded(
                          //     child: Text(kMobile, style: textStyle14Bold)),
                          // horizontalSpace6,
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              minLines: 1,
                              maxLength: 20,
                              enabled: false,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              controller: dispensaryController.cityController,
                              textCapitalization: TextCapitalization.sentences,

                              // validator: (_desc) => _desc!.length != 10
                              //     ? kMsgMobileIsRequired
                              //     : null,
                              // initialValue: "hello",
                              style: TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                  labelText: kCity,
                                  contentPadding: EdgeInsets.all(12)),
                            ),
                          ),
                          horizontalSpace12,
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              // initialValue:
                              minLines: 1,
                              maxLength: 20,
                              enabled: false,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              controller: dispensaryController.stateController,
                              //TextEditingController(text: 'Initial value'),//
                              textCapitalization: TextCapitalization.sentences,
                              // validator: (_desc) => _desc!.length != 6
                              //     ? kMsgPincodeIsRequired
                              //     : null,
                              style: TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                  labelText: kState,
                                  contentPadding: EdgeInsets.all(12)),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace6,
                      Text(kPrescriptionUpload, style: textStyle14Bold),
                      verticalSpace12,
                      if (dispensaryController.files.isNotEmpty &&
                          dispensaryController.selectedFilesList.isEmpty) ...[
                        Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.height * 0.2,

                              child: ListView.builder(
                                // shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: dispensaryController.files.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        Image.file(
                                          dispensaryController.files[index],
                                          scale: 2,
                                          // width: MediaQuery.of(context).size.width,
                                          // height:
                                          //     MediaQuery.of(context).size.height * 0.5,
                                          // // File(_controller.capturedImageList[index].path),
                                          fit: BoxFit.cover,
                                        ),
                                        IconButton(
                                          // padding:
                                          //     const EdgeInsets.only(left: 70),
                                          icon: const Icon(
                                            Icons.cancel_rounded,
                                            size: 30,
                                            color: Colors.red,
                                          ),
                                          // calling update is multiple checked method
                                          onPressed: () async =>
                                              dispensaryController
                                                  .updateCapturedImages(index),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            (dispensaryController.files[index]
                                                            .lengthSync() /
                                                        (1024 * 1024))
                                                    .toStringAsFixed(2) +
                                                " MB".toString(),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ), // IMAGE SHOWING
                            )),
                      ] else if (dispensaryController.files.isEmpty &&
                          dispensaryController
                              .selectedFilesList.isNotEmpty) ...[
                        Text('$kSelectedFiles:', style: textStyle14Bold),
                        verticalSpace6,
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: dispensaryController.selectedFilesList
                              .map(
                                (PlatformFile _file) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.55,
                                        child: Text(
                                          _file.name,
                                          style: textStyle14Normal,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Text(
                                        " (" +
                                            (_file.size / (1024 * 1024))
                                                .toStringAsFixed(3) +
                                            //
                                            " MB)",
                                        style: textStyle14Normal,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 30,
                                          color: Colors.red,
                                        ),
                                        onPressed: () async =>
                                            dispensaryController
                                                .updateSelectedFilesList(_file),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ] else if (dispensaryController.files.isNotEmpty &&
                          dispensaryController
                              .selectedFilesList.isNotEmpty) ...[
                        Text('$kSelectedFiles:', style: textStyle14Bold),
                        verticalSpace6,
                        Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.height * 0.3,

                              child: ListView.builder(
                                // shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: dispensaryController.files.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        Image.file(
                                          dispensaryController.files[index],
                                          scale: 2,
                                          fit: BoxFit.cover,
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.cancel_rounded,
                                            size: 30,
                                            color: Colors.red,
                                          ),
                                          onPressed: () async =>
                                              dispensaryController
                                                  .updateCapturedImages(index),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            (dispensaryController.files[index]
                                                            .lengthSync() /
                                                        (1024 * 1024))
                                                    .toStringAsFixed(2) +
                                                " MB".toString(),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ), // IMAGE SHOWING
                            )),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: dispensaryController.selectedFilesList
                              .map(
                                (PlatformFile _file) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          // "FDXGCHVJBKN HWDFRTSDAGJYHKUJL YFSTJUGKDHILJOKL HRSTYFJGUKHIJLKO; HRTDSYFVJGKUCHILJOPK HSRTDYFJUGKHILJOKD TRDHYFJSGUKDHILJOKP HGFJKSDLF;D HTCYJFVUKGIDHOFJKPLS RTDHYFJGUKIHOJFPK HFTGYUHISOJFKPSL[.JYFTDGUKHIJE.FDGYUHFBJNKM].EWTYGUKHIJDF.YFTGUHIOJ DSRTDYFGUHIJSDLM,DSGFHJKLFD "
                                          _file.name +
                                              " (" +
                                              (_file.size / (1024 * 1024)
                                                  // (pow(
                                                  //     1024,
                                                  //     (log(_file.size) /
                                                  //             log(1024))
                                                  //         .floor()))
                                                  )
                                                  .toStringAsFixed(3) +
                                              " MB)",
                                          style: textStyle14Normal,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      IconButton(
                                        // padding: const EdgeInsets.only(left: 70),
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 30,
                                          color: Colors.red,
                                        ),

                                        // calling update is multiple checked method
                                        onPressed: () async =>
                                            dispensaryController
                                                .updateSelectedFilesList(_file),
                                      ),
                                    ],
                                  ),
                                  // child: Container(
                                  //   width: MediaQuery.of(context).size.width,
                                  //   height:
                                  //       MediaQuery.of(context).size.height * 0.2,
                                  //   child: Image.file(_controller.file!),
                                  // ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryIconButton(
                              text: kCapture,
                              icon: Icons.camera,
                              btnColor: colorController.kPrimaryColor,
                              margin: const EdgeInsets.only(),
                              // calling capture image method
                              onPressed: () =>
                                  dispensaryController.checkPermission(),
                              btnTextStyle:
                                  buttonTextStyle.copyWith(color: Colors.black),
                            ),
                          ),
                          horizontalSpace12,
                          Expanded(
                            child: PrimaryIconButton(
                              text: kChooseFile,
                              icon: Icons.attachment_outlined,
                              btnColor: colorController.kPrimaryColor,
                              margin: const EdgeInsets.only(),
                              // calling choose files method
                              onPressed: () {
                                dispensaryController.checkFilePermission();
                              },
                              btnTextStyle:
                                  buttonTextStyle.copyWith(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace18,
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              minLines: 3,
                              maxLines: 5,
                              maxLength: 500,
                              autocorrect: false,
                              keyboardType: TextInputType.multiline,
                              controller:
                                  dispensaryController.remarksController,
                              textCapitalization: TextCapitalization.sentences,
                              decoration: const InputDecoration(
                                  labelText: kRemarks,
                                  contentPadding: EdgeInsets.all(12)),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace12,
                      PrimaryButton(
                        text: kSubmit,
                        onPressed: () {
                          if (dispensaryController.formKey.currentState!
                              .validate()) {
                            dispensaryController.formKey.currentState!.save();

                            print(
                                "selected dependent :: ${dispensaryController.addressController.text}");
                            // calling add new call method
                            dispensaryController.addNewCall().then((value) {
                              if (value == 1) {
                                onBottomNavTapped(1);
                              }
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    } catch (e, s) {
      handleException(
        exception: e,
        stackTrace: s,
        exceptionClass: "dispensary_add_call",
        exceptionMsg: 'exception while choosing files',
      );
      _gailConnectServices.submitExceptionApi(
        issue: e.toString(),
        trace: s.toString(),
        screen: "dispensary_add_call",
      );
      return Container();
    }
  }

  void searchAddress(
      DispensaryController controller, BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        int selectedRadio = 0;
        return AlertDialog(
          title: DropdownSearch<AddressDetailsModel>(
            // showSearchBox: true,
            // mode: Mode.BOTTOM_SHEET,
            // showAsSuffixIcons: true,
            items: controller.addressList,
            // label: kSelectAddress,
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: kSelectAddress,
                hintText: kSelectAddress,
              ),
            ),

            // dropdownSearchBaseStyle: textStyle13Normal,
            itemAsString: (AddressDetailsModel? _area) =>
                _area!.addressDetails.toString(),
            // calling on area selected method
            onChanged: (AddressDetailsModel? _addressDetails) =>
                controller.onAddressDetailsSelectd(
                    addressdetails: _addressDetails, context: context),
            // emptyBuilder: (context, _searchString) =>
            //     const Scaffold(body: NoRecordsFound()),
          ),
        );
      },
    );
  }

  Widget DispensaryPendingg(var context) {
    ColorController colorController = Get.put(ColorController());
    // DispensaryHistoryController _controller =
    //     Get.put(DispensaryHistoryController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GetBuilder<DispensaryHistoryController>(
        id: kDispensaryHistory,
        init: DispensaryHistoryController(),
        builder: (_controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_controller.isLoading) ...[
                const Expanded(child: const LoadingWidget()),
              ] else if (_controller.userCallsList.isEmpty) ...[
                const Expanded(child: NoRecordsFound()),
              ] else ...[
                verticalSpace12,
                Expanded(
                  child: ListView.builder(
                    itemCount: _controller.userCallsList.length,
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 36),
                    itemBuilder:
                        // _listItemBuilder,
                        (context, _position) {
                      final DispensaryHistoryModel _dispensaryData =
                          _controller.userCallsList[_position];

                      final Color _callIdColor =
                          (_dispensaryData.empno!.toString().toLowerCase() ==
                                  kOpen.toLowerCase())
                              ? colorController.kPrimaryColor
                              : colorController.kPrimaryDarkColor;

                      // return GestureDetector(
                      //   onTap: () => Get.toNamed(kDispensaryHistoryDetailsRoute,
                      //       arguments: [
                      //         "req",
                      //         _dispensaryData.sno!.toStringAsFixed(0)
                      //       ]),
                      return _dispensaryData.status.toString() == "Processed" ||
                              _dispensaryData.status.toString() == "Billed" ||
                              _dispensaryData.status.toString() == "Received" ||
                              _dispensaryData.status.toString() ==
                                  "Processing" ||
                              _dispensaryData.status.toString() ==
                                  "OUT FOR DELIVERY" ||
                              _dispensaryData.status.toString == "CANCELLED" ||
                              (_dispensaryData.acknowledgebyuser == null &&
                                  _dispensaryData.status.toString() ==
                                      "Delivered")
                          ? MaterialCard(
                              borderRadius: 12,
                              shadowColor: Colors.black38,
                              padding: const EdgeInsets.only(),
                              margin: const EdgeInsets.only(bottom: 12),
                              // onTap: () => _controller.onUserCallSelected(
                              //     userCall: _dispensaryData),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: RichTextWidget(
                                            caption: "Req No",
                                            //kCallId,
                                            textAlign: TextAlign.center,
                                            description: _dispensaryData.sno
                                                    .toString()
                                                    .isEmpty
                                                ? ""
                                                : _dispensaryData.sno!,
                                            // .toStringAsFixed(0),
                                            captionStyle: textStyle12Bold
                                                .copyWith(color: Colors.black),
                                            descriptionStyle: textStyle12Bold
                                                .copyWith(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            DispensaryHistoryDetailsController
                                                controller = Get.put(
                                                    DispensaryHistoryDetailsController());
                                            controller.getRequestHistoryApi(
                                                _dispensaryData.sno!);
                                            // int count = 0;
                                            Get.put(_controller);

                                            if (controller
                                                    .dispensaryAddressDetailsModel
                                                    .length ==
                                                0) {
                                            } else {
                                              controller.getRequestHistoryApi(
                                                  _dispensaryData.sno!);
                                              // int count = 0;
                                              Get.put(_controller);
                                              _showInfoDialogHistory(
                                                  context,
                                                  _controller,
                                                  _dispensaryData.sno!);
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              _dispensaryData.status == null
                                                  ? const Text("")
                                                  : FittedBox(
                                                      child: Text(
                                                        _dispensaryData.status
                                                                    .toString() ==
                                                                "Received"
                                                            ? "REQUESTED"
                                                            : _dispensaryData
                                                                .status
                                                                .toString()
                                                                .toUpperCase(),
                                                        style: textStyle10black,
                                                      ),
                                                    ),
                                              ElevatedButtonPending(
                                                ackno: _dispensaryData
                                                    .acknowledgebyuser
                                                    .toString(),
                                                status: "circle",
                                                cancelstatus: "",
                                                text: 'View',
                                                onPressed: () {},
                                                btnColor: colorController
                                                    .kPrimaryDarkColor,
                                              ),

                                              /*   Icon(Icons.circle,
                                            color: _dispensaryData
                                                .acknowledgebyuser
                                                .toString() ==
                                                "1"
                                                ? (_dispensaryData.status
                                                .toString() ==
                                                "Cancelled"
                                                ? colorController.kPrimaryColor
                                                : colorController.kPrimaryColor)
                                                : (_dispensaryData
                                                .acknowledgebyuser
                                                .toString() ==
                                                "0"
                                                ? colorController.kPrimaryColor
                                                : colorController.kPrimaryColor))*/
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const Divider(height: 1, color: Colors.black),
                                  verticalSpace6,
                                  HeadingRowItem(
                                    caption: kDependent,
                                    desc: _dispensaryData.dependant!.isEmpty
                                        ? ""
                                        : _dispensaryData.dependant!,
                                    icon: "",
                                  ),
                                  HeadingRowItem(
                                    maxLines: 2,
                                    caption: kDatecash,
                                    desc: _dispensaryData.dateCreated!.isEmpty
                                        ? "null"
                                        : _dispensaryData.dateCreated!,
                                    icon: "",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  HeadingRowItem(
                                    maxLines: 2,
                                    caption: kOrderID,
                                    desc: _dispensaryData.apolloorderno == null
                                        ? ""
                                        : _dispensaryData.apolloorderno
                                            .toString(),
                                    icon: "",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  verticalSpace12,
                                  _dispensaryData.invoiceno
                                              .toString()
                                              .isEmpty ||
                                          _dispensaryData.invoiceno
                                                  .toString() ==
                                              "null"
                                      ? const Text("")
                                      : Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Column(
                                            children: [
                                              const Divider(
                                                  height: 1,
                                                  color: Colors.black),
                                              verticalSpace6,
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        _dispensaryData
                                                                .empno!.isEmpty
                                                            ? "null"
                                                            : "Inv : " +
                                                                _dispensaryData
                                                                    .invoiceno
                                                                    .toString() +
                                                                "  " +
                                                                "(" +
                                                                _dispensaryData
                                                                    .dateCreated
                                                                    .toString() +
                                                                ")",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                    amount(_dispensaryData
                                                        .invoicedetails
                                                        .toString()),
                                                    const Spacer(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: _dispensaryData
                                                                  .voicepdf
                                                                  .toString() ==
                                                              "null"
                                                          ? const Text("")
                                                          : GestureDetector(
                                                              onTap: () async {
                                                                // print("asdfghj" + _dispensaryData.voicepdf.toString());
                                                                await launch("https://gailebank.gail.co.in/GAIL_APIs/CallImages/" +
                                                                    _dispensaryData
                                                                        .voicepdf
                                                                        .toString());
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .picture_as_pdf,
                                                                color: colorController
                                                                    .kPrimaryColor,
                                                              )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  verticalSpace12,
                                  const Divider(height: 1, color: Colors.black),
                                  verticalSpace6,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButtonPending(
                                        status: "",
                                        cancelstatus: "",
                                        ackno: "",
                                        text: 'View',
                                        onPressed: () {
                                          Get.toNamed(
                                              kDispensaryHistoryDetailsRoute,
                                              arguments: [
                                                "req",
                                                _dispensaryData.sno!,
                                                // toStringAsFixed(0)
                                              ]);
                                        },
                                        btnColor:
                                            colorController.kPrimaryDarkColor,
                                      ),
                                      FittedBox(
                                        child: ElevatedButtonPending(
                                          ackno: "",
                                          text: 'Cancel',
                                          status:
                                              _dispensaryData.status.toString(),
                                          cancelstatus: _dispensaryData
                                              .cancelleationstatus
                                              .toString(),
                                          onPressed: () {
                                            if (_dispensaryData.status
                                                        .toString() ==
                                                    "Processed" ||
                                                _dispensaryData.status
                                                        .toString() ==
                                                    "Received" ||
                                                _dispensaryData.status
                                                        .toString() ==
                                                    "Processing") {
                                              _showInfoDialogCancel(
                                                  context,
                                                  _controller,
                                                  _dispensaryData.sno!);
                                            }
                                          },
                                          btnColor: _dispensaryData.status
                                                          .toString() ==
                                                      "Processed" ||
                                                  _dispensaryData.status
                                                          .toString() ==
                                                      "Received" ||
                                                  _dispensaryData.status
                                                              .toString() ==
                                                          "Processing" &&
                                                      _dispensaryData
                                                              .cancelleationstatus ==
                                                          null
                                              ? colorController
                                                  .kPrimaryDarkColor
                                              : colorController.kDarkGreyColor,
                                        ),
                                      ),
                                      FittedBox(
                                        child: ElevatedButtonPending(
                                          text: 'Acknowledge',
                                          ackno: "",
                                          status:
                                              _dispensaryData.status.toString(),
                                          cancelstatus: "",
                                          onPressed: () {
                                            var amt = _dispensaryData
                                                .invoicedetails!
                                                .split("(");
                                            String amount =
                                                amt[0].trim().toString();

                                            _controller.remarksController.text =
                                                "Invoice Amount: " +
                                                    amount.toString() +
                                                    "/-";
                                            _controller.update();

                                            if (_dispensaryData.status
                                                    .toString() ==
                                                "Delivered") {
                                              _showInfoDialog(
                                                  context,
                                                  _controller,
                                                  _dispensaryData.sno!,
                                                  _dispensaryData
                                                      .acknowledgebyuser);
                                            }
                                          },
                                          btnColor: _dispensaryData.status
                                                      .toString() ==
                                                  "Delivered"
                                              ? colorController
                                                  .kPrimaryDarkColor
                                              : colorController.kDarkGreyColor,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          : Container();
                    },
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Row addRadioButton(int btnIndex, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GetBuilder<DispensaryHistoryController>(
          builder: (_controller) => Radio(
              activeColor: Colors.blue,
              value: _controller.acknowledgestatus[btnIndex],
              groupValue: _controller.select,
              onChanged: (value) => _controller.onClickRadioButton(value)),
        ),
        Text(title)
      ],
    );
  }

  Future<void> _showInfoDialog(
      BuildContext context,
      DispensaryHistoryController controller,
      String sno,
      String? acknowledgebyuser) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        int selectedRadio = 0;
        return AlertDialog(
          // title: Text("Select Grade System and No of Subjects"),
          actions: <Widget>[
            Container(
              width: 260.0,
              // height: 230.0,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                color: const Color(0xFFFFFF),
                // border: Border.all(color: Colors.blueAccent),
                borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: const Text(
                          "Receipt Acknowledgement",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.cancel,
                            color: Colors.black,
                          ))
                    ],
                  ),
                  verticalSpace12,
                  const Divider(height: 1, color: Colors.black),
                  verticalSpace6,
                  Row(
                    children: [
                      addRadioButton(0, "Received"),
                      addRadioButton(1, "Not Received"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      minLines: 3,
                      maxLines: 5,
                      maxLength: 500,
                      autocorrect: false,
                      keyboardType: TextInputType.multiline,
                      controller: controller.remarksController,
                      textCapitalization: TextCapitalization.sentences,
                      // validator: (_desc) => _desc!.isEmpty
                      //     ? kMsgDescriptionIsRequired
                      //     : null,
                      decoration: const InputDecoration(
                          labelText: kRemarks,
                          contentPadding: EdgeInsets.all(12)),
                    ),
                  ),
                  acknowledgebyuser == null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ElevatedButton(
                              clipBehavior: Clip.antiAlias,
                              onPressed: () => {
                                controller
                                    .acknowledgeApiHit(sno, context)
                                    .then((value) {
                                  if (value == 1) {
                                    onBottomNavTapped(2);
                                  }
                                }),
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                backgroundColor:
                                    colorController.kPrimaryDarkColor,
                                elevation: 5,
                                visualDensity:
                                    VisualDensity.adaptivePlatformDensity,
                              ),
                              child: const Text("Submit",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    letterSpacing: 0.55,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ),
                        )
                      : const Text(""),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  _showInfoDialogCancel(BuildContext context,
      DispensaryHistoryController controller, String SNO) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        int selectedRadio = 0;
        return AlertDialog(
          title: Column(
            children: [
              Row(
                children: [
                  const Text("Confirmation"),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.cancel,
                        color: Colors.black,
                      ))
                ],
              ),
              verticalSpace12,
              const Divider(height: 1, color: Colors.black),
              verticalSpace6,
            ],
          ),
          content: const Text("Would you like to Cancel this Order?"),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                controller.pharmacyRequestCancel(SNO, context).then((value) {
                  if (value == 1) {
                    onBottomNavTapped(2);
                  }
                });
              },
            ),
          ],
        );
      },
    );
  }

  Widget DispensaryHistoryy(BuildContext context) {
    //     final SharedPrefs _sharedPrefs = SharedPrefs.to;
    // _sharedPrefs.reqNumber = Get.arguments[1].toString();
    return Scaffold(
      backgroundColor: Colors.transparent,
      //appBar: CustomAppBar(title: kDispensary),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: kPrimaryDarkColor,
      //   onPressed: () => Get.toNamed(kDispensaryAddRoute),
      //   child: const Icon(Icons.add, size: 30),
      // ),
      body: GetBuilder<DispensaryHistoryController>(
        id: kDispensaryHistory,
        init: DispensaryHistoryController(),
        builder: (_controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_controller.isLoading) ...[
                const Expanded(child: LoadingWidget()),
              ] else if (_controller.userCallsList.isEmpty) ...[
                const Expanded(child: NoRecordsFound()),
              ] else ...[
                verticalSpace12,
                Expanded(
                  child: ListView.builder(
                    itemCount: _controller.userCallsList.length,
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 36),
                    itemBuilder:
                        // _listItemBuilder,
                        (context, _position) {
                      final DispensaryHistoryModel _dispensaryData =
                          _controller.userCallsList[_position];

                      final Color _callIdColor =
                          (_dispensaryData.empno!.toString().toLowerCase() ==
                                  kOpen.toLowerCase())
                              ? colorController.kPrimaryColor
                              : Colors.green;

                      // return GestureDetector(
                      //   onTap: () => Get.toNamed(kDispensaryHistoryDetailsRoute,
                      //       arguments: [
                      //         "req",
                      //         _dispensaryData.sno!.toStringAsFixed(0)
                      //       ]),
                      return _dispensaryData.status.toString() == "Processed" ||
                              _dispensaryData.status.toString() == "Billed" ||
                              _dispensaryData.status.toString() == "Received" ||
                              _dispensaryData.status.toString() ==
                                  "Processing" ||
                              _dispensaryData.status.toString() ==
                                  "OUT FOR DELIVERY" ||
                              _dispensaryData.status.toString == "CANCELLED" ||
                              (_dispensaryData.acknowledgebyuser == null &&
                                  _dispensaryData.status.toString() ==
                                      "Delivered")
                          ? Container()
                          : MaterialCard(
                              borderRadius: 12,
                              shadowColor: Colors.black38,
                              padding: const EdgeInsets.only(),
                              margin: const EdgeInsets.only(bottom: 12),
                              // onTap: () => _controller.onUserCallSelected(
                              //     userCall: _dispensaryData),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  // _showInfoDialogPrescription(context,_controller,_dispensaryData.sno!);
                                                },
                                                child: RichTextWidget(
                                                  caption: "Req No",
                                                  //kCallId,
                                                  textAlign: TextAlign.center,
                                                  description: _dispensaryData
                                                          .sno
                                                          .toString()
                                                          .isEmpty
                                                      ? ""
                                                      : _dispensaryData.sno!,
                                                  // .toStringAsFixed(0),
                                                  captionStyle:
                                                      textStyle14Bold.copyWith(
                                                          color: Colors.black),
                                                  descriptionStyle:
                                                      textStyle14Bold.copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                              const Divider(
                                                  height: 1,
                                                  color: Colors.black),
                                              verticalSpace6,
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            DispensaryHistoryDetailsController
                                                controller = Get.put(
                                                    DispensaryHistoryDetailsController());
                                            controller.getRequestHistoryApi(
                                                _dispensaryData.sno!);
                                            // int count = 0;
                                            Get.put(_controller);

                                            if (controller
                                                    .dispensaryAddressDetailsModel
                                                    .length ==
                                                0) {
                                            } else {
                                              controller.getRequestHistoryApi(
                                                  _dispensaryData.sno!);
                                              // int count = 0;
                                              Get.put(_controller);
                                              _showInfoDialogHistory(
                                                  context,
                                                  _controller,
                                                  _dispensaryData.sno!);
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              _dispensaryData.status == null
                                                  ? const Text("")
                                                  : Text(_dispensaryData.status
                                                      .toString()
                                                      .toUpperCase()),
                                              ElevatedButtonPending(
                                                ackno: _dispensaryData
                                                    .acknowledgebyuser
                                                    .toString(),
                                                status: "circle",
                                                cancelstatus: "",
                                                text: 'View',
                                                onPressed: () {
                                                  // Get.toNamed(
                                                  //     kDispensaryHistoryDetailsRoute,
                                                  //     arguments: [
                                                  //       "req",
                                                  //       _dispensaryData.sno!,
                                                  //       // toStringAsFixed(0)
                                                  //     ]);
                                                },
                                                btnColor: colorController
                                                    .kPrimaryDarkColor,
                                              ),
                                              /*            Icon(Icons.circle,
                                            color: _dispensaryData
                                                .acknowledgebyuser
                                                .toString() ==
                                                "1"
                                                ? (_dispensaryData.status
                                                .toString() ==
                                                "Cancelled"
                                                ? colorController.kPrimaryColor
                                                : colorController.kPrimaryColor)
                                                : (_dispensaryData
                                                .acknowledgebyuser
                                                .toString() ==
                                                "0"
                                                ? colorController.kPrimaryColor
                                                : colorController.kPrimaryColor))*/
                                            ],
                                          ),
                                        ),

                                        // Text(_dispensaryData.status
                                        //              == null
                                        //         ? ""
                                        //         : _dispensaryData.status.toString()),
                                      )
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       vertical: 14),
                                      //   child: RichTextWidget(
                                      //     caption: "", //kCallId,
                                      //     textAlign: TextAlign.center,
                                      //     description: _dispensaryData.status
                                      //             .toString()
                                      //             .isEmpty || _dispensaryData.status
                                      //         .toString() == null
                                      //         ? ""
                                      //         : _dispensaryData.status!,
                                      //     // .toStringAsFixed(0),
                                      //     captionStyle: textStyle18Bold.copyWith(
                                      //         color: _callIdColor),
                                      //     descriptionStyle: textStyle18Bold
                                      //         .copyWith(color: _callIdColor),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  const Divider(height: 1, color: Colors.black),
                                  verticalSpace6,
                                  // HeadingRowItem(
                                  //     caption: kDependent,
                                  //     desc: _dispensaryData.dependant!.isEmpty
                                  //         ? ""
                                  //         : _dispensaryData.dependant!,
                                  //   icon: "",),

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, left: 12, right: 12),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text(kDependent,
                                                style: textStyle12Bold)),
                                        Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child:
                                              Text(':', style: textStyle14Bold),
                                        ),
                                        horizontalSpace6,
                                        Expanded(
                                            flex: 4,
                                            child: Text(
                                                _dispensaryData
                                                        .dependant!.isEmpty
                                                    ? ""
                                                    : _dispensaryData
                                                        .dependant!,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: textStyle14Normal)),
                                        horizontalSpace6,
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, left: 12, right: 12),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text(kDatecash,
                                                style: textStyle12Bold)),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20.0),
                                          child:
                                              Text(':', style: textStyle14Bold),
                                        ),
                                        horizontalSpace6,
                                        Expanded(
                                            flex: 5,
                                            child: Text(
                                                _dispensaryData
                                                        .dateCreated!.isEmpty
                                                    ? "null"
                                                    : _dispensaryData
                                                        .dateCreated!,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: textStyle14Normal)),
                                        horizontalSpace6,
                                      ],
                                    ),
                                  ),
                                  // HeadingRowItem(
                                  //   maxLines: 2,
                                  //   caption: kDate,
                                  //   desc: _dispensaryData.dateCreated!.isEmpty
                                  //       ? "null"
                                  //       : _dispensaryData.dateCreated!,
                                  //   icon: "prescription",
                                  //   overflow: TextOverflow.ellipsis,
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, left: 12, right: 12),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text(kOrderID,
                                                style: textStyle12Bold)),
                                        Padding(
                                          padding: EdgeInsets.only(left: 20.0),
                                          child:
                                              Text(':', style: textStyle14Bold),
                                        ),
                                        horizontalSpace6,
                                        Expanded(
                                            flex:
                                                _dispensaryData.apolloorderno ==
                                                        null
                                                    ? 5
                                                    : 3,
                                            child: Text(
                                                _dispensaryData.apolloorderno ==
                                                        null
                                                    ? ""
                                                    : _dispensaryData
                                                        .apolloorderno
                                                        .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: textStyle14Normal)),
                                        horizontalSpace6,
                                        _dispensaryData.apolloorderno == null
                                            ? Container()
                                            : Expanded(
                                                flex: 2,
                                                child: GestureDetector(
                                                    onTap: () async {
                                                      // DispensaryHistoryDetailsController
                                                      // controller =
                                                      // await Get.put(DispensaryHistoryController
                                                      //     DispensaryHistoryDetailsController());
                                                      _controller
                                                          .getreqNumverDetailsURL(
                                                              _dispensaryData
                                                                  .sno!);
                                                      // DispensaryHistoryDetailsController controller = Get.put(DispensaryHistoryDetailsController());
                                                      // // // int count = 0;
                                                      // controller.getDetailsPrescription();
                                                      // Get.put(controller);
                                                      // print(controller.dispensaryHistoryDetailsList1.length);
                                                      // print("controller.dispensaryHistoryDetailsList1.length");
                                                      _showInfoDialogPrescription(
                                                          context,
                                                          _controller,
                                                          _dispensaryData.sno!);
                                                      //
                                                      // if(controller.dispensaryHistoryDetailsList1.length == 0){
                                                      //
                                                      // }else{
                                                      //   _showInfoDialogPrescription(context,_controller,_dispensaryData.sno!);
                                                      // }
                                                    },
                                                    child: const Icon(
                                                      Icons.medication_outlined,
                                                      color: Colors.blue,
                                                    )))
                                      ],
                                    ),
                                  ),
                                  // HeadingRowItem(
                                  //   maxLines: 2,
                                  //   caption: kOrderID,
                                  //
                                  //   desc: _dispensaryData.apolloorderno == null
                                  //       ? ""
                                  //       : _dispensaryData.apolloorderno.toString(),
                                  //   icon: "mobile" /*+ _dispensaryData.apolloorderno.toString()*/,
                                  //   overflow: TextOverflow.ellipsis,
                                  // ),

                                  // HeadingRowItem(
                                  //     caption: "Mobile",
                                  //     desc: _dispensaryData.mobileNo!.isEmpty
                                  //         ? _dispensaryData.mobileNo!
                                  //         : "na"),
                                  // HeadingRowItem(
                                  //   caption: "Store",
                                  //   desc: _dispensaryData.store!,
                                  //   maxLines: 2,
                                  // ),
                                  verticalSpace12,
                                  // _dispensaryData.invoiceno == null ? Text("" ) :
                                  //     Padding(
                                  //       padding: EdgeInsets.all(0),
                                  //       child: Column(
                                  //         children: [
                                  //           const Divider(height: 1, color: Colors.black),
                                  //           verticalSpace6,
                                  //           Padding(
                                  //             padding: EdgeInsets.all(5),
                                  //             child: Row(
                                  //               children: [
                                  //                 Padding(
                                  //                   padding: const EdgeInsets.all(8.0),
                                  //                   child: Text(_dispensaryData.empno!.isEmpty
                                  //                       ? "null"
                                  //                       : "Bill: "+_dispensaryData.empno!,style: TextStyle(
                                  //                       fontWeight: FontWeight.w600
                                  //                   ),),
                                  //                 ),
                                  //
                                  //                 Padding(
                                  //                   padding: const EdgeInsets.all(8.0),
                                  //                   child: Text(_dispensaryData.dateCreated!.isEmpty
                                  //                       ? "null"
                                  //                       : _dispensaryData.dateCreated!,style: TextStyle(
                                  //                       fontWeight: FontWeight.w600
                                  //                   ),),
                                  //                 ),
                                  //                 Spacer(),
                                  //                 Padding(
                                  //                   padding: const EdgeInsets.all(8.0),
                                  //                   child: Text(_dispensaryData.dateCreated!.isEmpty
                                  //                       ? "null"
                                  //                       : "Amount",style: TextStyle(fontWeight: FontWeight.w600),),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                  // print(_dispensaryData.invoiceno.toString());
                                  _dispensaryData.invoiceno
                                              .toString()
                                              .isEmpty ||
                                          _dispensaryData.invoiceno
                                                  .toString() ==
                                              "null"
                                      ? const Text("")
                                      : Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Column(
                                            children: [
                                              const Divider(
                                                  height: 1,
                                                  color: Colors.black),
                                              verticalSpace6,
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, right: 1),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 2.0,
                                                              right: 2),
                                                      child: Text(
                                                        _dispensaryData
                                                                .empno!.isEmpty
                                                            ? "null"
                                                            : "Invoice : " +
                                                                _dispensaryData
                                                                    .invoiceno
                                                                    .toString() +
                                                                "  " +
                                                                "(" +
                                                                _dispensaryData
                                                                    .invoiceDate
                                                                    .toString() +
                                                                ")",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 10),
                                                      ),
                                                    ),

                                                    amount(_dispensaryData
                                                        .invoicedetails
                                                        .toString()),
                                                    const Spacer(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8),
                                                      child: _dispensaryData
                                                                  .voicepdf
                                                                  .toString() ==
                                                              "null"
                                                          ? const Text("")
                                                          : GestureDetector(
                                                              onTap: () async {
                                                                // print("asdfghj" + _dispensaryData.voicepdf.toString());
                                                                await launch("https://gailebank.gail.co.in/GAIL_APIs/CallImages/" +
                                                                    _dispensaryData
                                                                        .voicepdf
                                                                        .toString());
                                                              },
                                                              child: Icon(
                                                                Icons
                                                                    .picture_as_pdf,
                                                                color: colorController
                                                                    .kPrimaryColor,
                                                              )),
                                                    ),
                                                    // Spacer(),
                                                    // Padding(
                                                    //   padding: const EdgeInsets.only(right: 20.0),
                                                    //   child: GestureDetector(
                                                    //       onTap: (){
                                                    //         _showInfoDialogHistory(context,_controller,_dispensaryData.sno!);
                                                    //       },
                                                    //       child: Icon(Icons.history,color: Colors.black,)),
                                                    // )
                                                    // Spacer(),
                                                    // Padding(
                                                    //   padding: const EdgeInsets.all(8.0),
                                                    //   child: Text(_dispensaryData.dateCreated!.isEmpty
                                                    //       ? "null"
                                                    //       : "Amount",style: TextStyle(fontWeight: FontWeight.w600),),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  verticalSpace12,
                                  const Divider(height: 1, color: Colors.black),
                                  verticalSpace6,

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Padding(
                                      //   padding: const EdgeInsets.only(right: 8.0,left: 10),
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.symmetric(
                                      //         vertical: 8),
                                      //     child: SizedBox(
                                      //       child: ElevatedButton(
                                      //
                                      //         clipBehavior: Clip.antiAlias,
                                      //         onPressed: ()=>{
                                      //           _showInfoDialogPrescription(context,_controller,_dispensaryData.sno!),
                                      //           // Get.toNamed(kDispensaryHistoryDetailsRoute,
                                      //           //     arguments: [
                                      //           //       "req",
                                      //           //       _dispensaryData.sno!,
                                      //           //       // toStringAsFixed(0)
                                      //           //     ]),
                                      //         },
                                      //         style: ElevatedButton.styleFrom(
                                      //           shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                      //           primary: kPrimaryDarkColor,
                                      //           elevation: 5,
                                      //
                                      //           visualDensity: VisualDensity.adaptivePlatformDensity,
                                      //         ),
                                      //         child: Text("Prescription", style: TextStyle(
                                      //           fontSize: 14,
                                      //           color: Colors.white,
                                      //           letterSpacing: 0.55,
                                      //           fontWeight: FontWeight.w600,
                                      //         )
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      // Spacer(),
                                      ElevatedButtonPending(
                                        status: "",
                                        cancelstatus: "",
                                        ackno: "",
                                        text: 'View',
                                        onPressed: () {
                                          Get.toNamed(
                                              kDispensaryHistoryDetailsRoute,
                                              arguments: [
                                                "req",
                                                _dispensaryData.sno!,
                                                // toStringAsFixed(0)
                                              ]);
                                        },
                                        btnColor:
                                            colorController.kPrimaryDarkColor,
                                      ),
                                      /*           Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8.0, left: 10),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8),
                                    child: SizedBox(
                                      child: ElevatedButton(
                                        clipBehavior: Clip.antiAlias,
                                        onPressed: () async {
                                          // DispensaryHistoryDetailsController
                                          //     controllerdis =
                                          //     await Get.put(
                                          //         DispensaryHistoryDetailsController());

                                          print("fdghj");
                                          print(_dispensaryData.sno!);
                                          // controllerdis
                                          //     .getreqNumverDetailsURL(
                                          //         _dispensaryData.sno!);
                                          Get.toNamed(
                                              kDispensaryHistoryDetailsRoute,
                                              arguments: [
                                                "req",
                                                _dispensaryData.sno!,
                                                // toStringAsFixed(0)
                                              ]);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape:
                                          RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      10))),
                                          primary: colorController.kPrimaryDarkColor,
                                          elevation: 5,
                                          visualDensity: VisualDensity
                                              .adaptivePlatformDensity,
                                        ),
                                        child: Container(
                                          width: 109,
                                          child: Center(
                                            child: const Text("View",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  letterSpacing: 0.55,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ),*/
                                      // Padding(
                                      //   padding: const EdgeInsets.only(right: 8.0),
                                      //   child: Padding(
                                      //     padding: const EdgeInsets.symmetric(
                                      //         vertical: 8),
                                      //     child: ElevatedButton(
                                      //       clipBehavior: Clip.antiAlias,
                                      //       onPressed: ()=>{
                                      //         if(_dispensaryData.status.toString() == "Delivered"){
                                      //           _showInfoDialog(context,_controller,_dispensaryData.sno!,_dispensaryData.acknowledgebyuser),
                                      //         }
                                      //       },
                                      //       style: ElevatedButton.styleFrom(
                                      //         shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                      //         primary: _dispensaryData.status.toString() == "Delivered" ?kPrimaryDarkColor : kDarkGreyColor,
                                      //         elevation: 2,
                                      //         visualDensity: VisualDensity.adaptivePlatformDensity,
                                      //       ),
                                      //       child: Text("Acknowledge", style: TextStyle(
                                      //         fontSize: 12,
                                      //         color: Colors.white,
                                      //         letterSpacing: 0.55,
                                      //         fontWeight: FontWeight.w600,
                                      //       )),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  )
                                ],
                              ),
                            );
                    },
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget amount(String dispensary) {
    var amt = dispensary.split("(");
    String amount = amt[0].toString();
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 2),
      child: Text(
        amount.isEmpty ? "null" : "Amount: " + amount,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
      ),
    );
  }

  _showInfoDialogPrescription(BuildContext context,
      DispensaryHistoryController controller, String SNO) async {
    DispensaryHistoryController _controller =
        await Get.put(DispensaryHistoryController());
    ColorController colorController = Get.put(ColorController());

    int count = 0;
    Get.put(_controller);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        int selectedRadio = 0;
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 254, 215),
          contentPadding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // color: Color.fromARGB(255, 52, 149, 52),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: GetBuilder<DispensaryHistoryController>(
                    id: kDispensaryHistoryDetails,
                    init: DispensaryHistoryController(),
                    builder: (_cHcontroller) {
                      return ListView.builder(
                        itemCount:
                            _cHcontroller.dispensaryHistoryDetailsList1.length,
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, bottom: 10),
                        itemBuilder: (context, position) {
                          return Container(
                            // color: Colors.amber,
                            // height: 30,
                            padding: const EdgeInsets.all(4),
                            child: InkWell(
                              onTap: () {
                                launch(
                                  'https://gailebank.gail.co.in/GAIL_APIs/CallImages/' +
                                      _cHcontroller
                                          .dispensaryHistoryDetailsList1[
                                              position]
                                          .url
                                          .toString(),
                                );
                                Navigator.pop(context);
                              },
                              // child: for (var _ in Iterable.generate(_controller
                              //       .dispensaryHistoryDetailsList1.)){}
                              // for(int i = 0, i>_controller
                              //       .dispensaryHistoryDetailsList1,i++,){

                              //       }
                              child: Text(
                                  "Prescription " + (position + 1).toString(),
                                  style: textStyle14BoldClick
                                  // +
                                  //     _controller
                                  //         .dispensaryHistoryDetailsList1[position].url
                                  //         .toString(),
                                  ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                // const Divider(
                //   height: 1,
                //   color: Colors.black,
                //   indent: 20,
                // ),
              ],
            ),
          ),
          title: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // Row(
              //   children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Attachments",
                  style: TextStyle(
                    fontSize: 16,
                    color: colorController.kPrimaryDarkColor,
                    letterSpacing: 0.55,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              //     Spacer(),
              //     GestureDetector(
              //         onTap: () {
              //           Navigator.pop(context);
              //         },
              //         child: Icon(
              //           Icons.cancel,
              //           color: Colors.black,
              //         )),
              //         Text("Prescription Details"),
              //   ],
              // ),
              verticalSpace12,
              const Divider(
                height: 1,
                color: Colors.black,
                indent: 0,
              ),
              verticalSpace6,
            ],
          ),
          // content: Text("Would you like to Cancel this Order?"),
          actions: [
            // ListView.builder(
            //     shrinkWrap: true,
            //     // scrollDirection: Axis.horizontal,
            //     physics: NeverScrollableScrollPhysics(),
            //     // itemCount: 5,
            //     itemCount: _controller.dispensaryHistoryDetailsList1.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       count++;
            //       return Row(
            //         // mainAxisAlignment: MainAxisAlignment.start,
            //         // crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.only(left: 18.0, bottom: 8),
            //             child: GestureDetector(
            //               onTap: () async {
            //                 print(_controller
            //                     .dispensaryHistoryDetailsList1[index].url
            //                     .toString());
            //                 print("_controller");
            //                 await launch(
            //                     'https://gailebank.gail.co.in/common_api/CallImages/' +
            //                         _controller
            //                             .dispensaryHistoryDetailsList1[index]
            //                             .url
            //                             .toString());
            //                 Navigator.pop(context);
            //                 // await launchUrl(_url)
            //               },
            //               child: Text(
            //                 "Prescription  " + count.toString(),
            //                 style: TextStyle(color: Colors.lightBlueAccent),
            //               )
            //               /*Icon(
            //                 Icons.image_sharp,
            //                 color: Colors.black,
            //               )*/
            //               ,
            //             ),
            //           ),
            //         ],
            //       );
            //     }),
          ],
        );
      },
    );
  }

  _showInfoDialogHistory(BuildContext context,
      DispensaryHistoryController controller, String SNO) async {
    DispensaryHistoryDetailsController _controller =
        Get.put(DispensaryHistoryDetailsController());
    // _controller.getRequestHistoryApi(SNO);
    // // int count = 0;
    // Get.put(_controller);
    // print(_controller.dispensaryAddressDetailsModel.length);
    // print("_controller.dispensaryAddressDetailsModel.length");
    return AwesomeDialog(
      context: context,
      // animType: AnimType.TOPSLIDE,
      // dialogType: DialogType.SUCCES,
      btnOkColor: colorController.kPrimaryColor,
      btnCancelColor: colorController.kPrimaryColor,
      body: Column(
        children: [
          // Row(
          //             children: [
          //               Text("History Details",style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),),
          //               Spacer(),
          //               // Text("Status"),
          //               GestureDetector(
          //                   onTap: (){
          //                     Navigator.pop(context);
          //                   },
          //                   child: Icon(Icons.cancel,color: Colors.black,))
          //             ],
          //           ),
          //           verticalSpace12,
          //           const Divider(height: 1, color: Colors.black),
          //           verticalSpace12,
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              children: [
                const Text(
                  "STATUS",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                //  Spacer(),
                // Padding(
                //   padding: const EdgeInsets.only(right: 18.0),
                //   child: Container(
                //     width: 5,
                //     height: 20,
                //     color: Colors.black,
                //   ),
                // ),
                const Spacer(),
                const Text(
                  "DATE",
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          verticalSpace12,
          const Divider(height: 2, color: Colors.black),
          verticalSpace12,

          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: ListView.builder(
                shrinkWrap: true,
                // scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                // itemCount: 5,
                itemCount: _controller.dispensaryAddressDetailsModel.length,
                itemBuilder: (BuildContext context, int index) {
                  // count++;
                  // print(_controller.dispensaryAddressDetailsModel.length);
                  // print("_controller.dispensaryAddressDetailsModel.length");
                  return Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(_controller
                            .dispensaryAddressDetailsModel[index].address
                            .toString()
                            .toUpperCase()),
                      ),

                      const Spacer(),

                      // Container(
                      //   width: 5,
                      //   height: 20,
                      //   color: Colors.black,
                      // ),
                      // Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(_controller
                            .dispensaryAddressDetailsModel[index].pin
                            .toString()),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 18.0,bottom: 8),
                      //   child: GestureDetector(
                      //     onTap: () async{
                      //
                      //       // await launchUrl(_url)
                      //     },
                      //     child: Text(_controller.dispensaryAddressDetailsModel[index].pin.toString(),style: TextStyle(color: Colors.lightBlueAccent),)
                      //     /*Icon(
                      //       Icons.image_sharp,
                      //       color: Colors.black,
                      //     )*/,
                      //   ),
                      // ),
                    ],
                  );
                }),
          ),
        ],
      ),
      // title: 'HIstory',
      // desc:   'This is also Ignored',
      btnOkOnPress: () {},
    )..show();
  }

  Widget bottomButtonDesign(
    int index,
    String name,
    String firstImage,
    String secondImage,
    Color iconColor1,
    Color iconColor2,
    double scale,
  ) {
    return Container(
      height: 30,
      width: 100,
      decoration: BoxDecoration(
        color: currentIndex == index ? iconColor2 : iconColor1,
        // image: DecorationImage(
        //   image: AssetImage(
        //       'assets/icons/apps.png'),
        //   fit: BoxFit.cover,
        // ),
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Row(
        children: [
          horizontalSpace3,
          // ignore: prefer_const_constructors
          name == "Requisition"
              ? Icon(
                  Feather.play_circle,
                  color: Colors.white,
                )
              : name == "In Process"
                  ? Icon(
                      Icons.delivery_dining,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.assignment,
                      color: Colors.white,
                    ),
          // Image.asset(currentIndex == index ? firstImage : secondImage,
          //     height: 18, width: 18, scale: scale, color: Colors.white
          //     // mainDashController.pageIndex == index
          //     //     ? Colors.white
          //     //     : iconColor2
          //     ),
          horizontalSpace3,
          Text(
            name,
            style: TextStyle(color: Colors.white, fontSize: 11),
          )
        ],
      ),
    );
  }

  void getAcknowledgeData() async {
    String? response;
    response = await GailConnectServices.to.getAcknowledeResponse();
    if (response == "Acknowledged") {
      print(response! + "Acknowledged");
    } else {
      showCustomDialogAcknowledge(Get.context!,
          title: kWarning,
          description:
              'Please acknowledge receipt of previously ordered medicines before creating new request.',
          onPositivePressed: () {
        onBottomNavTapped(1);
        Navigator.pop(Get.context!);
      }, onNegativePressed: () {});
      // showCustomDialogBox(
      //     context: Get.context!,
      //     title: kWarning,

      //     description:
      //         "Please acknowledge receipt of previously ordered medicines before creating new request.");
    }
  }

  void getCheckConnectivity() async {
    if (await checkConnectivity()) {
      Future.delayed(
        const Duration(seconds: 2),
        () {},
      ).then(
        (value) {
          setState(() {
            getAcknowledgeData();
          });
        },
      );
    } else {
      print('No Internet Connection');
    }
  }
}
