// Created By Amit Jangid 13/07/21

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:get/get.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/models/employee.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_list_controllers/emp_list_controller.dart';
import 'package:gail_connect/core/controllers/emp_controllers/emp_group_controllers/create_emp_group_controller.dart';
import 'package:gail_connect/core/controllers/dash_controllers/admin_controllers/emp_not_having_app_controllers/emp_not_having_app_controller.dart';
import 'package:multiutillib/widgets/dialogs/progress_dialog.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

import '../../core/controllers/useful_links_controllers/dispensary_add_call_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double elevation;
  final bool? centerTitle;
  final bool isHomeScreen;
  final Widget? titleWidget;
  final bool isEmpListScreen;
  final bool isHospitalScreen;
  final bool isCreateEmpGroupScreen;
  final bool isEmpGroupSendMsgScreen;
  final bool isEmpNotHavingAppListScreen;
  final bool isEmpNotHavingAppListScreenCount;
  final bool isBirthdayScreen;
  final bool isNewJoinersScreen;

  CustomAppBar({
    Key? key,
    required this.title,
    this.titleWidget,
    this.centerTitle,
    this.elevation = 4,
    this.isHomeScreen = false,
    this.isEmpListScreen = false,
    this.isHospitalScreen = false,
    this.isCreateEmpGroupScreen = false,
    this.isEmpGroupSendMsgScreen = false,
    this.isEmpNotHavingAppListScreen = false,
    this.isEmpNotHavingAppListScreenCount = false,
    this.isBirthdayScreen = false,
    this.isNewJoinersScreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DispensaryHistoryController counterController =
        Get.put(DispensaryHistoryController());
    return GetBuilder<ColorController>(
        id: 'color',
        init: ColorController(),
        builder: (colorController) {
          return AppBar(
            backgroundColor: colorController.kPrimaryColor,
            titleSpacing: 0,
            elevation: elevation,
            centerTitle: centerTitle,
            title: titleWidget ??
                InkWell(
                  onTap: () {
                    if (isEmpGroupSendMsgScreen) {
                      Get.toNamed(kEmpGroupDetailsRoute);

                      // calling hit count api method
                      // GailConnectServices.to
                      //     .hitCountApi(activity: kEmployeesGroupDetailsScreen);
                    } else {
                      Get.offNamedUntil(kMainDashRoute, (route) => false);
                    }
                  },
                  child: Row(
                    children: [
                      // const LogoWidget(height: 36),
                      horizontalSpace6,
                      Expanded(
                          child: Text(title,
                              maxLines: 2,
                              style: textStyle16Bold.copyWith(
                                  color: Colors.white))),
                    ],
                  ),
                ),
            leading: IconButton(
              onPressed: () {
                if (isHomeScreen) {
                  exit(0);
                } else {
                  if (isEmpListScreen) {
                    // calling update is multiple checked method
                    EmpListController.to
                        .updateIsMultipleChecked(fromBackButton: true);
                  }

                  // SharedPrefs.to.currentChatRoomId = '';
                  Get.back();
                }
              },
              icon: isHomeScreen
                  ? const SizedBox.shrink()
                  : Icon(
                      Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
            ),
            actions: [
              if (isHomeScreen) ...[
                IconButton(
                  padding: const EdgeInsets.only(),
                  icon: const Icon(Icons.exit_to_app_outlined),
                  onPressed: () async{
                    SecureSharedPref pref = await SecureSharedPref.getInstance();
                    pref.putBool("isLoggedIn", false);
                    Get.offNamedUntil(kLoginRoute, (route) => false);
                  },
                ),
              ],
              if (isEmpListScreen) ...[
                Obx(
                  () {
                    if (EmpListController.to.isMultipleChecked) {
                      return Row(
                        children: [
                          IconButton(
                            padding: const EdgeInsets.only(),
                            icon: const Icon(FontAwesome5Solid.sms),
                            onPressed: () {
                              final List<String> _recipients = [];

                              for (final Employee employee in EmpListController
                                  .to.filteredEmployeesList) {
                                if (employee.isEmployeeSelected &&
                                    employee.telNo != null &&
                                    employee.telNo!.isNotEmpty) {
                                  _recipients.add(employee.telNo!);
                                }
                              }

                              // calling send message method
                              MainDashController.to
                                  .sendMessage(recipients: _recipients);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Zocial.email),
                            padding: const EdgeInsets.only(),
                            onPressed: () {
                              String _emails = '';

                              for (final Employee employee in EmpListController
                                  .to.filteredEmployeesList) {
                                if (employee.isEmployeeSelected &&
                                    employee.emails != null &&
                                    employee.emails!.isNotEmpty) {
                                  _emails += employee.emails! + ',';
                                }
                              }

                              // calling send email method
                              MainDashController.to.sendEmail(
                                  emailId:
                                      _emails.substring(0, _emails.length - 1));
                            },
                          ),
                          IconButton(
                            padding: const EdgeInsets.only(),
                            icon: const Icon(MaterialIcons.clear),
                            // calling update is multiple checked method
                            onPressed: () async =>
                                EmpListController.to.updateIsMultipleChecked(),
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          IconButton(
                            padding: const EdgeInsets.only(),
                            icon: const Icon(Feather.filter),
                            onPressed: () async {
                              // calling hit count api method
                              // GailConnectServices.to.hitCountApi(
                              //     activity: kEmployeesAdvanceFilterScreen);

                              await Get.toNamed(kFiltersRoute);

                              // calling get employees list method
                              EmpListController.to.getEmployeesList(true);
                            },
                          ),
                          IconButton(
                            padding: const EdgeInsets.only(),
                            icon: const Icon(Feather.check_square),
                            // calling update is multiple checked method
                            onPressed: () async =>
                                EmpListController.to.updateIsMultipleChecked(),
                          ),
                          IconButton(
                            padding: const EdgeInsets.only(),
                            icon: const Icon(Ionicons.sync_sharp),
                            // calling sync emp list from server method
                            onPressed: () =>
                                MainDashController.to.syncEmpListFromServer(),
                            // onPressed: () => MainDashController.to.logout(),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
              if (isHospitalScreen) ...[
                IconButton(
                  padding: const EdgeInsets.only(),
                  icon: const Icon(Feather.filter),
                  onPressed: () async {
                    // calling hit count api method
                    // GailConnectServices.to
                    //     .hitCountApi(activity: kHospitalAdvanceFilterScreen);

                    Get.toNamed(kCityFilterRoute);
                  },
                ),
              ],
              if (isEmpNotHavingAppListScreen) ...[
                IconButton(
                  padding: const EdgeInsets.only(),
                  icon: const Icon(Feather.filter),
                  onPressed: () async {
                    await Get.toNamed(kEmpNotHavingAppFilterRoute);

                    // calling get emp not having app list method
                    await EmpNotHavingAppController.to.getEmpNotHavingAppList();
                  },
                ),
              ],
              //table count admin dashborad

              if (isEmpNotHavingAppListScreenCount) ...[
                IconButton(
                  padding: const EdgeInsets.only(),
                  icon: const Icon(Feather.filter),
                  onPressed: () async {
                    await Get.toNamed(kEmpNotHavingAppRouteCount);

                    // calling get emp not having app list method
                    await EmpNotHavingAppController.to.getEmpNotHavingAppListCount();
                  },
                ),
              ],
              if (isCreateEmpGroupScreen) ...[
                IconButton(
                  padding: const EdgeInsets.only(),
                  icon: const Icon(Feather.filter),
                  onPressed: () async {
                    // calling hit count api method
                    // GailConnectServices.to
                    //     .hitCountApi(activity: kEmployeesAdvanceFilterScreen);

                    await Get.toNamed(kFiltersRoute);

                    // calling get all employees list method
                    await CreateEmpGroupController.to.getEmployeesList();
                  },
                ),
              ],
              if (isBirthdayScreen) ...[
                Visibility(
                  visible: false,
                  child: IconButton(
                    padding: const EdgeInsets.only(),
                    icon: const Icon(Feather.message_circle),
                    onPressed: () async {
                      // calling hit count api method
                      // GailConnectServices.to
                      //     .hitCountApi(activity: kEmployeesAdvanceFilterSceen);
                      var insertEventInstance = MainDashController();
                      // await Get.toNamed(kFiltersRoute);
                      final List<String> _recipients_numbers = [],
                          _recipients_names = [];
                      for (int i = 0;
                          i <
                              MainDashController.to.employeesBirthDayList
                                  .length; //MainDashController().employeesBirthDayList.length;
                          i++) {
                        if (MainDashController
                                .to.employeesBirthDayList[i].mobileNo
                                .toString() !=
                            "") {
                          _recipients_numbers.add(MainDashController
                              .to.employeesBirthDayList[i].mobileNo
                              .toString());
                          _recipients_names.add(MainDashController
                              .to.employeesBirthDayList[i].empName
                              .toString());
                        }
                      }
                      // debugPrint(SharedPrefs.to.userName);
                      // calling get all employees list method
                      await MainDashController.to.sendMessage(
                          recipients: _recipients_numbers,
                          message:
                              "Wishing you a day filled with happiness and a year filled with joy and prosperity. Happy birthday! \n\nRegards,\n" +
                                  MainDashController
                                      .to.loggedInEmployee!.empName! +
                                  "\n" +
                                  MainDashController
                                      .to.loggedInEmployee!.designation
                                      .toString() +
                                  "\n" +
                                  MainDashController
                                      .to.loggedInEmployee!.department
                                      .toString()); //SharedPrefs.to.baName
                    },
                  ),
                ),
              ],
              if (isNewJoinersScreen) ...[
                Visibility(
                  visible: false,
                  child: IconButton(
                    padding: const EdgeInsets.only(),
                    icon: const Icon(Feather.message_circle),
                    onPressed: () async {
                      // calling hit count api method
                      // GailConnectServices.to
                      //     .hitCountApi(activity: kEmployeesAdvanceFilterSceen);
                      var insertEventInstance = MainDashController();
                      // await Get.toNamed(kFiltersRoute);
                      final List<String> _recipients_numbers = [],
                          _recipients_names = [];
                      for (int i = 0;
                      i <
                          MainDashController.to.newEmployeesJoinesList
                              .length; //MainDashController().employeesBirthDayList.length;
                      i++) {
                        if (MainDashController
                            .to.newEmployeesJoinesList[i].mobileNo
                            .toString() !=
                            "") {
                          _recipients_numbers.add(MainDashController
                              .to.newEmployeesJoinesList[i].mobileNo
                              .toString());
                          _recipients_names.add(MainDashController
                              .to.newEmployeesJoinesList[i].empName
                              .toString());
                        }
                      }
                      // debugPrint(SharedPrefs.to.userName);
                 //SharedPrefs.to.baName
                    },
                  ),
                ),
              ],
              if (!isEmpListScreen) ...[
                title == "Cashless Medicine"
                    ? Row(
                        children: [
                          IconButton(
                            padding: const EdgeInsets.only(),
                            icon: Image.asset(
                              kHelp,
                              height: 40,
                              width: 40,
                              color: Colors.white,
                            ), //Icon(Icons.phone_enabled),
                            // calling sync emp list from server method
                            onPressed: () {
                              // launch("tel: +914047476988");
                              counterController.getCallApollo();
                            },
                            // onPressed: () => MainDashController.to.syncEmpListFromServer(),
                          ),
                          IconButton(
                              padding: const EdgeInsets.only(),
                              icon: const Icon(Ionicons.sync_sharp),
                              // calling sync emp list from server method
                              onPressed: () async {
                                await showProgressDialog(Get.context!,
                                    message: kMsgSyncingData);
                                counterController.getDispensaryHistoryList();
                                Get.put(counterController);
                                counterController.onInit();
                                await hideProgressDialog();
                              }),
                        ],
                      )
                    : title == kNews
                        ? Container()
                        : const Image(
                            width: 40,
                            height: 40,
                            image: AssetImage(kIconLogo),
                          ),
                // IconButton(
                //     padding: const EdgeInsets.only(),
                //     icon: const Icon(Ionicons.sync_sharp),
                //     // calling sync emp list from server method
                //     onPressed: () =>
                //         MainDashController.to.syncEmpListFromServer(),
                //   ),
              ],
              horizontalSpace12,
            ],
          );
        });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
