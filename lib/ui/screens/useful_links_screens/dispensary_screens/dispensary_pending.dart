import 'package:flutter/material.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/core/controllers/useful_links_controllers/dispensary_add_call_controller.dart';
import 'package:gail_connect/models/dispensary_history.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/fms_row_item.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:multiutillib/multiutillib_flutter.dart';

class DispensaryPending extends StatelessWidget {
  const DispensaryPending({Key? key}) : super(key: key);

//   Widget _listItemBuilder(BuildContext context, int index){
// return Text("data");
//   }

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      appBar: CustomAppBar(title: kDispensary),
      // bottomNavigationBar: BottomNavyBar(
      //   items: <BottomNavyBarItem>[
      //     BottomNavyBarItem(
      //       icon: const Icon(Feather.plus_circle),
      //       title: const Text(
      //         'Requisition',
      //         textAlign: TextAlign.center,
      //       ),
      //       activeColor: const Color.fromARGB(255, 234, 234, 234),
      //     ),
      //     BottomNavyBarItem(
      //       icon: const Icon(Icons.assignment),
      //       title: const Text(
      //         'Pending',
      //         textAlign: TextAlign.center,
      //       ),
      //       activeColor: const Color.fromARGB(255, 227, 227, 227),
      //     ),
      //     BottomNavyBarItem(
      //       icon: const Icon(Icons.assignment),
      //       title: const Text(
      //         'History',
      //         textAlign: TextAlign.center,
      //       ),
      //       activeColor: const Color.fromARGB(255, 227, 227, 227),
      //     ),
      //   ],
      //   onItemSelected: (int index){
      //     int currentIndex = index;
      //     // update([kDispensaryDash]);
      //   },
      //   selectedIndex: 1,
      //   containerHeight: 65,
      //   backgroundColor: colorController.kPrimaryColor,
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      // ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: colorController.kPrimaryDarkColor,
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
              // MaterialCard(
              //   borderRadius: 12,
              //   margin: const EdgeInsets.only(top: 6, left: 12, right: 12),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       // TextField(
              //       //   autocorrect: false,
              //       //   controller: _controller.searchController,
              //       //   keyboardType: TextInputType.visiblePassword,
              //       //   // calling on user calls search method
              //       //   // onChanged: _controller.onUserCallsSearch,
              //       //   decoration: InputDecoration(
              //       //     hintText: kEnterCallIdDescription,
              //       //     prefixIcon: const Icon(Icons.search),
              //       //     suffixIcon: IconButton(
              //       //       color: kBlackShadeColor,
              //       //       icon: const Icon(Icons.clear, color: Colors.black54),
              //       //       onPressed: () {
              //       //         _controller.searchController.text = '';

              //       //         // calling on user calls search method
              //       //         // _controller.onUserCallsSearch('');
              //       //       },
              //       //     ),
              //       //   ),
              //       // ),
              //       verticalSpace12,
              //       // Row(
              //       //   children: [
              //       //     const Expanded(
              //       //         child: Text(kStatus, style: textStyle14Bold)),
              //       //     horizontalSpace12,
              //       //     Expanded(
              //       //       flex: 3,
              //       //       child: DropdownButtonFormField<String>(
              //       //         value: _controller.selectedCallStatus,
              //       //         // calling on user call status selected method
              //       //         onChanged: _controller.onUserCallStatusSelected,
              //       //         hint: Text(kStatus,
              //       //             style: textStyle14Normal.copyWith(
              //       //                 color: Colors.grey)),
              //       //         items: const [kAll, kOpen, kClose]
              //       //             .map<DropdownMenuItem<String>>(
              //       //                 (String _value) => DropdownMenuItem<String>(
              //       //                     value: _value,
              //       //                     child: Text(_value,
              //       //                         style: textStyle14Normal)))
              //       //             .toList(),
              //       //       ),
              //       //     ),
              //       //   ],
              //       // ),
              //     ],
              //   ),
              // ),
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
                                            caption: "Req No", //kCallId,
                                            textAlign: TextAlign.center,
                                            description: _dispensaryData.sno
                                                    .toString()
                                                    .isEmpty
                                                ? ""
                                                : _dispensaryData.sno!,
                                            // .toStringAsFixed(0),
                                            captionStyle: textStyle18Bold
                                                .copyWith(color: _callIdColor),
                                            descriptionStyle: textStyle18Bold
                                                .copyWith(color: _callIdColor),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Row(
                                          children: [
                                            _dispensaryData.status == null
                                                ? Text("")
                                                : Text(_dispensaryData.status
                                                    .toString()),
                                            Icon(Icons.circle,
                                                color: _dispensaryData
                                                            .acknowledgebyuser
                                                            .toString() ==
                                                        "1"
                                                    ? (_dispensaryData.status
                                                                .toString() ==
                                                            "Cancelled"
                                                        ? colorController
                                                            .kPrimaryColor
                                                        : colorController
                                                            .kPrimaryColor)
                                                    : (_dispensaryData
                                                                .acknowledgebyuser
                                                                .toString() ==
                                                            "0"
                                                        ? colorController
                                                            .kPrimaryColor
                                                        : colorController
                                                            .kPrimaryColor))
                                          ],
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
                                      ? Text("")
                                      : Padding(
                                          padding: EdgeInsets.all(0),
                                          child: Column(
                                            children: [
                                              const Divider(
                                                  height: 1,
                                                  color: Colors.black),
                                              verticalSpace6,
                                              Padding(
                                                padding: EdgeInsets.all(5),
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
                                                            : "Bill No. : " +
                                                                _dispensaryData
                                                                    .invoiceno
                                                                    .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                    ),

                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        _dispensaryData
                                                                .invoicedetails!
                                                                .isEmpty
                                                            ? "null"
                                                            : "Amount: " +
                                                                _dispensaryData
                                                                    .invoicedetails!,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12),
                                                      ),
                                                    ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0, left: 10),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: SizedBox(
                                            child: ElevatedButton(
                                              clipBehavior: Clip.antiAlias,
                                              onPressed: () => {
                                                Get.toNamed(
                                                    kDispensaryHistoryDetailsRoute,
                                                    arguments: [
                                                      "req",
                                                      _dispensaryData.sno!,
                                                      // toStringAsFixed(0)
                                                    ]),
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))), backgroundColor: colorController
                                                    .kPrimaryDarkColor,
                                                elevation: 5,
                                                visualDensity: VisualDensity
                                                    .adaptivePlatformDensity,
                                              ),
                                              child: Text("View",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    letterSpacing: 0.55,
                                                    fontWeight: FontWeight.w600,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: ElevatedButton(
                                            clipBehavior: Clip.antiAlias,
                                            onPressed: () => {
                                              if (_dispensaryData.status
                                                          .toString() ==
                                                      "Processed" ||
                                                  _dispensaryData.status
                                                          .toString() ==
                                                      "Received" ||
                                                  _dispensaryData.status
                                                          .toString() ==
                                                      "Processing")
                                                {
                                                  _showInfoDialogCancel(
                                                      context,
                                                      _controller,
                                                      _dispensaryData.sno!),
                                                }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))), backgroundColor: _dispensaryData.status
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
                                                  : colorController
                                                      .kDarkGreyColor,
                                              elevation: 5,
                                              visualDensity: VisualDensity
                                                  .adaptivePlatformDensity,
                                            ),
                                            child: Text("Cancel",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  letterSpacing: 0.55,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: ElevatedButton(
                                            clipBehavior: Clip.antiAlias,
                                            onPressed: () => {
                                              if (_dispensaryData.status
                                                      .toString() ==
                                                  "Delivered")
                                                {
                                                  _showInfoDialog(
                                                      context,
                                                      _controller,
                                                      _dispensaryData.sno!,
                                                      _dispensaryData
                                                          .acknowledgebyuser,
                                                      colorController),
                                                }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10))), backgroundColor: _dispensaryData.status
                                                          .toString() ==
                                                      "Delivered"
                                                  ? colorController
                                                      .kPrimaryDarkColor
                                                  : colorController
                                                      .kDarkGreyColor,
                                              elevation: 2,
                                              visualDensity: VisualDensity
                                                  .adaptivePlatformDensity,
                                            ),
                                            child: Text("Acknowledge",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  letterSpacing: 0.55,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                        ),
                                      )
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
      String? acknowledgebyuser,
      ColorController colorController) {
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
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Receipt Acknowledgement",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
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
                    padding: EdgeInsets.all(8),
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
                                controller.acknowledgeApiHit(sno, context),
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))), backgroundColor: colorController.kPrimaryDarkColor,
                                elevation: 5,
                                visualDensity:
                                    VisualDensity.adaptivePlatformDensity,
                              ),
                              child: Text("Submit",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    letterSpacing: 0.55,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ),
                          ),
                        )
                      : Text(""),
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
                  Text("Confirmation"),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
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
          content: Text("Would you like to Cancel this Order?"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                controller.pharmacyRequestCancel(SNO, context);
              },
            ),
          ],
        );
      },
    );
  }
}
