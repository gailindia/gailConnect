// Created By Amit Jangid on 24/11/21



import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/useful_links_controllers/dispensary_controller.dart';
import 'package:gail_connect/main.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';

import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/primary_icon_button.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';

import '../../../../models/address_details_model.dart';

class Dispensary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GailConnectServices _gailConnectServices = GailConnectServices.to;
    try {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
        //  appBar: CustomAppBar(title: kDispensary),
          body: GetBuilder<DispensaryController>(
            id: kDispensary,
            init: DispensaryController(),
            builder: (_controller) {
              return SingleChildScrollView(
                padding: const EdgeInsets.only(
                    top: 18, left: 12, right: 12, bottom: 48),
                child: Form(
                  key: _controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text('$kUser:', style: textStyle18Bold),
                          horizontalSpace6,
                          Expanded(
                              child: Text(
                                  MainDashController
                                      .to.loggedInEmployee!.empName!,
                                  style: textStyle18Bold)),
                        ],
                      ),
                      verticalSpace18,
                      Row(
                        children: [
                          // const Expanded(
                          //     child: Text(kDependent, style: textStyle14Bold)),
                          // horizontalSpace6,
                          Expanded(
                            flex: 3,
                            child: DropdownSearch<String>(
                              // showSearchBox: true,
                              // mode: Mode.BOTTOM_SHEET,
                              // showAsSuffixIcons: true,
                              items: _controller.dependantlist,
                              // label: kSelectDependant,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: kSelectDependant,
                                  hintText: kSelectDependant,
                                ),
                              ),
                              // dropdownSearchBaseStyle: textStyle13Normal,
                              // calling on area selected method
                              onChanged: (String? _dependant) => _controller
                                  .onDependantSelected(dependant: _dependant),
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
                              enabled: _controller.medicalstorelist.length > 1
                                  ? true
                                  : false,
                              // maxHeight: 500,
                              // showSearchBox: true,
                              // showClearButton: true,
                              // mode: Mode.BOTTOM_SHEET,
                              // showAsSuffixIcons: true,
                              items: _controller.medicalstorelist,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: kSelectPharmacy,
                                  hintText: kSelectPharmacy,
                                ),
                              ),
                              // label: kSelectPharmacy,
                              // dropdownSearchBaseStyle: textStyle13Normal,
                              selectedItem: _controller.medicalstore,
                              // calling on area selected method
                              onChanged: (String? _medicalStore) => _controller
                                  .onStoreSelected(store: _medicalStore),
                              // emptyBuilder: (context, _searchString) =>
                              //     const Scaffold(body: NoRecordsFound()),
                            ),
                          ),
                          horizontalSpace12,
                          Expanded(
                            flex: 3,
                            child: DropdownSearch<String>(
                              enabled: _controller.deliverymode.length > 1
                                  ? true
                                  : false,

                              // mode: Mode.BOTTOM_SHEET,
                              // showAsSuffixIcons: true,
                              items: _controller.deliverymode,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: kModeOfDelivery,
                                  hintText: kModeOfDelivery,
                                ),),
                              // label: kModeOfDelivery,
                              selectedItem: _controller.delivery,

                              // dropdownSearchBaseStyle: textStyle13Normal,

                              // calling on area selected method
                              onChanged: (String? _deliveryMode) =>
                                  _controller.onDeliveryModeSelected(
                                      deliverymode: _deliveryMode),
                              // emptyBuilder: (context, _searchString) =>
                              //     const Scaffold(body: NoRecordsFound()),
                            ),
                          ),
                        ],
                      ),
                      // verticalSpace18,
                      // Row(
                      //   children: [
                      //     // const Expanded(
                      //     //     child:
                      //     //         Text(kModeOfDilevery, style: textStyle14Bold)),
                      //     // horizontalSpace6,

                      //   ],
                      // ),
                      verticalSpace18,
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: GestureDetector(
                      //         onTap: (){
                      //           _controller.clearData();
                      //
                      //     },
                      //         child: Icon(Icons.cancel,color: Colors.redAccent,))
                      //   ),
                      // ),

                      // DropdownSearch<String>(
                      //   maxHeight: 500,
                      //   showSearchBox: true,
                      //   // showClearButton: true,
                      //   mode: Mode.BOTTOM_SHEET,
                      //   showAsSuffixIcons: true,
                      //   items: _controller.addresslist,
                      //   label: kSelectAddress,
                      //   dropdownSearchBaseStyle: textStyle13Normal,
                      //   // itemAsString: (DependantListModel? _area) =>
                      //   //     _area!.message,
                      //   // calling on area selected method
                      //   onChanged: (String? _addressDetails) => _controller
                      //       .onAddressDetailsSelectd(addressdetails: _addressDetails),
                      //   emptyBuilder: (context, _searchString) =>
                      //   const Scaffold(body: NoRecordsFound()),
                      // ),
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
                              controller: _controller.addressController,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (_desc) => _desc!.isEmpty
                                  ? kMsgDescriptionIsRequired
                                  : null,
                              decoration: const InputDecoration(
                                  labelText: kDeliveryAddress,
                                  contentPadding: EdgeInsets.all(12)),
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      searchAddress(_controller, context);
                                    },
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    )),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                      padding: const EdgeInsets.only(top: 30.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            _controller.clearData();
                                          },
                                          child: Icon(
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
                              controller: _controller.mobileController,
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
                              // initialValue:
                              minLines: 1,
                              maxLength: 6,
                              autocorrect: false,
                              keyboardType: TextInputType.number,
                              controller: _controller
                                  .pincodeController, //TextEditingController(text: 'Initial value'),//
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
                              controller: _controller.cityController,
                              textCapitalization: TextCapitalization.sentences,
                              // validator: (_desc) => _desc!.length != 10
                              //     ? kMsgMobileIsRequired
                              //     : null,
                              // initialValue: "hello",
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
                              controller: _controller
                                  .stateController, //TextEditingController(text: 'Initial value'),//
                              textCapitalization: TextCapitalization.sentences,
                              // validator: (_desc) => _desc!.length != 6
                              //     ? kMsgPincodeIsRequired
                              //     : null,
                              decoration: const InputDecoration(
                                  labelText: kState,
                                  contentPadding: EdgeInsets.all(12)),
                            ),
                          ),
                        ],
                      ),
                      // verticalSpace12,

                      // Row(
                      //   children: [
                      //     // const Expanded(
                      //     //     child: Text(kPincode, style: textStyle14Bold)),
                      //     // horizontalSpace6,
                      //     Expanded(
                      //       flex: 3,
                      //       child: TextFormField(
                      //         minLines: 1,
                      //         autocorrect: false,
                      //         keyboardType: TextInputType.number,
                      //         controller: _controller.mobileController,
                      //         textCapitalization: TextCapitalization.sentences,
                      //         validator: (_desc) => _desc!.isEmpty
                      //             ? kMsgDescriptionIsRequired
                      //             : null,
                      //         decoration: const InputDecoration(
                      //             labelText: kPincode,
                      //             contentPadding: EdgeInsets.all(12)),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // verticalSpace12,

                      verticalSpace6,
                       Text(kPrescriptionUpload, style: textStyle14Bold),
                      verticalSpace12,
                      if (_controller.files.isNotEmpty &&
                          _controller.selectedFilesList.isEmpty) ...[
                        Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.height * 0.2,

                              child: ListView.builder(
                                // shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: _controller.files.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        Image.file(
                                          _controller.files[index],
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
                                          onPressed: () async => _controller
                                              .updateCapturedImages(index),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            (_controller.files[index]
                                                            .lengthSync() /
                                                        (1024 * 1024))
                                                    .toStringAsFixed(2) +
                                                " MB".toString(),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                  // Image.file(
                                  //   _controller.files![index].path,
                                  //   fit: BoxFit.cover,
                                  // );
                                },
                                // child: Image.file(
                                //     _controller.file!)
                              ), // IMAGE SHOWING
                            )
                            // Text(_controller.capturedImage!.name,
                            //     style: textStyle14Normal),
                            ),
                      ] else if (_controller.files.isEmpty &&
                          _controller.selectedFilesList.isNotEmpty) ...[
                         Text('$kSelectedFiles:', style: textStyle14Bold),
                        verticalSpace6,
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _controller.selectedFilesList
                              .map(
                                (PlatformFile _file) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      Text(
                                          _file.name +
                                              " (" +
                                              (_file.size / (1024 * 1024)
                                                  // (pow(
                                                  //     1024,
                                                  //     (log(_file.size) /
                                                  //             log(1024))
                                                  //         .floor()))
                                                  )
                                                  // .toString()
                                                  .toStringAsFixed(3) +
                                              //
                                              " MB)",
                                          style: textStyle14Normal),
                                      IconButton(
                                        // padding: const EdgeInsets.only(left: 70),
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 30,
                                          color: Colors.red,
                                        ),

                                        // calling update is multiple checked method
                                        onPressed: () async => _controller
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
                      ] else if (_controller.files.isNotEmpty &&
                          _controller.selectedFilesList.isNotEmpty) ...[
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
                                itemCount: _controller.files.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Stack(
                                      children: [
                                        Image.file(
                                          _controller.files[index],

                                          scale: 2,
                                          // width: 100,
                                          // height: 360,
                                          // width: MediaQuery.of(context)
                                          //         .size
                                          //         .width *
                                          //     0.3,
                                          // height: MediaQuery.of(context)
                                          //         .size
                                          //         .height *
                                          //     0.6,
                                          // // File(_controller.capturedImageList[index].path),
                                          fit: BoxFit.cover,
                                        ),
                                        IconButton(
                                          // visualDensity:
                                          //     VisualDensity.comfortable,
                                          // alignment: Alignment(100.0, 10.0),
                                          // padding:
                                          //     const EdgeInsets.only(left: 10),
                                          icon: const Icon(
                                            Icons
                                                .cancel_rounded, //cancel_rounded,
                                            size: 30,
                                            color: Colors.red,
                                          ),

                                          // calling update is multiple checked method
                                          onPressed: () async => _controller
                                              .updateCapturedImages(index),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            (_controller.files[index]
                                                            .lengthSync() /
                                                        (1024 * 1024))
                                                    .toStringAsFixed(2) +
                                                " MB".toString(),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                  // Image.file(
                                  //   _controller.files![index].path,
                                  //   fit: BoxFit.cover,
                                  // );
                                },
                                // child: Image.file(
                                //     _controller.file!)
                              ), // IMAGE SHOWING
                            )
                            // Text(_controller.capturedImage!.name,
                            //     style: textStyle14Normal),
                            ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _controller.selectedFilesList
                              .map(
                                (PlatformFile _file) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      Text(
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
                                          style: textStyle14Normal),
                                      IconButton(
                                        // padding: const EdgeInsets.only(left: 70),
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 30,
                                          color: Colors.red,
                                        ),

                                        // calling update is multiple checked method
                                        onPressed: () async => _controller
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
                              margin: const EdgeInsets.only(),
                              // calling capture image method
                              onPressed: () => _controller.captureImage(),
                              btnTextStyle:
                                  buttonTextStyle.copyWith(color: Colors.black),
                            ),
                          ),
                          horizontalSpace12,
                          Expanded(
                            child: PrimaryIconButton(
                              text: kChooseFile,
                              icon: Icons.attachment_outlined,
                              margin: const EdgeInsets.only(),
                              // calling choose files method
                              onPressed: () => _controller.chooseFiles(context),
                              btnTextStyle:
                                  buttonTextStyle.copyWith(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace18,
                      Row(
                        children: [
                          // const Expanded(
                          //     child: Text(kRemarks, style: textStyle14Bold)),
                          // horizontalSpace6,
                          Expanded(
                            flex: 3,
                            child: TextFormField(
                              minLines: 3,
                              maxLines: 5,
                              maxLength: 500,
                              autocorrect: false,
                              keyboardType: TextInputType.multiline,
                              controller: _controller.remarksController,
                              textCapitalization: TextCapitalization.sentences,
                              // validator: (_desc) => _desc!.isEmpty
                              //     ? kMsgDescriptionIsRequired
                              //     : null,
                              decoration: const InputDecoration(
                                  labelText: kRemarks,
                                  contentPadding: EdgeInsets.all(12)),
                            ),
                          ),
                        ],
                      ),
                      // verticalSpace24,
                      // Row(
                      //   children: [
                      //     const Expanded(
                      //         child: Text(kHospitals, style: textStyle14Bold)),
                      //     horizontalSpace6,
                      //     Expanded(
                      //       flex: 3,
                      //       child: DropdownSearch<String>(
                      //         maxHeight: 500,
                      //         showSearchBox: true,
                      //         showClearButton: true,
                      //         mode: Mode.BOTTOM_SHEET,
                      //         showAsSuffixIcons: true,
                      //         items: _controller.medicalstorelist,
                      //         label: kSelect,
                      //         dropdownSearchBaseStyle: textStyle13Normal,
                      //         // itemAsString: (DependantListModel? _area) =>
                      //         //     _area!.message,
                      //         // calling on area selected method
                      //         onChanged: (String? _medicalStore) => _controller
                      //             .onStoreSelected(store: _medicalStore),
                      //         emptyBuilder: (context, _searchString) =>
                      //             const Scaffold(body: NoRecordsFound()),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      verticalSpace12,
                      PrimaryButton(
                        text: kSubmit,
                        onPressed: () {
                          // _controller.addNewCall();
                          // if (_controller.formKey.currentState!.validate()) {
                          //   _controller.formKey.currentState!.save();
                          //
                          //   // calling add new call method
                          //   _controller.addNewCall();
                          // }
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
            // itemAsString: (DependantListModel? _area) =>
            //     _area!.message,
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
}
