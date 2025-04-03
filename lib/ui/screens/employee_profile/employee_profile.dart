// Created By Amit Jangid 01/09/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/screens/screens.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';

import 'package:gail_connect/ui/screens/full_image_screen.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/open_container_transition.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';
import 'package:gail_connect/ui/widgets/circular_network_image_widget.dart';

class ProfileScreen extends StatelessWidget {


  ProfileScreen({
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainDashController mainDashController = Get.put(MainDashController());
    Employee employee = mainDashController.loggedInEmployee!;
    ColorController controller = Get.put(ColorController());
    return Scaffold(
backgroundColor: controller.kHomeBgColor,
      appBar: AppBar(
        titleSpacing: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text("Profile",style: TextStyle(color: Colors.black,fontSize: 30),),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 2),
        // decoration: BoxDecoration(color: kBgPopupColor, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Column(
              children: [
                verticalSpace6,
                OpenContainerTransition(
                  tappable:
                  (employee.image != null && employee.image!.isNotEmpty),
                  closedShape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  closedBuilder: (context, action) =>
                      CircularNetworkImageWidget(
                        imageWidth: 200,
                        imageHeight: 200,
                        imageUrl: employee.image!,
                      ),
                  openBuilder: (context, action) {
                    if (employee.image != null && employee.image!.isNotEmpty) {
                      return FullImageScreen(
                          title: employee.empName!, imageUrl: employee.image!);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // horizontalSpace12,
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(employee.empName!.toTitleCase(),
                                            style: textStyle15Boldpro),
                                        const SizedBox(height: 3),
                                        Text(
                                            employee.designation!,
                                            style: textStyle13Normalpro),
                                        verticalSpace6,
                                        FittedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 5.0,right: 5),
                                            child: Text(
                                                '${employee.department!.toTitleCase()}, ${employee.location!.toTitleCase()}',
                                                style: textStyle13Normalpro),
                                          ),
                                        ),
                                        verticalSpace6,
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              right: 0.0, left: 0),
                                          child: Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Row(
                                            children: [
                                              Text(
                                                ext_no,
                                                style: GoogleFonts.lato(
                                                    textStyle: textStyle18Bold),
                                              ),
                                              const Spacer(),
                                              Text(
                                                employee.hBJExt!.isNotEmpty
                                                    ? employee.hBJExt!
                                                    .toTitleCase()
                                                    : '-',
                                                style: GoogleFonts.lato(
                                                    textStyle:
                                                    textStyle18Normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                        verticalSpace6,
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              right: 0.0, left: 0),
                                          child: Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Row(
                                            children: [
                                              Text(
                                                kCpfNo,
                                                style: GoogleFonts.lato(
                                                    textStyle: textStyle18Bold),
                                              ),
                                              const Spacer(),
                                              Text(
                                                employee.empNo!.isNotEmpty
                                                    ? employee.empNo!
                                                    .toTitleCase()
                                                    : '-',
                                                style: GoogleFonts.lato(
                                                    textStyle:
                                                    textStyle18Normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                        verticalSpace6,
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              right: 0.0, left: 0),
                                          child: Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Row(
                                            children: [
                                              Text(
                                                kBirthDate,
                                                style: GoogleFonts.lato(
                                                    textStyle: textStyle18Bold),
                                              ),
                                              const Spacer(),
                                              Text(
                                                employee.dateOfBirth!.isNotEmpty
                                                    ? employee.dateOfBirth!
                                                    .toTitleCase()
                                                    : '-',
                                                style: GoogleFonts.lato(
                                                    textStyle:
                                                    textStyle18Normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                        verticalSpace6,
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              right: 0.0, left: 0),
                                          child: Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Row(
                                            children: [
                                              Text(
                                                kLocation,
                                                style: GoogleFonts.lato(
                                                    textStyle: textStyle18Bold),
                                              ),
                                              const Spacer(),
                                              Text(
                                                employee.location!.isNotEmpty
                                                    ? employee.location!
                                                    .toTitleCase()
                                                    : '-',
                                                style: GoogleFonts.lato(
                                                    textStyle:
                                                    textStyle18Normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                        verticalSpace6,
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              right: 0.0, left: 0),
                                          child: Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Row(
                                            children: [
                                              Text(
                                                kEmailId,
                                                style: GoogleFonts.lato(
                                                    textStyle: textStyle18Bold),
                                              ),
                                              const Spacer(),
                                              Text(
                                                employee.emails!.isNotEmpty
                                                    ? employee.emails!

                                                    : '-',
                                                style: GoogleFonts.lato(
                                                    textStyle:
                                                    textStyle18Normal),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // verticalSpace12,
                                        // Padding(
                                        //   padding: const EdgeInsets.only(
                                        //       left: 20, right: 20),
                                        //   child: Row(
                                        //     children: [
                                        //       Text(
                                        //         kCpfNo,
                                        //         style: GoogleFonts.lato(
                                        //             textStyle: textStyle18Bold),
                                        //       ),
                                        //       const Spacer(),
                                        //       Text(employee.hBJExt!.isNotEmpty
                                        //           ? employee.hBJExt!
                                        //               .toTitleCase()
                                        //           : '-'),
                                        //     ],
                                        //   ),
                                        // ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceEvenly,
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //   children: [
                                        //     Column(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.start,
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.start,
                                        //       children: [
                                        //         RichTextWidget(
                                        //           caption: kHvj,
                                        //           captionStyle: textStyle13Bold,
                                        //           descriptionStyle:
                                        //               textStyle13Normal,
                                        //           description: employee
                                        //                   .hBJExt!.isNotEmpty
                                        //               ? employee.hBJExt!
                                        //                   .toTitleCase()
                                        //               : '-',
                                        //         ),
                                        //         verticalSpace6,
                                        //         RichTextWidget(
                                        //           caption: kCpfNo,
                                        //           description: employee.empNo!
                                        //               .toTitleCase(),
                                        //           captionStyle: textStyle13Bold,
                                        //           descriptionStyle:
                                        //               textStyle13Normal,
                                        //         ),
                                        //         verticalSpace6,
                                        //         RichTextWidget(
                                        //           caption: kbirthday,
                                        //           description: employee
                                        //               .dateOfBirth!
                                        //               .toTitleCase(),
                                        //           captionStyle: textStyle13Bold,
                                        //           descriptionStyle:
                                        //               textStyle13Normal,
                                        //         ),
                                        //       ],
                                        //     ),
                                        //     Column(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.start,
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.start,
                                        //       children: [
                                        //         Row(
                                        //           children: [
                                        //             const Padding(
                                        //               padding: EdgeInsets.only(
                                        //                   right: 2.0),
                                        //               child: Icon(
                                        //                 Icons.email_outlined,
                                        //                 color: Colors.black,
                                        //                 size: 15,
                                        //               ),
                                        //             ),
                                        //             Text(
                                        //               employee.emails!
                                        //                       .isNotEmpty
                                        //                   ? employee.emails!
                                        //                       .toTitleCase()
                                        //                   : '-',
                                        //               style: const TextStyle(
                                        //                   fontSize: 9,
                                        //                   color: Colors.black),
                                        //             )
                                        //           ],
                                        //         ),
                                        //         verticalSpace6,
                                        //         Row(
                                        //           children: [
                                        //             const Padding(
                                        //               padding: EdgeInsets.only(
                                        //                   right: 2.0),
                                        //               child: Icon(
                                        //                 Icons.phone,
                                        //                 color: Colors.black,
                                        //                 size: 15,
                                        //               ),
                                        //             ),
                                        //             Text(
                                        //               employee.officeExt!
                                        //                       .isNotEmpty
                                        //                   ? employee.officeExt!
                                        //                       .toTitleCase()
                                        //                   : '-',
                                        //               style: const TextStyle(
                                        //                   fontSize: 9,
                                        //                   color: Colors.black),
                                        //             )
                                        //           ],
                                        //         ),
                                        //         verticalSpace6,
                                        //         Row(
                                        //           children: [
                                        //             const Padding(
                                        //               padding: EdgeInsets.only(
                                        //                   right: 2.0),
                                        //               child: Icon(
                                        //                 Icons.phone,
                                        //                 color: Colors.black,
                                        //                 size: 15,
                                        //               ),
                                        //             ),
                                        //             Text(
                                        //               employee.
                                        //               !
                                        //                       .isNotEmpty
                                        //                   ? employee.mobileNo!
                                        //                       .toTitleCase()
                                        //                   : '-',
                                        //               style: const TextStyle(
                                        //                   fontSize: 9,
                                        //                   color: Colors.black),
                                        //             )
                                        //           ],
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ],
                                        // ),
                                        verticalSpace6,
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              right: 0.0, left: 0),
                                          child: Divider(
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                        ),
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
    );
  }
}
