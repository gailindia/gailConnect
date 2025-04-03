// Created By Amit Jangid 01/09/21

import 'package:flutter/material.dart';
import 'package:gail_connect/models/consent_model.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/widgets/custom_dialogs/show_emp_dialog.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/utils/string_extension.dart';
import 'package:multiutillib/widgets/rich_text_widgets.dart';
import 'package:multiutillib/animations/slide_animation.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/ui/screens/full_image_screen.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/open_container_transition.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';
import 'package:gail_connect/ui/widgets/circular_network_image_widget.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_list_controllers/emp_list_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/super_annuation_model.dart';

class EmpListWidget extends StatelessWidget {
  final bool isEmpListScreen;
  final List<Employee> employeeList;
  List<SuperAnnuationModel> superannuationmodel;
  List<PhoneConsent> phoneConsent;
  final bool forBirthday, showVehicleNo;
  final double? imageWidth, imageHeight;
  final AnimationController animationController;
  final MainDashController _mainDashController = MainDashController.to;

  EmpListWidget({
    Key? key,
    this.imageWidth = 60,
    this.imageHeight = 60,
    this.forBirthday = false,
    this.showVehicleNo = false,
    this.isEmpListScreen = false,
    required this.employeeList,
    required this.superannuationmodel,
    required this.phoneConsent,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_final_locals
    // ColorController colorController = Get.put(ColorController());
    return employeeList.isNotEmpty
        ? GetBuilder<ColorController>(
            init: ColorController(),
            id: 'color',
            builder: (colorController) {
              return ListView.builder(
                itemCount: employeeList.length,
                padding: const EdgeInsets.only(bottom: 36),
                itemBuilder: (context, _position) {
                  final Employee _employee = employeeList[_position];
                  final int _itemCount =
                      employeeList.length > 15 ? 15 : employeeList.length;
                  // print("12345sdfg4567800000   ${_employee.image}    ${_employee.empNo}   " + phoneConsent.toString()  );

                  return SlideAnimation(
                    position: _position,
                    itemCount: _itemCount,
                    animationController: animationController,
                    child: MaterialCard(
                      borderRadius: 12,
                      margin: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 12),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 6),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // ignore: unrelated_type_equality_checks
                              // _employee.empNo!.contains(

                              // photowidget(
                              //     _employee, phoneConsent, employeeList.length),
                              // imagebool == false
                              //     ? const Icon(
                              //         Icons.supervised_user_circle_sharp)
                              //     :
                              OpenContainerTransition(
                                tappable: (_employee.image != null &&
                                    _employee.image!.isNotEmpty),
                                closedShape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(35))),
                                closedBuilder: (context, action) =>
                                    CircularNetworkImageWidget(
                                  imageWidth: 70,
                                  imageHeight: 70,
                                  imageUrl: _employee.image!,
                                ),
                                openBuilder: (context, action) {
                                  if (_employee.image != null &&
                                      _employee.image!.isNotEmpty) {
                                    return FullImageScreen(
                                        title: _employee.empName!,
                                        imageUrl: _employee.image!);
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),

                              horizontalSpace12,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  // ignore: sized_box_for_whitespace
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.5,
                                                    child: Text(
                                                        _employee.empName!
                                                            .toTitleCase(),
                                                        maxLines: 2,
                                                        style: GoogleFonts.poppins(
                                                            textStyle:
                                                                textStyle12Bold)),
                                                  ),
                                                  const Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showEmpDialog(context,
                                                          employee: _employee,
                                                          onNegativePressed:
                                                              () {},
                                                          onPositivePressed:
                                                              () {});
                                                    },
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            // ignore: avoid_redundant_argument_values
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "See More",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              textStyle:
                                                                  textStyle10blackweight,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 4.0,
                                                                    right: 6),
                                                            child: Image.asset(
                                                                'assets/icons/right_arrow.png'),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              verticalSpace3,
                                              Text(_employee.designation!,
                                                  style: GoogleFonts.poppins(
                                                      textStyle:
                                                          textStyle9Bold)),
                                              verticalSpace3,
                                              Text(
                                                  _employee.department!
                                                      .toUpperCase(),
                                                  style: GoogleFonts.poppins(
                                                      textStyle:
                                                          textStyle9Normal)),

                                              Text(
                                                  _employee.location!
                                                      .toUpperCase(),
                                                  style: GoogleFonts.poppins(
                                                      textStyle:
                                                          textStyle9Normal)),
                                              verticalSpace3,
                                              Text(
                                                  "HVJ: " +
                                                      _employee.hBJExt!
                                                          .toTitleCase(),
                                                  style: GoogleFonts.poppins(
                                                      textStyle:
                                                          textStyle9Normal)),
                                              verticalSpace3,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Visibility(
                                                    visible: _employee.telNo !=
                                                            null &&
                                                        _employee
                                                            .telNo!.isNotEmpty,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                        color: colorController
                                                            .kPrimaryDarkColor,
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    30)),
                                                      ),
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          String telephone =
                                                              _employee.telNo!;
                                                          final _callNo =
                                                              'tel:$telephone';

                                                          if (await canLaunch(
                                                              _callNo)) {
                                                            await launch(
                                                                _callNo);
                                                          }
                                                          // _guestHouseController
                                                          //     .callNumber(
                                                          //     _employee.telNo!);
                                                          // await launch(_guestHouse.telephone!);
                                                        },
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            const Icon(
                                                                Feather.phone,
                                                                size: 12),
                                                            // const SizedBox(width: 3),
                                                            horizontalSpace6,
                                                            Flexible(
                                                              child: Text(
                                                                _employee
                                                                    .telNo!,
                                                                style: textStyle10telNormal
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .white),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  if (_employee.telNo != null &&
                                                      _employee.telNo!
                                                          .isNotEmpty) ...[
                                                    verticalSpace6,
                                                    Row(
                                                      children: [
                                                        _SaveNumberIcon(
                                                            employee: _employee,
                                                            number: _employee
                                                                .telNo!),
                                                        // ],
                                                        const SizedBox(
                                                            width: 7),
                                                        if (isEmpListScreen) ...[
                                                          // const Spacer(),

                                                          Obx(() {
                                                            if (EmpListController
                                                                .to
                                                                .isMultipleChecked) {
                                                              return Checkbox(
                                                                value: _employee
                                                                    .isEmployeeSelected,
                                                                onChanged:
                                                                    (value) {
                                                                  // calling update is employee selected method
                                                                  EmpListController
                                                                      .to
                                                                      .updateIsEmployeeSelected(
                                                                          employee:
                                                                              _employee);
                                                                },
                                                              );
                                                            } else {
                                                              return _SendEmailIcon(
                                                                  email: _employee
                                                                      .emails!);
                                                            }
                                                          }),
                                                        ] else ...[
                                                          _SendEmailIcon(
                                                              email: _employee
                                                                  .emails!),
                                                        ],
                                                        // if (!forBirthday) ...[
                                                        const SizedBox(
                                                            width: 7),

                                                        // const Spacer(),
                                                        _SendMessageIcon(
                                                            number: _employee
                                                                .telNo!),
                                                        const SizedBox(
                                                            width: 7),
                                                      ],
                                                    ),
                                                  ],
                                                ],
                                              ),
                                              verticalSpace3,
                                              /*RichTextWidget(
                                          caption: ext_no,
                                          captionStyle: GoogleFonts.poppins(
                                              textStyle: textStyle9Normal),
                                          descriptionStyle: GoogleFonts.poppins(
                                              textStyle: textStyle9Normal),
                                          description:
                                          _employee.hBJExt!.isNotEmpty
                                              ? _employee.hBJExt!
                                              : '-',
                                        ),*/
                                              if (showVehicleNo) ...[
                                                verticalSpace6,
                                                RichTextWidget(
                                                  caption: kVehicleNo,
                                                  captionStyle: textStyle13Bold,
                                                  descriptionStyle:
                                                      textStyle13Normal,
                                                  description: _employee
                                                          .vehicleNo
                                                          ?.replaceNullWithEmpty ??
                                                      '-',
                                                ),
                                              ],
                                              // verticalSpace6,
                                              // RichTextWidget(
                                              //   caption: kCpfNo,
                                              //   description: _employee.empNo!,
                                              //   captionStyle: textStyle13Bold,
                                              //   descriptionStyle: textStyle13Normal,
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Column(
                              //   children: [
                              //     if (isEmpListScreen) ...[
                              //       // const Spacer(),
                              //       Obx(() {
                              //         if (EmpListController.to.isMultipleChecked) {
                              //           return Checkbox(
                              //             value: _employee.isEmployeeSelected,
                              //             onChanged: (value) {
                              //               // calling update is employee selected method
                              //               EmpListController.to
                              //                   .updateIsEmployeeSelected(
                              //                       employee: _employee);
                              //             },
                              //           );
                              //         } else {
                              //           return _SendEmailIcon(email: _employee.emails!);
                              //         }
                              //       }),
                              //     ] else ...[
                              //       _SendEmailIcon(email: _employee.emails!),
                              //     ],
                              //     _SaveNumberIcon(
                              //         employee: _employee, number: _employee.telNo!),
                              //     _SendMessageIcon(number: _employee.telNo!),
                              //   ],
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            })
        : ListView.builder(
            itemCount: superannuationmodel.length,
            padding: const EdgeInsets.only(bottom: 36),
            itemBuilder: (context, _position) {
              final SuperAnnuationModel _employee =
                  superannuationmodel[_position];
              final int _itemCount = superannuationmodel.length > 15
                  ? 15
                  : superannuationmodel.length;

              return SlideAnimation(
                position: _position,
                itemCount: _itemCount,
                animationController: animationController,
                child: MaterialCard(
                  borderRadius: 12,
                  margin:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          OpenContainerTransition(
                            tappable: (_employee.userphoto != null &&
                                _employee.userphoto.isNotEmpty),
                            closedShape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(35))),
                            closedBuilder: (context, action) =>
                                CircularNetworkImageWidget(
                              imageWidth: 70,
                              imageHeight: 70,
                              imageUrl: _employee.userphoto,
                            ),
                            openBuilder: (context, action) {
                              if (_employee.userphoto != null &&
                                  _employee.userphoto.isNotEmpty) {
                                return FullImageScreen(
                                    title: _employee.emp_name,
                                    imageUrl: _employee.userphoto);
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),

                          horizontalSpace12,
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                // width: 200,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.5,
                                                child: Text(
                                                    _employee.emp_name
                                                        .toTitleCase(),
                                                    maxLines: 2,
                                                    style: GoogleFonts.poppins(
                                                        textStyle:
                                                            textStyle12Bold)),
                                              ),
                                              /*  FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  // showAnnuationDialog(context, employee: _employee, onNegativePressed: (){}, onPositivePressed: (){});
                                                },
                                                child: Text(
                                                  "See More",
                                                  style: GoogleFonts.poppins(
                                                    textStyle: textStyle10blackweight,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Image.asset(
                                                    'assets/icons/right_arrow.png'),
                                              )
                                            ],
                                          ),
                                        ),*/
                                            ],
                                          ),

                                          verticalSpace3,
                                          Text(
                                              _employee.designation
                                                  .toTitleCase().toUpperCase(),
                                              style: GoogleFonts.poppins(
                                                  textStyle: textStyle9Bold)),
                                          verticalSpace3,
                                          Text(
                                              _employee.department
                                                  .toTitleCase().toUpperCase(),
                                              style: GoogleFonts.poppins(
                                                  textStyle: textStyle9Normal)),
                                          verticalSpace3,
                                          Row(
                                            children: [
                                              Text(
                                                  _employee.location
                                                      .toTitleCase().toUpperCase(),
                                                  style: GoogleFonts.poppins(
                                                      textStyle:
                                                          textStyle9Normal)),
                                              // Spacer(),
                                              // if (_employee.telNo != null &&
                                              //     _employee.telNo!.isNotEmpty) ...[
                                              //   verticalSpace6,
                                              //   Padding(
                                              //     padding: const EdgeInsets.only(right: 12.0),
                                              //     child: Row(
                                              //       children: [
                                              //         if (isEmpListScreen) ...[
                                              //           // const Spacer(),
                                              //
                                              //           Obx(() {
                                              //             if (EmpListController.to.isMultipleChecked) {
                                              //               return Checkbox(
                                              //                 value: _employee.isEmployeeSelected,
                                              //                 onChanged: (value) {
                                              //                   // calling update is employee selected method
                                              //                   EmpListController.to
                                              //                       .updateIsEmployeeSelected(
                                              //                       employee: _employee);
                                              //                 },
                                              //               );
                                              //             } else {
                                              //               return _SendEmailIcon(
                                              //                   email: _employee.emails!);
                                              //             }
                                              //           }),
                                              //         ] else ...[
                                              //           _SendEmailIcon(email: _employee.emails!),
                                              //         ],
                                              //         // if (!forBirthday) ...[
                                              //         verticalSpace3,
                                              //         _SaveNumberIcon(
                                              //             employee: _employee,
                                              //             number: _employee.telNo!),
                                              //         // ],
                                              //         verticalSpace3,
                                              //         // const Spacer(),
                                              //         _SendMessageIcon(number: _employee.telNo!),
                                              //         horizontalSpace12,
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ],
                                            ],
                                          ),
                                          verticalSpace3,
                                          Text(_employee.empNo.toTitleCase(),
                                              style: GoogleFonts.poppins(
                                                  textStyle: textStyle9Normal)),
                                          /*RichTextWidget(
                                      caption: ext_no,
                                      captionStyle: GoogleFonts.poppins(
                                          textStyle: textStyle9Normal),
                                      descriptionStyle: GoogleFonts.poppins(
                                          textStyle: textStyle9Normal),
                                      description:
                                      _employee.hBJExt!.isNotEmpty
                                          ? _employee.hBJExt!
                                          : '-',
                                    ),*/
                                          // if (showVehicleNo) ...[
                                          //   verticalSpace6,
                                          //   RichTextWidget(
                                          //     caption: kVehicleNo,
                                          //     captionStyle: textStyle13Bold,
                                          //     descriptionStyle: textStyle13Normal,
                                          //     description: _employee.vehicleNo
                                          //             ?.replaceNullWithEmpty ??
                                          //         '-',
                                          //   ),
                                          // ],
                                          // verticalSpace6,
                                          // RichTextWidget(
                                          //   caption: kCpfNo,
                                          //   description: _employee.empNo!,
                                          //   captionStyle: textStyle13Bold,
                                          //   descriptionStyle: textStyle13Normal,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Column(
                          //   children: [
                          //     if (isEmpListScreen) ...[
                          //       // const Spacer(),
                          //       Obx(() {
                          //         if (EmpListController.to.isMultipleChecked) {
                          //           return Checkbox(
                          //             value: _employee.isEmployeeSelected,
                          //             onChanged: (value) {
                          //               // calling update is employee selected method
                          //               EmpListController.to
                          //                   .updateIsEmployeeSelected(
                          //                       employee: _employee);
                          //             },
                          //           );
                          //         } else {
                          //           return _SendEmailIcon(email: _employee.emails!);
                          //         }
                          //       }),
                          //     ] else ...[
                          //       _SendEmailIcon(email: _employee.emails!),
                          //     ],
                          //     _SaveNumberIcon(
                          //         employee: _employee, number: _employee.telNo!),
                          //     _SendMessageIcon(number: _employee.telNo!),
                          //   ],
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

}

class _SaveNumberIcon extends StatelessWidget {
  final String number;
  final Employee employee;

  const _SaveNumberIcon(
      {Key? key, required this.number, required this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
        init: ColorController(),
        id: 'color',
        builder: (colorController) {
          return ClipOval(
            child: Material(
              color: colorController.kIconBGColor,
              child: InkWell(
                // calling save contact number method
                onTap: () => MainDashController.to
                    .saveContact(employee: employee, number: number),
                child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(
                      Icons.save,
                      // Feather.save,
                      size: 14,
                      color: colorController.kSelectedColor,
                    )),
              ),
            ),
          );
        });
  }
}

class _SendMessageIcon extends StatelessWidget {
  final String number;

  const _SendMessageIcon({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
        init: ColorController(),
        id: 'color',
        builder: (colorController) {
          return ClipOval(
            child: Material(
              color: colorController.kIconBGColor,
              child: InkWell(
                // calling send message method
                onTap: () =>
                    MainDashController.to.sendMessage(recipients: [number]),
                child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(
                      FontAwesome5Solid.sms,
                      size: 14,
                      color: colorController.kSelectedColor,
                    )),
              ),
            ),
          );
        });
  }
}

class _SendEmailIcon extends StatelessWidget {
  final String email;

  const _SendEmailIcon({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
        init: ColorController(),
        id: 'color',
        builder: (colorController) {
          return ClipOval(
            child: Material(
              color: colorController.kIconBGColor,
              child: InkWell(
                // calling send email method
                onTap: () => MainDashController.to.sendEmail(emailId: email),
                child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Icon(
                      Zocial.email,
                      size: 14,
                      color: colorController.kSelectedColor,
                    )),
              ),
            ),
          );
        });
  }
}
