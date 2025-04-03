import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/health_controller.dart';
import 'package:gail_connect/models/ohc_screen_model.dart';
import 'package:gail_connect/ui/widgets/primary_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';

import '../../../utils/constants/app_constants.dart';
import '../../styles/color_controller.dart';
import '../../styles/text_styles.dart';

class OHCScreen extends StatefulWidget {
  const OHCScreen({Key? key}) : super(key: key);

  // const OHCScreen({Key? key}) : (super.key);

  @override
  State<OHCScreen> createState() => _OHCScreenState();
}

class _OHCScreenState extends State<OHCScreen> {
  TextEditingController dateinput = TextEditingController();
  String? dropdownValue;
  late String formattedDate;
  List<String> listItem = ['sfd', 'fghjk' 'dfghjkl', 'dfghjk', 'ertyui'];

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("USA"), value: "USA"),
      DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      DropdownMenuItem(child: Text("England"), value: "England"),
    ];
    return menuItems;
  }

  String? roletype = '';
  List<String> role = [
    'Permit Receiver',
    'Permit Issuer',
    'F&S Authorization',
    'CGD In-Charge'
  ];

  //text editing controller for text field

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorController colorController = Get.put(ColorController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorController.kHomeBgColor,
        body: GetBuilder<HealthController>(
          id: kHealth,
          init: HealthController(),
          builder: (_controller) {
            return SingleChildScrollView(
              padding:
                  const EdgeInsets.only(top: 18, left: 2, right: 2, bottom: 8),
              child: Form(
                key: _controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            _controller.changeVisibility();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorController.kPrimaryDarkColor,
                          ),
                          child: Text(
                            "ADD",
                            style: TextStyle(
                                color: colorController.kCircleBgColor),
                          )),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8.0, right: 8.0, top: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownSearch<OHCMODEL>(
                              // maxHeight: 500,
                              // showSearchBox: true,
                              // showClearButton: true,
                              // mode: Mode.BOTTOM_SHEET,
                              // showAsSuffixIcons: true,
                              items: _controller.ohcmodellist,
                              // hint: kSelectProposedTypeOfCall,
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    labelText: 'View',
                                    hintText: 'View',
                                    labelStyle: TextStyle(color: Colors.black)),
                              ),
                              // dropdownSearchBaseStyle: textStyle13Normal,
                              itemAsString: (OHCMODEL? _type) =>
                                  _type!.LAST_OHC_DATE,
                              // calling on types selected method
                              onChanged: (OHCMODEL? _types) =>
                                  _controller.onTypesSelected(_types),
                              // emptyBuilder: (context, _searchString) =>
                              //     const Scaffold(body: NoRecordsFound()),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // Spacer(),
                          Expanded(
                            child: DropdownSearch<OHCMODEL>(
                              // maxHeight: 500,
                              // showSearchBox: true,
                              // showClearButton: true,
                              // mode: Mode.BOTTOM_SHEET,
                              // showAsSuffixIcons: true,
                              items: _controller.ohcmodellist,
                              // hint: kSelectProposedTypeOfCall,
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                    labelText: 'Update',
                                    hintText: 'Update',
                                    labelStyle: TextStyle(color: Colors.black)),
                              ),
                              // dropdownSearchBaseStyle: textStyle13Normal,
                              itemAsString: (OHCMODEL? _type) =>
                                  _type!.LAST_OHC_DATE,
                              // calling on types selected method
                              onChanged: (OHCMODEL? _types) =>
                                  _controller.onUpdate(_types),
                              // emptyBuilder: (context, _searchString) =>
                              //     const Scaffold(body: NoRecordsFound()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpace12,
                    Visibility(
                      visible: _controller.formvisible,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(OHCDate, style: textStyle14Bold)),
                              horizontalSpace6,
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  controller: dateinput,
                                  //editing controller of this TextField

                                  decoration: const InputDecoration(
                                      labelText: OHCDate,
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      contentPadding: EdgeInsets.all(12)),
                                  readOnly: true,
                                  //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime.now(),
                                        builder: (BuildContext? context,
                                            Widget? child) {
                                          return Theme(
                                            data: ThemeData.light().copyWith(
                                              colorScheme:
                                                  ColorScheme.fromSwatch(
                                                primarySwatch: Colors.grey,
                                                accentColor: Colors.grey,
                                              ),
                                              dialogBackgroundColor:
                                                  Colors.white,
                                            ),
                                            child: child!,
                                          );
                                        });

                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                      formattedDate = DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                      String formattedDate1 =
                                          DateFormat('dd/MM/yyyy')
                                              .format(pickedDate);
                                      print(
                                          formattedDate); //formatted date output using intl package =>  2021-03-16
                                      //you can implement different kind of Date Format here according to your requirement

                                      setState(() {
                                        dateinput.text =
                                            formattedDate1; //set output date to TextField value.
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          verticalSpace12,
                          Row(
                            children: [
                              Expanded(
                                  child: Text(khospitalname,
                                      style: textStyle14Bold)),
                              horizontalSpace6,
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  autocorrect: false,
                                  keyboardType: TextInputType.text,
                                  controller:
                                      _controller.hospitalNameController,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  validator: (_desc) => _desc!.isEmpty
                                      ? kMsgDescriptionIsRequired
                                      : null,
                                  decoration: const InputDecoration(
                                      labelText: khospitalname,
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      contentPadding: EdgeInsets.all(12)),
                                ),
                              ),
                            ],
                          ),
                          verticalSpace12,
                          Row(
                            children: [
                              Expanded(
                                  child: Text(khospitaladdress,
                                      style: textStyle14Bold)),
                              horizontalSpace6,
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  autocorrect: false,
                                  keyboardType: TextInputType.text,
                                  controller:
                                      _controller.hospitalAddressController,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  validator: (_desc) => _desc!.isEmpty
                                      ? kMsgDescriptionIsRequired
                                      : null,
                                  decoration: const InputDecoration(
                                      labelText: khospitaladdress,
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      contentPadding: EdgeInsets.all(12)),
                                ),
                              ),
                            ],
                          ),
                          verticalSpace12,
                          Row(
                            children: [
                              Expanded(
                                  child: Text(kmeasurements,
                                      style: textStyle14Bold)),
                              horizontalSpace6,
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  minLines: 3,
                                  maxLines: 5,
                                  autocorrect: false,
                                  keyboardType: TextInputType.text,
                                  controller: _controller
                                      .hospitalmeasurementsController,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  validator: (_desc) => _desc!.isEmpty
                                      ? kMsgDescriptionIsRequired
                                      : null,
                                  decoration: const InputDecoration(
                                      labelText: kmeasurements,
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      contentPadding: EdgeInsets.all(12)),
                                ),
                              ),
                            ],
                          ),
                          verticalSpace6,
                          PrimaryButton(
                            text: kSubmit,
                            onPressed: () {
                              if (_controller.formKey.currentState!
                                  .validate()) {
                                _controller.formKey.currentState!.save();
                                _controller.saveOFCData(context, formattedDate);

                                // calling add new call method
                                // _controller.addNewCall();
                              }
                            },
                          ),
                          verticalSpace6,
                        ],
                      ),
                    ),
                    verticalSpace12,
                    Visibility(
                      visible: _controller.viewFrom,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: MaterialCard(
                          borderRadius: 12,
                          shadowColor: Colors.black38,
                          color: colorController.kBgColor,
                          padding: const EdgeInsets.only(),
                          margin: const EdgeInsets.only(bottom: 12),
                          // onTap: () => _controller.onUserCallSelected(
                          //     userCall: _dispensaryData),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Text("dsfghjkl")
                                Row(
                                  children: [
                                    Text(
                                      OHCDate,
                                      style: textStyle14Bold,
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          _controller.ohcmodel == null
                                              ? ""
                                              : _controller
                                                  .ohcmodel!.LAST_OHC_DATE
                                                  .toString(),
                                          style: textStyle12Normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(height: 1, color: Colors.black),
                                verticalSpace6,
                                Row(
                                  children: [
                                    Text(
                                      khospitalname,
                                      style: textStyle14Bold,
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          _controller.ohcmodel == null
                                              ? ""
                                              : _controller
                                                  .ohcmodel!.HOSPITAL_NAME
                                                  .toString(),
                                          style: textStyle12Normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(height: 1, color: Colors.black),
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
                                Row(
                                  children: [
                                    Text(
                                      khospitaladdress,
                                      style: textStyle14Bold,
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 14),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          _controller.ohcmodel == null
                                              ? ""
                                              : _controller
                                                  .ohcmodel!.HOSPITAL_ADD
                                                  .toString(),
                                          style: textStyle12Normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(height: 1, color: Colors.black),
                                verticalSpace12,
                                Row(
                                  children: [
                                    Text(
                                      kmeasurements,
                                      style: textStyle14Bold,
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          _controller.ohcmodel == null
                                              ? ""
                                              : _controller
                                                  .ohcmodel!.MEASUREMENTS
                                                  .toString(),
                                          style: textStyle12Normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                /*   const Divider(height: 1, color: Colors.black),
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

                                },
                                btnColor:
                                colorController.kPrimaryDarkColor,
                              ),
                              const Spacer(),
                              ElevatedButtonPending(
                                status: "",
                                cancelstatus: "",
                                ackno: "",
                                text: 'Update',
                                onPressed: () {

                                },
                                btnColor:
                                colorController.kPrimaryDarkColor,
                              ),







                            ],
                          )*/
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    verticalSpace12,
                    Visibility(
                      visible: _controller.updateForm,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(OHCDate, style: textStyle14Bold)),
                              horizontalSpace6,
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  controller: _controller.dateinputupdate,
                                  //editing controller of this TextField

                                  decoration: const InputDecoration(
                                      labelText: OHCDate,
                                      labelStyle: TextStyle(color: Colors.grey),
                                      contentPadding: EdgeInsets.all(12)),

                                  readOnly: true,
                                  //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    // DateTime? pickedDate = await showDatePicker(
                                    //     context: context, initialDate: DateTime.now(),
                                    //     firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                    //     lastDate: DateTime(2101)
                                    // );
                                    //
                                    // if(pickedDate != null ){
                                    //   print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                    //   String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                    //   print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //   //you can implement different kind of Date Format here according to your requirement
                                    //
                                    //   setState(() {
                                    //     // dateinput.text = formattedDate; //set output date to TextField value.
                                    //   });
                                    // }else{
                                    //   print("Date is not selected");
                                    // }
                                  },
                                ),
                              ),
                            ],
                          ),
                          verticalSpace12,
                          Row(
                            children: [
                              Expanded(
                                  child: Text(khospitalname,
                                      style: textStyle14Bold)),
                              horizontalSpace6,
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  autocorrect: false,
                                  keyboardType: TextInputType.text,
                                  controller:
                                      _controller.hospitalNameControllerU,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  validator: (_desc) => _desc!.isEmpty
                                      ? kMsgDescriptionIsRequired
                                      : null,
                                  decoration: const InputDecoration(
                                      labelText: khospitalname,
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      contentPadding: EdgeInsets.all(12)),
                                ),
                              ),
                            ],
                          ),
                          verticalSpace12,
                          Row(
                            children: [
                              Expanded(
                                  child: Text(khospitaladdress,
                                      style: textStyle14Bold)),
                              horizontalSpace6,
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  autocorrect: false,
                                  keyboardType: TextInputType.text,
                                  controller:
                                      _controller.hospitalAddressControllerU,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  validator: (_desc) => _desc!.isEmpty
                                      ? kMsgDescriptionIsRequired
                                      : null,
                                  decoration: const InputDecoration(
                                      labelText: khospitaladdress,
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      contentPadding: EdgeInsets.all(12)),
                                ),
                              ),
                            ],
                          ),
                          verticalSpace12,
                          Row(
                            children: [
                              Expanded(
                                  child: Text(kmeasurements,
                                      style: textStyle14Bold)),
                              horizontalSpace6,
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  minLines: 3,
                                  maxLines: 5,
                                  autocorrect: false,
                                  keyboardType: TextInputType.text,
                                  controller: _controller
                                      .hospitalmeasurementsControllerU,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  validator: (_desc) => _desc!.isEmpty
                                      ? kMsgDescriptionIsRequired
                                      : null,
                                  decoration: const InputDecoration(
                                      labelText: kmeasurements,
                                      labelStyle:
                                          TextStyle(color: Colors.black),
                                      contentPadding: EdgeInsets.all(12)),
                                ),
                              ),
                            ],
                          ),
                          verticalSpace6,
                          PrimaryButton(
                            text: kUpdate,
                            onPressed: () {
                              if (_controller.formKey.currentState!
                                  .validate()) {
                                _controller.formKey.currentState!.save();
                                _controller.UpdateOFCData(
                                  context,
                                );

                                // calling add new call method
                                // _controller.addNewCall();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    /*         ListView.builder(
                      itemCount: _controller.ohcmodellist.length,
                      padding:
                      const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder:
                      // _listItemBuilder,
                          (context, index) {



                        // return GestureDetector(
                        //   onTap: () => Get.toNamed(kDispensaryHistoryDetailsRoute,
                        //       arguments: [
                        //         "req",
                        //         _dispensaryData.sno!.toStringAsFixed(0)
                        //       ]),
                        return  MaterialCard(
                          borderRadius: 12,
                          shadowColor: Colors.black38,
                          padding: const EdgeInsets.only(),
                          margin: const EdgeInsets.only(bottom: 12),
                          // onTap: () => _controller.onUserCallSelected(
                          //     userCall: _dispensaryData),
                          child: Padding(
                            padding: const EdgeInsets.only(left:5.0,right: 5),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Text("dsfghjkl")
                                Row(
                                  children:  [
                                     const Text(OHCDate),
                                     const Spacer(),
                                    Padding(
                                      padding:  const EdgeInsets.symmetric(
                                          vertical: 14),
                                      child: Padding(
                                        padding:
                                         const EdgeInsets.only(left: 8.0),
                                        child: Text( _controller.ohcmodellist[index].LAST_OHC_DATE.toString()),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(height: 1, color: Colors.black),
                                verticalSpace6,
                                Row(
                                  children:  [
                                    const Text(khospitalname),
                                    const Spacer(),
                                    Padding(
                                      padding:  const EdgeInsets.symmetric(
                                          vertical: 14),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(left: 8.0),
                                        child: Text(_controller.ohcmodellist[index].HOSPITAL_NAME.toString()),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(height: 1, color: Colors.black),
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
                                const Row(
                                  children:  [
                                    Text(khospitaladdress),
                                    Spacer(),
                                    Padding(
                                      padding:  EdgeInsets.symmetric(
                                          vertical: 14),
                                      child: Padding(
                                        padding:
                                        EdgeInsets.only(left: 8.0),
                                        child: Text(khospitaladdress),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(height: 1, color: Colors.black),
                                verticalSpace12,
                                Row(
                                  children:  [
                                    const Text(kmeasurements),
                                    const Spacer(),
                                    Padding(
                                      padding:  const EdgeInsets.symmetric(
                                          vertical: 14),
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(left: 8.0),
                                        child: Text(_controller.ohcmodellist[index].HOSPITAL_ADD.toString()),
                                      ),
                                    ),
                                  ],
                                ),
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

                                      },
                                      btnColor:
                                      colorController.kPrimaryDarkColor,
                                    ),
                                    const Spacer(),
                                    ElevatedButtonPending(
                                      status: "",
                                      cancelstatus: "",
                                      ackno: "",
                                      text: 'Update',
                                      onPressed: () {

                                      },
                                      btnColor:
                                      colorController.kPrimaryDarkColor,
                                    ),







                                  ],
                                )
                              ],
                            ),
                          ),
                        );

                      },
                    ),*/
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onChanged(String? value) {}
}
