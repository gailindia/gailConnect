// Created By Amit Jangid 01/09/21

import 'package:flutter/material.dart';

import 'package:gail_connect/ui/widgets/animated_balloon.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/ui/widgets/emp_list_widget.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';
import 'package:get/get.dart';
import '../../../styles/color_controller.dart';


class EmpNewJoinersListScreen extends StatelessWidget {
  const EmpNewJoinersListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ColorController>(
        id: 'color',
        init: ColorController(),
        builder: (colorController) {
          return Scaffold(
              backgroundColor: colorController.kBgColor,
              appBar: CustomAppBar(
                  title: kNewJoinedEmployees, isNewJoinersScreen: true),
              body: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [


                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: EmpListWidget(
                          forBirthday: true,
                          employeeList:
                          MainDashController.to.newEmployeesJoinesList,
                          superannuationmodel: [],
                          phoneConsent: MainDashController.to.phoneConsentList,
                          animationController:
                          MainDashController.to.animationController,
                        ),
                      ),
                    ),
                    const AnimatedBalloon(),
                  ],
                ),
              ));
        });
  }
}
