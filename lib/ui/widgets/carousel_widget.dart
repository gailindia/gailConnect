// Created By Amit Jangid 25/08/21

import 'package:flutter/material.dart';
import 'package:gail_connect/models/super_annuation_model.dart';
import 'package:gail_connect/ui/widgets/custom_dialogs/send_wish_dialog_box.dart';
import 'package:gail_connect/ui/widgets/text_widget.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiutillib/multiutillib.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/ui/widgets/circular_network_image_widget.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';
import '../styles/color_controller.dart';

class CarouselWidget extends StatelessWidget {
  CarouselWidget({Key? key, required this.s}) : super(key: key);
  final String s;
  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    final double _height = MediaQuery.of(context).size.height;

    return GetBuilder<MainDashController>(
      id: kDashboard,
      builder: (_controller) {
        print(s);
        if (s == 'birthday') {
          if (_controller.employeesBirthDayList.isNotEmpty) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CarouselSlider.builder(
                  itemCount: _controller.employeesBirthDayList.length,
                  options: CarouselOptions(
                    //  padEnds: false,
                    autoPlay: true,
                    // height: carouselHeight,
                    enableInfiniteScroll: false,
                    // enlargeCenterPage: false,
                    disableCenter: true,
                    viewportFraction: 0.75,
                    // aspectRatio: 2.0,
                    initialPage: 1,
                    aspectRatio: 4,
                    enlargeCenterPage: true,
                    pauseAutoPlayInFiniteScroll: true,
                    // viewportFraction: 1,
                    // autoPlay: _controller.employeesBirthDayList.length > 1,
                    onPageChanged: (_index, _reason) =>
                        _controller.onCarouselPageChanged(_index),
                    // height: 200
                    /*height: _height *
                        (_height < 600
                            ? .13
                            : (_height > 601 && _height < 900)
                            ? .140
                            : .11),*/
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final Employee _employee =
                        _controller.employeesBirthDayList[index];
                    // return bdaywidget(_employee, _controller, context);

                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          stops: [0.1, 0.7],
                          end: Alignment.bottomLeft,
                          begin: Alignment.topRight,
                          colors: [
                            colorController.kCircleBgColor,
                            colorController.kCircleBgColor,
                          ],
                        ),
                        // boxShadow: [
                        //   BoxShadow(
                        //       blurRadius: 12,
                        //       spreadRadius: 2,
                        //       color: Color.fromARGB(
                        //           21, 17, 16, 12)), //kPrimaryLightColor.withOpacity(0.2))
                        // ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Stack(
                        // mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Image.asset('assets/birthday.gif'),
                          // const AnimatedBalloons(),
                          Row(
                            children: [
                              horizontalSpace6,
                              CircularNetworkImageWidget(
                                  imageUrl: _employee.image!),
                              horizontalSpace12,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        _employee.empName!.toTitleCase(),
                                        style: GoogleFonts.poppins(
                                          textStyle: textStyle14Bold,
                                        ),
                                      ),
                                    ),
                                    verticalSpace3,
                                    FittedBox(
                                        child:
                                            TextWidget(
                                                status: _employee.designation!,
                                                fontSize: 12,
                                                letterSpacing: 0.55,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500)),
                                    verticalSpace12,
                                    GestureDetector(
                                      onTap: () {
                                        _controller.type = "B";
                                        _controller.sendwishController.text =
                                            'Happy Birthday';
                                        _controller.update([kDashboard]);
                                        sendWishDialogBox(context,
                                            title: "B",
                                            description: "Send Wishes",
                                            onNegativePressed: () {
                                          Navigator.pop(context);
                                        }, onPositivePressed: () {
                                          _controller.postSendWish(
                                              context, 'B', _employee.empNo);
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          // ignore: prefer_const_constructors
                                          FittedBox(
                                              child: TextWidget(
                                                  status: 'Send wishes',
                                                  fontSize: 14,
                                                  letterSpacing: 0.55,
                                                  color: colorController
                                                      .kUnselectedColor,
                                                  fontWeight: FontWeight.w500)
                                              ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Icon(
                                              Icons.mail,
                                              color: colorController
                                                  .kUnselectedColor,
                                              size: 15,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                verticalSpace6,
              ],
            );
          }
        } else if (s == 'newjoiners') {
          if (_controller.newEmployeesJoinesList.isNotEmpty) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CarouselSlider.builder(
                  itemCount: _controller.newEmployeesJoinesList.length,
                  options: CarouselOptions(
                    //  padEnds: false,
                    autoPlay: true,
                    // height: carouselHeight,
                    enableInfiniteScroll: false,
                    // enlargeCenterPage: false,
                    disableCenter: true,
                    viewportFraction: 0.75,
                    // aspectRatio: 2.0,
                    initialPage: 1,
                    aspectRatio: 4,
                    enlargeCenterPage: true,
                    pauseAutoPlayInFiniteScroll: true,
                    // viewportFraction: 1,
                    // autoPlay: _controller.employeesBirthDayList.length > 1,
                    onPageChanged: (_index, _reason) =>
                        _controller.onCarouselPageChanged(_index),
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final Employee _employee =
                    _controller.newEmployeesJoinesList[index];
                    // return bdaywidget(_employee, _controller, context);

                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          stops: [0.1, 0.7],
                          end: Alignment.bottomLeft,
                          begin: Alignment.topRight,
                          colors: [
                            colorController.kCircleBgColor,
                            colorController.kCircleBgColor,
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Stack(
                        // mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Image.asset('assets/birthday.gif'),
                          // const AnimatedBalloons(),
                          Row(
                            children: [
                              horizontalSpace6,
                              CircularNetworkImageWidget(
                                  imageUrl: _employee.image!),
                              // horizontalSpace12,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    verticalSpace3,
                                    FittedBox(
                                      child: Text(
                                        _employee.empName!.toTitleCase(),
                                        style: GoogleFonts.poppins(
                                          textStyle: textStyle14Bold,
                                        ),
                                      ),
                                    ),
                                    verticalSpace3,
                                    FittedBox(
                                        child:
                                        TextWidget(
                                            status: _employee.designation!,
                                            fontSize: 12,
                                            letterSpacing: 0.55,
                                            color: Colors.black,
                                            // color: colorController
                                            //     .kUnselectedColor,
                                            fontWeight: FontWeight.w500)),
                                    verticalSpace12,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                verticalSpace6,
              ],
            );
          }
        }
        else {
          if (_controller.superannuationmodel.isNotEmpty) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CarouselSlider.builder(
                  itemCount: _controller.superannuationmodel.length,
                  options: CarouselOptions(
                    //  padEnds: false,
                    autoPlay: true,
                    // height: carouselHeight,
                    enableInfiniteScroll: false,
                    // enlargeCenterPage: false,
                    disableCenter: true,
                    pauseAutoPlayInFiniteScroll: true,
                    viewportFraction: 0.75,
                    // aspectRatio: 2.0,
                    initialPage: 1,
                    aspectRatio: 4,
                    enlargeCenterPage: true,
                    // viewportFraction: 1,
                    // autoPlay: _controller.superannuationmodel.length > 1,
                    onPageChanged: (_index, _reason) =>
                        _controller.onCarouselPageChanged(_index),
                    // height: 200
                  ),
                  itemBuilder: (context, index, realIndex) {
                    final SuperAnnuationModel superannuation =
                        _controller.superannuationmodel[index];

                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          stops: [0.1, 0.7],
                          end: Alignment.bottomLeft,
                          begin: Alignment.topRight,
                          colors: [
                            colorController.kCircleBgColor,
                            colorController.kCircleBgColor,
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Stack(
                        children: [
                          horizontalSpace3,
                          Image.asset('assets/birthday.gif'),
                          // const AnimatedBalloons(),
                          Row(
                            children: [
                              CircularNetworkImageWidget(
                                  imageUrl: superannuation.userphoto),
                              horizontalSpace12,
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FittedBox(
                                      child: Text(
                                        superannuation.emp_name.toTitleCase(),
                                        style: GoogleFonts.poppins(
                                          textStyle: textStyle14Bold,
                                        ),
                                      ),
                                    ),
                                    verticalSpace3,
                                    FittedBox(
                                      child:
                                          TextWidget(
                                              status:
                                                  superannuation.designation,
                                              fontSize: 12,
                                              letterSpacing: 0.55,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                    ),
                                    verticalSpace12,
                                    GestureDetector(
                                      onTap: () {
                                        _controller.type = "S";
                                        _controller.sendwishController.text =
                                            'Your legacy will shine on. Happy retirement!';
                                        _controller.update([kDashboard]);
                                        sendWishDialogBox(context,
                                            title: "S",
                                            description: "Send Wishes",
                                            onNegativePressed: () {
                                          Navigator.pop(context);
                                        }, onPositivePressed: () {
                                          _controller.postSendWish(context, 'S',
                                              superannuation.empNo);
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          TextWidget(
                                              status: 'Send wishes',
                                              fontSize: 14,
                                              letterSpacing: 0.55,
                                              color: colorController
                                                  .kUnselectedColor,
                                              fontWeight: FontWeight.w500),
                                          // ignore: prefer_const_constructors
                                          Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Icon(
                                              Icons.mail,
                                              color: colorController
                                                  .kUnselectedColor,
                                              size: 15,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                verticalSpace6,
              ],
            );
          }
        }

        return const SizedBox.shrink();
      },
    );
  }
}
