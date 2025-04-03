// import 'package:flutter/material.dart';
// import 'package:gail_connect/core/controllers/useful_links_controllers/dispensary_history_details_controller.dart';
// import 'package:gail_connect/models/dispensary_history_details.dart';
// import 'package:gail_connect/ui/styles/text_styles.dart';
// import 'package:gail_connect/ui/widgets/dispensary_details_row_item.dart';
// import 'package:gail_connect/ui/widgets/fms_row_item.dart';
// import 'package:gail_connect/ui/widgets/primary_button.dart';
// import 'package:gail_connect/utils/shared_prefs.dart';
// import 'package:get/get.dart';
// import 'package:multiutillib/multiutillib_flutter.dart';
// import 'package:multiutillib/widgets/custom_app_bar.dart';

// import '../../../../utils/constants/app_constants.dart';

// class DispensaryDetailsHistory extends StatelessWidget {
//   const DispensaryDetailsHistory({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final SharedPrefs _sharedPrefs = SharedPrefs.to;
//     _sharedPrefs.reqNumber = Get.arguments[1].toString();
//     bool isRemarks = false;

//     return Scaffold(
//       appBar: CustomAppBar(
//           title: "Requisition No :  " + Get.arguments[1].toString()),
//       body: GetBuilder<DispensaryHistoryDetailsController>(
//         id: kDispensaryHistoryDetails,
//         init: DispensaryHistoryDetailsController(),
//         builder: (_controller) {
//           // final DispensaryHistoryDetailsModel _dispensaryData =
//           //     _controller.dispensaryHistoryDetailsList[_position];
//           return ListView(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(12),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Requisition Details",
//                       style: textStyle20Bold,
//                     ),
//                     verticalSpace12,
//                     DispensaryDetailsRowItem(
//                         icon: const Icon(
//                           Icons.person,
//                           color: Colors.black,
//                           size: 40,
//                         ),
//                         caption: "Employee No",
//                         desc: _controller.dispensaryhistoryEmpNo.toString()),
//                     DispensaryDetailsRowItem(
//                         icon: const Icon(
//                           Icons.supervised_user_circle_outlined,
//                           color: Colors.black,
//                           size: 40,
//                         ),
//                         caption: "Dependant",
//                         desc: _controller.dispensaryhistoryDependantName
//                             .toString()),
//                     DispensaryDetailsRowItem(
//                         icon: const Icon(
//                           Icons.home,
//                           color: Colors.black,
//                           size: 40,
//                         ),
//                         caption: "Address",
//                         desc: _controller.dispensaryhistoryAddress.toString()),
//                     DispensaryDetailsRowItem(
//                         icon: const Icon(
//                           Icons.pin_drop,
//                           color: Colors.black,
//                           size: 40,
//                         ),
//                         caption: "Pincode",
//                         desc: _controller.dispensaryhistoryPin.toString()),
//                     DispensaryDetailsRowItem(
//                         icon: const Icon(
//                           Icons.phone,
//                           color: Colors.black,
//                           size: 40,
//                         ),
//                         caption: "Mobile Number",
//                         desc: _controller.dispensaryhistoryMobileNo.toString()),
//                     // HeadingRowItem(
//                     //     caption: "Attachment", desc: Get.arguments[1].toString()),
//                     // HeadingRowItem(
//                     //     caption: "Creation Date",
//                     //     desc: Get.arguments[1].toString()),
//                     // HeadingRowItem(
//                     //     caption: "Store", desc: Get.arguments[1].toString()),
//                     // HeadingRowItem(
//                     //     caption: "Pharmacy Document",
//                     //     desc: Get.arguments[1].toString()),
//                     // HeadingRowItem(
//                     //     caption: "Pharmacy Upload",
//                     //     desc: Get.arguments[1].toString()),
//                     // HeadingRowItem(
//                     //     caption: "Delivery Mode",
//                     //     desc: Get.arguments[1].toString()),
//                     // HeadingRowItem(
//                     //     caption: "Pharmacy Store",
//                     //     desc: Get.arguments[1].toString()),

//                     // HeadingRowItem(
//                     //     caption: "Remarks", desc: Get.arguments[1].toString()),
//                     // HeadingRowItem(
//                     //     caption: "Is Sent to Pharmacy",
//                     //     desc: Get.arguments[1].toString()),
//                     // HeadingRowItem(
//                     //     caption: "Sent to Pharmacy On",
//                     //     desc: Get.arguments[1].toString()),
//                     DispensaryDetailsRowItem(
//                         icon: const Icon(
//                           Icons.numbers,
//                           color: Colors.black,
//                           size: 40,
//                         ),
//                         caption: "Apollo Order No",
//                         desc: _controller.dispensaryhistoryApolloOrderNo
//                             .toString()),
//                     DispensaryDetailsRowItem(
//                         icon: const Icon(
//                           Icons.inventory_outlined,
//                           color: Colors.black,
//                           size: 40,
//                         ),
//                         caption: "Invoice No",
//                         desc:
//                             _controller.dispensaryhistoryInvoiceNo.toString() ==
//                                     "null"
//                                 ? ""
//                                 : _controller.dispensaryhistoryInvoiceNo
//                                     .toString()),
//                     DispensaryDetailsRowItem(
//                         icon: const Icon(
//                           Icons.currency_rupee_outlined,
//                           color: Colors.black,
//                           size: 40,
//                         ),
//                         caption: "Invoice Amount",
//                         desc: _controller.dispensaryhistoryInvoiceAmt
//                                     .toString() ==
//                                 "null"
//                             ? ""
//                             : _controller.dispensaryhistoryInvoiceAmt
//                                 .toString()),
//                     // Spacer(),
//                     verticalSpace24,
//                     Visibility(
//                       visible:
//                           _controller.dispensaryhistoryInvoiceNo.toString() ==
//                               "null",
//                       child: Container(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           children: [
//                             TextFormField(
//                               // initialValue:
//                               minLines: 2,
//                               maxLines: 4,

//                               maxLength: 200,
//                               autocorrect: false,
//                               keyboardType: TextInputType.multiline,
//                               // controller: _controller
//                               //     .pincodeController, //TextEditingController(text: 'Initial value'),//
//                               textCapitalization: TextCapitalization.sentences,
//                               validator: (_desc) => _desc!.length != 200
//                                   ? kMsgPincodeIsRequired
//                                   : null,
//                               decoration: const InputDecoration(
//                                   labelText: "Remarks",
//                                   contentPadding: EdgeInsets.all(12)),
//                             ),
//                             // verticalSpace12,
//                             PrimaryButton(
//                               text: "Cancel Order",
//                               onPressed: () => {},
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     verticalSpace24
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/useful_links_controllers/dispensary_history_details_controller.dart';

import 'package:gail_connect/ui/styles/color_controller.dart';

import 'package:get/get.dart';
import 'package:multiutillib/multiutillib_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../../core/controllers/main_dash_controller.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../styles/text_styles.dart';
import '../../pdfviewer.dart';

class DispensaryDetailsHistory extends StatelessWidget {


  final String reqNo;

  const DispensaryDetailsHistory({Key? key, required this.reqNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    DispensaryHistoryDetailsController().reqNodis = reqNo.toString();
    final DispensaryHistoryDetailsController reqController =
        Get.put(DispensaryHistoryDetailsController());
    reqController.reqNodis = reqNo;
    bool isRemarks = false;
    ColorController colorController = Get.put(ColorController());

    return Scaffold(
      backgroundColor: colorController.kHomeBgColor,
      appBar: AppBar(
        title: Text(
          "Requisition No. " + reqNo,
        ),
        backgroundColor: colorController.kPrimaryColor,
      ),
      // appBar: CustomAppBar(title: "Requisition No. " + reqNo),
      body: GetBuilder<DispensaryHistoryDetailsController>(
        id: kDispensaryHistoryDetails,
        init: DispensaryHistoryDetailsController(),
        builder: (_controller) {
          // final DispensaryHistoryDetailsModel _dispensaryData =
          //     _controller.dispensaryHistoryDetailsList[_position];
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0, top: 10),
                          child: Text('$kUser:', style: textStyle18Bold),
                        ),
                        horizontalSpace6,
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, top: 10),
                          child: Text(
                              MainDashController.to.loggedInEmployee!.empName!,
                              style: textStyle18Bold),
                        )),
                      ],
                    ),
                    verticalSpace18,

                    verticalSpace18,
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5),
                      child: TextFormField(
                        minLines: 1,
                        // maxLength: 10,
                        enabled: false,
                        autocorrect: false,
                        keyboardType: TextInputType.text,
                        controller: _controller.patientName,
                        textCapitalization: TextCapitalization.sentences,
                        // initialValue: "hello",
                        style:
                        TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                            labelText: "Patient Name",
                            contentPadding: EdgeInsets.all(12)),
                      ),
                    ),
                    verticalSpace18,
                    Row(
                      children: [
                        // const Expanded(
                        //     child: Text(kMobile, style: textStyle14Bold)),
                        // horizontalSpace6,
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 5),
                            child: TextFormField(
                              minLines: 1,
                              enabled: false,
                              // maxLength: 10,
                              autocorrect: false,
                              // keyboardType: TextInputType.phone,
                              controller: _controller.pharmacy,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (_desc) => _desc!.length != 10
                                  ? kMsgMobileIsRequired
                                  : null,
                              // initialValue: "hello",
                              style:
                              TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                  labelText: kPharmacy,
                                  contentPadding: EdgeInsets.all(12)),
                            ),
                          ),
                        ),
                        horizontalSpace12,
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: TextFormField(
                              // initialValue:
                              enabled: false,
                              minLines: 1,
                              // maxLength: 6,
                              autocorrect: false,
                              // keyboardType: TextInputType.number,
                              controller: _controller
                                  .delivery, //TextEditingController(text: 'Initial value'),//
                              textCapitalization: TextCapitalization.sentences,
                              validator: (_desc) => _desc!.length != 6
                                  ? kMsgPincodeIsRequired
                                  : null,
                              style:
                              TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                  labelText: kModeOfDelivery,
                                  contentPadding: EdgeInsets.all(12)),
                            ),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5),
                      child: TextFormField(
                        minLines: 3,
                        enabled: false,
                        maxLines: 5,
                        maxLength: 500,
                        autocorrect: false,
                        keyboardType: TextInputType.multiline,
                        controller: _controller.address,
                        textCapitalization: TextCapitalization.sentences,
                        validator: (_desc) =>
                            _desc!.isEmpty ? kMsgDescriptionIsRequired : null,
                        style:
                        TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                            labelText: kDeliveryAddress,
                            contentPadding: EdgeInsets.all(12)),
                      ),
                    ),
                    verticalSpace18,
                    Row(
                      children: [
                        // const Expanded(
                        //     child: Text(kMobile, style: textStyle14Bold)),
                        // horizontalSpace6,
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 5),
                            child: TextFormField(
                              minLines: 1,
                              enabled: false,
                              // maxLength: 10,
                              autocorrect: false,
                              keyboardType: TextInputType.phone,
                              controller: _controller.mobile,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (_desc) => _desc!.length != 10
                                  ? kMsgMobileIsRequired
                                  : null,
                              // initialValue: "hello",
                              style:
                              TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                  labelText: kMobile,
                                  contentPadding: EdgeInsets.all(12)),
                            ),
                          ),
                        ),
                        horizontalSpace12,
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: TextFormField(
                              // initialValue:
                              enabled: false,
                              minLines: 1,
                              // maxLength: 6,
                              autocorrect: false,
                              keyboardType: TextInputType.number,
                              controller: _controller
                                  .pincode, //TextEditingController(text: 'Initial value'),//
                              textCapitalization: TextCapitalization.sentences,
                              validator: (_desc) => _desc!.length != 6
                                  ? kMsgPincodeIsRequired
                                  : null,
                              style:
                              TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                  labelText: kPincode,
                                  contentPadding: EdgeInsets.all(12)),
                            ),
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
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(kPrescription, style: textStyle14Bold),
                    ),
                    _controller.dispensaryHistoryDetailsList1.length == null
                        ? Container()
                        : ListView.builder(
                            shrinkWrap: true,
                            // scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            // itemCount: 5,
                            itemCount: _controller
                                .dispensaryHistoryDetailsList1.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        String newsLink1 = _controller
                                            .dispensaryHistoryDetailsList1[
                                                index]
                                            .url
                                            .toString()
                                            .replaceAll(RegExp(' +'), '%20');

                                        // Get.to(PdfViewer(
                                        //   pdfurl: 'https://gailebank.gail.co.in/GAIL_APIs/CallImages/' +
                                        //       newsLink1,
                                        //   title: 'Apollo Medicine',
                                        //   type: "sugamUrl",
                                        // ));

                                        await launch(
                                            'https://gailebank.gail.co.in/GAIL_APIs/CallImages/' +
                                                newsLink1);
                                        // await launch(
                                        //     'https://gailebank.gail.co.in/common_api/CallImages/' +
                                        //         _controller
                                        //             .dispensaryHistoryDetailsList1[
                                        //                 index]
                                        //             .url
                                        //             .toString());
                                        // await launchUrl(_url)
                                      },
                                      child: const Icon(
                                        Icons.image_sharp,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                    // _controller.delivery
                    verticalSpace12,
                    /* */ /*if (_controller.files.isNotEmpty &&
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
                      const Text('$kSelectedFiles:', style: textStyle14Bold),
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
                      const Text('$kSelectedFiles:', style: textStyle14Bold),
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
                      ),*/ /*
                      // Column(
                      //   mainAxisSize: MainAxisSize.min,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: _controller.selectedFilesList
                      //       .map(
                      //         (PlatformFile _file) => Padding(
                      //       padding: const EdgeInsets.only(bottom: 12),
                      //       child: Row(
                      //         children: [
                      //           Text(
                      //               _file.name +
                      //                   " (" +
                      //                   (_file.size / (1024 * 1024)
                      //                       // (pow(
                      //                       //     1024,
                      //                       //     (log(_file.size) /
                      //                       //             log(1024))
                      //                       //         .floor()))
                      //                   )
                      //                       .toStringAsFixed(3) +
                      //                   " MB)",
                      //               style: textStyle14Normal),
                      //           IconButton(
                      //             // padding: const EdgeInsets.only(left: 70),
                      //             icon: const Icon(
                      //               Icons.delete,
                      //               size: 30,
                      //               color: Colors.red,
                      //             ),
                      //
                      //             // calling update is multiple checked method
                      //             onPressed: () async => _controller
                      //                 .updateSelectedFilesList(_file),
                      //           ),
                      //         ],
                      //       ),
                      //       // child: Container(
                      //       //   width: MediaQuery.of(context).size.width,
                      //       //   height:
                      //       //       MediaQuery.of(context).size.height * 0.2,
                      //       //   child: Image.file(_controller.file!),
                      //       // ),
                      //     ),
                      //   )
                      //       .toList(),
                      // ),
                    ],*/
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: PrimaryIconButton(
                    //         text: kCapture,
                    //         icon: Icons.camera,
                    //         margin: const EdgeInsets.only(),
                    //         // calling capture image method
                    //         onPressed: () => _controller.captureImage(),
                    //         btnTextStyle:
                    //         buttonTextStyle.copyWith(color: Colors.black),
                    //       ),
                    //     ),
                    //     horizontalSpace12,
                    //     Expanded(
                    //       child: PrimaryIconButton(
                    //         text: kChooseFile,
                    //         icon: Icons.attachment_outlined,
                    //         margin: const EdgeInsets.only(),
                    //         // calling choose files method
                    //         onPressed: () => _controller.chooseFiles(),
                    //         btnTextStyle:
                    //         buttonTextStyle.copyWith(color: Colors.black),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // verticalSpace18,
                    // verticalSpace6,
                    Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 15),
                      child: Text(kVendorRemarks, style: textStyle14Bold),
                    ),
                    verticalSpace6,
                    Row(
                      children: [
                        // const Expanded(
                        //     child: Text(kRemarks, style: textStyle14Bold)),
                        // horizontalSpace6,
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 5),
                            child: Container(
                              child: TextFormField(
                                minLines: 3,
                                enabled: false,
                                maxLines: 50,
                                maxLength: 500,
                                autocorrect: false,
                                keyboardType: TextInputType.multiline,
                                controller: _controller.remarks,
                                textCapitalization: TextCapitalization.sentences,
                                // validator: (_desc) => _desc!.isEmpty
                                //     ? kMsgDescriptionIsRequired
                                //     : null,
                                style:
                                TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                    labelText: kRemarks,
                                    contentPadding: EdgeInsets.all(12)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // verticalSpace6,
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 8.0),
                    //   child: const Text(kVendorRemarks, style: textStyle14Bold),
                    // ),
                    // Padding(padding: EdgeInsets.only(left: 8.0,right: 8.0,top: 15),
                    // child: TextFormField(
                    //   // initialValue:
                    //   enabled: false,
                    //   minLines: 1,
                    //   // maxLength: 6,
                    //   autocorrect: false,
                    //   // keyboardType: TextInputType.number,
                    //   controller: _controller
                    //       .remarks, //TextEditingController(text: 'Initial value'),//
                    //   textCapitalization: TextCapitalization.sentences,
                    //   validator: (_desc) => _desc!.length != 6
                    //       ? kMsgPincodeIsRequired
                    //       : null,
                    //   decoration: const InputDecoration(
                    //       labelText: kRemarks,
                    //       contentPadding: EdgeInsets.all(12)),
                    // ),
                    // )
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
                    // verticalSpace12,
                    // PrimaryButton(
                    //   text: kSubmit,
                    //   onPressed: () {
                    //     // _controller.addNewCall();
                    //     if (_controller.formKey.currentState!.validate()) {
                    //       _controller.formKey.currentState!.save();
                    //
                    //       // calling add new call method
                    //       _controller.addNewCall();
                    //     }
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
