// Created By Amit Jangid 01/09/21

import 'package:flutter/material.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/ui/widgets/animated_balloon.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/emp_list_widget.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/routes.dart';
import '../../../styles/color_controller.dart';

class EmpSuperAnnuationScreen extends StatelessWidget {
  const EmpSuperAnnuationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ColorController colorController= Get.put(ColorController());
    final GailConnectServices _gailConnectServices = GailConnectServices.to;
    _gailConnectServices.hitCountApi(
        activity: kEmployeesAnnuationRoute,
        activityScreen: "/employeesAnnuation");
    return GetBuilder<ColorController>(
        init: ColorController(),
        id: 'color',
        builder: (colorController) {
          return Scaffold(
            backgroundColor: colorController.kBgColor,
            appBar:
                CustomAppBar(title: "Superannuation", isBirthdayScreen: true),
            body: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // AnimatedGradient(),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [
                            0.1,
                            0.4,
                            0.6,
                            0.9,
                          ],
                          colors: [
                            colorController.kPrimaryLightColor,
                            colorController.kPrimaryColor,
                            colorController.kPrimaryColor,
                            colorController.kPrimaryDarkColor,
                          ],
                        )),
                    margin: const EdgeInsets.only(left: 12, right: 12),
                    // color: Colors.blueAccent,
                    width: MediaQuery.of(context).size.width,
                    // height: 40,
                    padding: const EdgeInsets.only(
                        left: 50, right: 50, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "  Best Wishes ",

                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontSize: 15,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                          // style: textStyle16Bold.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: EmpListWidget(
                        forBirthday: true,
                        employeeList: [],
                        phoneConsent: [],
                        superannuationmodel:
                            MainDashController.to.superannuationmodel,
                        animationController:
                            MainDashController.to.animationController,
                      ),
                    ),
                  ),
                  const AnimatedBalloon(),
                ],
              ),
            ),
          );
        });
  }
}
