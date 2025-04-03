/*
   * -----------------!! Created by Himanshu Shukla !!-----------------------
   *  ---------------- All Rights reserved for Gail India--------------------
   */

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:gail_connect/utils/utils.dart';
import 'package:get/get.dart';

import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:multiutillib/animations/animations.dart';
import 'package:multiutillib/utils/ui_helpers.dart';

import 'package:multiutillib/widgets/rich_text_widgets.dart';

import '../../../core/controllers/emp_controllers/emp_list_controllers/emp_list_controller.dart';
import '../../../core/controllers/main_dash_controller.dart';
import '../../../utils/constants/app_constants.dart';
import '../../screens/full_image_screen.dart';
import '../../styles/color_controller.dart';
import '../circular_network_image_widget.dart';
import '../open_container_transition.dart';

/// This method will show a dialog box with custom UI and animation
showEmpDialog(
  BuildContext context, {
  required Employee employee,
  required VoidCallback onNegativePressed,
  required VoidCallback onPositivePressed,
}) {
  return showGeneralDialog(
    context: context,
    barrierLabel: '',
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    transitionBuilder: (context, animation, secondaryAnimation, child) =>
        Animations.grow(animation, child),
    pageBuilder: (BuildContext context, animation, secondaryAnimation) {
      return _CustomConfirmDialog(
        employee: employee,
        onNegativePressed: onNegativePressed,
        onPositivePressed: onPositivePressed,
      );
    },
  );
}

class _CustomConfirmDialog extends StatelessWidget {
  final Employee employee;
  final VoidCallback onNegativePressed, onPositivePressed;

  const _CustomConfirmDialog({
    required this.employee,
    required this.onNegativePressed,
    required this.onPositivePressed,
  });

  @override
  Widget build(BuildContext context) {
    ColorController colorController =
        Get.put(ColorController()); //colorController.
    const double _borderRadius = 20;
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height / 2;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: FittedBox(
        child: Dialog(
          insetPadding: const EdgeInsets.all(8),
          elevation: 0,
          backgroundColor: colorController.kPrimaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_borderRadius)),
          child: Container(
            width: _width,
            //height: _height,
            margin: const EdgeInsets.only(bottom: 2),
            decoration: BoxDecoration(
                color: colorController.kBgPopupColor,
                borderRadius: BorderRadius.circular(_borderRadius)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                            padding: EdgeInsets.only(right: 12.0, top: 12.0),
                            child: Icon(Icons.cancel)

                            // const Text("X",style: const TextStyle(
                            //   fontSize: 20,
                            //   color: Colors.black
                            // ),),
                            ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      OpenContainerTransition(
                        tappable: (employee.image != null &&
                            employee.image!.isNotEmpty),
                        closedShape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        closedBuilder: (context, action) =>
                            CircularNetworkImageWidget(
                          imageWidth: 60,
                          imageHeight: 60,
                          imageUrl: employee.image!,
                        ),
                        openBuilder: (context, action) {
                          if (employee.image != null &&
                              employee.image!.isNotEmpty) {
                            return FullImageScreen(
                                title: employee.empName!,
                                imageUrl: employee.image!);
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                  employee.empName!
                                                      .toTitleCase(),
                                                  style: textStyle15Bold),
                                              const SizedBox(height: 3),
                                              Text(employee.designation!,
                                                  style: textStyle13Normal),
                                              verticalSpace6,
                                              Text(
                                                  '${employee.department!.toTitleCase()}, ${employee.location!.toTitleCase()}',
                                                  style: textStyle13Normal),
                                              verticalSpace6,
                                              const Padding(
                                                padding: EdgeInsets.only(
                                                    right: 12.0),
                                                child: Divider(
                                                  thickness: 0.5,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              GetBuilder<EmpListController>(
                                                  id: kEmployees,
                                                  init: EmpListController(),
                                                  builder:
                                                      (_empListController) {
                                                    return Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            RichTextWidget(
                                                              caption: kHvj,
                                                              captionStyle:
                                                                  textStyle13Bold,
                                                              descriptionStyle:
                                                                  textStyle13Normal,
                                                              description: employee
                                                                      .hBJExt!
                                                                      .isNotEmpty
                                                                  ? employee
                                                                      .hBJExt!
                                                                      .toTitleCase()
                                                                  : '-',
                                                            ),
                                                            verticalSpace6,
                                                            RichTextWidget(
                                                              caption: kCpfNo,
                                                              description: employee
                                                                  .empNo!
                                                                  .toTitleCase(),
                                                              captionStyle:
                                                                  textStyle13Bold,
                                                              descriptionStyle:
                                                                  textStyle13Normal,
                                                            ),
                                                            verticalSpace12,
                                                            Row(
                                                              children: [
                                                                // Spacer(),
                                                                ClipOval(
                                                                  child:
                                                                      Material(
                                                                    color: colorController
                                                                        .kPrimaryColor,
                                                                    child:
                                                                        InkWell(
                                                                      // calling save contact number method
                                                                      onTap: () => MainDashController.to.saveContact(
                                                                          employee:
                                                                              employee,
                                                                          number:
                                                                              employee.telNo!),
                                                                      child: SizedBox(
                                                                          width: 24,
                                                                          height: 24,
                                                                          child: Icon(
                                                                            Icons.save,
                                                                            size:
                                                                                14,
                                                                            color:
                                                                                colorController.kSelectedColor,
                                                                          )),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // _SaveNumberIcon(
                                                                //     employee: _employee,
                                                                //     number:
                                                                //     _employee.telNo!),
                                                                // ],

                                                                // if (!forBirthday) ...[
                                                                SizedBox(
                                                                    width: 12),

                                                                // const Spacer(),
                                                                ClipOval(
                                                                  child:
                                                                      Material(
                                                                    color: colorController
                                                                        .kPrimaryColor,
                                                                    child:
                                                                        InkWell(
                                                                      // calling send message method
                                                                      onTap: () => MainDashController
                                                                          .to
                                                                          .sendMessage(
                                                                              recipients: [
                                                                            employee.telNo!
                                                                          ]),
                                                                      child: SizedBox(
                                                                          width: 24,
                                                                          height: 24,
                                                                          child: Icon(
                                                                            FontAwesome5Solid.sms,
                                                                            size:
                                                                                14,
                                                                            color:
                                                                                colorController.kSelectedColor,
                                                                          )),
                                                                    ),
                                                                  ),
                                                                ),
                                                                // _SendMessageIcon(
                                                                //     number:
                                                                //         _employee.telNo!),
                                                                SizedBox(
                                                                    width: 7),
                                                              ],
                                                            ),
                                                            // verticalSpace12,
                                                            verticalSpace6,
                                                            // RichTextWidget(
                                                            //   caption:
                                                            //       kBirthDate,
                                                            //   description: _empListController
                                                            //       .getBirthdayFormat(employee
                                                            //           .dateOfBirth
                                                            //           .toString()),
                                                            //   captionStyle:
                                                            //       textStyle13Bold,
                                                            //   descriptionStyle:
                                                            //       textStyle13Normal,
                                                            // ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10.0),
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                employee.emails!
                                                                        .isNotEmpty
                                                                    ? GestureDetector(
                                                                        onTap: () => MainDashController
                                                                            .to
                                                                            .sendEmail(emailId: employee.emails!),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(right: 0.0),
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              const Padding(
                                                                                padding: EdgeInsets.only(right: 1.0),
                                                                                child: Icon(
                                                                                  Icons.email_outlined,
                                                                                  color: Colors.black,
                                                                                  size: 15,
                                                                                ),
                                                                              ),
                                                                              FittedBox(
                                                                                fit: BoxFit.scaleDown,
                                                                                child: Text(
                                                                                  employee.emails!.isNotEmpty ? employee.emails! : '-',
                                                                                  style: const TextStyle(fontSize: 11, color: Colors.black),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Container(),
                                                                verticalSpace6,
                                                                employee.telNo!
                                                                        .isNotEmpty
                                                                    ? GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          launchDialer(
                                                                              employee.telNo!);
                                                                        },
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            const Padding(
                                                                              padding: EdgeInsets.only(right: 2.0),
                                                                              child: Icon(
                                                                                Icons.phone,
                                                                                color: Colors.black,
                                                                                size: 15,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              employee.telNo!.isNotEmpty ? employee.telNo!.toTitleCase() : '-',
                                                                              style: const TextStyle(fontSize: 12, color: Colors.black),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )
                                                                    : Container(),
                                                                verticalSpace6,
                                                                // if (employee
                                                                //     .mobileNo!
                                                                //     .isNotEmpty) ...[
                                                                employee.mobileNo!
                                                                            .isEmpty &&
                                                                        employee
                                                                            .faxNo!
                                                                            .isEmpty
                                                                    ? Container()
                                                                    : GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          launchDialer(employee.mobileNo!.isNotEmpty
                                                                              ? employee.mobileNo!
                                                                              : employee.faxNo!);
                                                                        },
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            const Padding(
                                                                              padding: EdgeInsets.only(right: 2.0),
                                                                              child: Icon(
                                                                                Icons.phone,
                                                                                color: Colors.black,
                                                                                size: 15,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              employee.mobileNo!.isNotEmpty ? employee.mobileNo!.toTitleCase() : employee.faxNo!,
                                                                              style: const TextStyle(fontSize: 12, color: Colors.black),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),

                                                                verticalSpace6,
                                                                // Row(
                                                                //   children: [
                                                                //     // Spacer(),
                                                                //     ClipOval(
                                                                //       child:
                                                                //           Material(
                                                                //         color: colorController
                                                                //             .kPrimaryColor,
                                                                //         child:
                                                                //             InkWell(
                                                                //           // calling save contact number method
                                                                //           onTap: () => MainDashController.to.saveContact(
                                                                //               employee: employee,
                                                                //               number: employee.telNo!),
                                                                //           child: SizedBox(
                                                                //               width: 24,
                                                                //               height: 24,
                                                                //               child: Icon(
                                                                //                 Icons.save,
                                                                //                 size: 14,
                                                                //                 color: colorController.kSelectedColor,
                                                                //               )),
                                                                //         ),
                                                                //       ),
                                                                //     ),
                                                                //     // _SaveNumberIcon(
                                                                //     //     employee: _employee,
                                                                //     //     number:
                                                                //     //     _employee.telNo!),
                                                                //     // ],

                                                                //     // if (!forBirthday) ...[
                                                                //     SizedBox(
                                                                //         width:
                                                                //             7),

                                                                //     // const Spacer(),
                                                                //     ClipOval(
                                                                //       child:
                                                                //           Material(
                                                                //         color: colorController
                                                                //             .kPrimaryColor,
                                                                //         child:
                                                                //             InkWell(
                                                                //           // calling send message method
                                                                //           onTap: () => MainDashController
                                                                //               .to
                                                                //               .sendMessage(recipients: [
                                                                //             employee.telNo!
                                                                //           ]),
                                                                //           child: SizedBox(
                                                                //               width: 24,
                                                                //               height: 24,
                                                                //               child: Icon(
                                                                //                 FontAwesome5Solid.sms,
                                                                //                 size: 14,
                                                                //                 color: colorController.kSelectedColor,
                                                                //               )),
                                                                //         ),
                                                                //       ),
                                                                //     ),
                                                                //     // _SendMessageIcon(
                                                                //     //     number:
                                                                //     //         _employee.telNo!),
                                                                //     SizedBox(
                                                                //         width:
                                                                //             7),
                                                                //   ],
                                                                // ),
                                                                // verticalSpace12,
                                                              ]
                                                              // ],
                                                              ),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ]),
                                ]),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
