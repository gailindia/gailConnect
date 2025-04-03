// Created By Amit Jangid 21/09/21

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'package:gail_connect/ui/screens/id_view_screen.dart';

import 'package:gail_connect/ui/screens/wishlist_screen.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:gail_connect/ui/widgets/circular_network_image_widget.dart';
import 'package:get/get.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';

import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';
import 'package:multiutillib/widgets/rich_text_widgets.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

import '../screens/employee_profile/employee_profile.dart';
import 'custom_dialogs/show_address_dialog_box.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _sideDrawer();
}

class _sideDrawer extends State<SideDrawer>{

  _showGstInDetails(BuildContext context) async{
    SecureSharedPref pref = await SecureSharedPref.getInstance();

    String? _baName = await pref.getString("baName",isEncrypted: true);
    String? _state = await pref.getString("gstLocation",isEncrypted: true);
    String? _gstIn = await pref.getString("gstInNumber",isEncrypted: true);


    // calling show custom general dialog box method
    showCustomGeneralDialogBox(
      context: context,
      title: kMyGst,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichTextWidget(
            caption: kState,
            description: _state!,
            captionStyle: textStyle14Bold,
            descriptionStyle: textStyle14Normal,
          ),
          verticalSpace12,
          RichTextWidget(
            description: _baName!,
            caption: kBusinessArea,
            captionStyle: textStyle14Bold,
            descriptionStyle: textStyle14Normal,
          ),
          verticalSpace12,
          RichTextWidget(
            caption: kGstIn,
            description: _gstIn!,
            captionStyle: textStyle14Bold,
            descriptionStyle: textStyle14Normal,
          ),
        ],
      ),
    );

    /*showCustomDialogBox(
      context,
      title: kMyGst,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichTextWidget(
            caption: kState,
            description: _state,
            captionStyle: textStyle14Bold,
            descriptionStyle: textStyle14Normal,
          ),
          verticalSpace12,
          RichTextWidget(
            description: _baName,
            caption: kBusinessArea,
            captionStyle: textStyle14Bold,
            descriptionStyle: textStyle14Normal,
          ),
          verticalSpace12,
          RichTextWidget(
            caption: kGstIn,
            description: _gstIn,
            captionStyle: textStyle14Bold,
            descriptionStyle: textStyle14Normal,
          ),
        ],
      ),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    MainDashController mainDashController = Get.put(MainDashController());
    ColorController colorController = Get.put(ColorController());
    return SizedBox(
      width: MediaQuery.of(context).size.width * .7, //0.7
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: [0.1, 0.7],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
              colors: [
                colorController.kPrimaryLightColor,
                colorController.kPrimaryColor
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(0),
              topRight: const Radius.circular(14),
              bottomLeft: Radius.circular(0),
              bottomRight: const Radius.circular(0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                child: DrawerHeader(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0.0, 1.0],
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter,
                      colors: [
                        colorController.kPrimaryDarkColor,
                        colorController.kPrimaryColor
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: const Radius.circular(100),
                    ),
                  ),
                  child: GetBuilder<MainDashController>(
                    id: kDashboard,
                    builder: (_empController) {

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: GestureDetector(
                                    onTap: () {
                                      _empController.syncEmpListFromServer();
                                    },
                                    child: const Icon(Icons.sync)),
                              ),
                              const Spacer(),
                              Switch(
                                activeColor: colorController.kPrimaryColor,
                                activeTrackColor: colorController.kBgPopupColor,
                                inactiveThumbColor:
                                colorController.kPrimaryColor,
                                inactiveTrackColor:
                                colorController.kBgPopupColor,
                                splashRadius: 50.0,
                                // boolean variable value
                                value: _empController.isSwitched,
                                // changes the state of the switch
                                onChanged: (value) async{
                                  _empController.toggleSwitch(value);
                                  // await Future.delayed(const Duration(seconds: 1));
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),


                          if (_empController.loggedInEmployee != null &&
                              _empController.loggedInEmployee!.image != null &&
                              _empController
                                  .loggedInEmployee!.image!.isNotEmpty) ...[
                            CircularNetworkImageWidget(
                              errorImageColor: Colors.white,
                              imageHeight: 80,
                              imageWidth: 80,
                              imageUrl: _empController.loggedInEmployee!.image!,
                              onTap: () {

                                Get.toNamed(
                                  kFullImageRoute,
                                  arguments: {
                                    kImage:
                                    _empController.loggedInEmployee!.image!,
                                    kTitle: _empController
                                        .loggedInEmployee!.empName!,
                                  },
                                );
                              },
                            ),
                          ] else ...[
                            Icon(
                              EvilIcons.user,
                              size: 75,
                              color: Colors.black,
                            )

                          ],
                          verticalSpace6,
                          Text(
                            _empController.loggedInEmployee?.empName ?? '',
                            style: GoogleFonts.poppins(
                              textStyle: textStyle16Bold14,
                            ).copyWith(color: colorController.kBlackColor),
                          ),
                          Text(
                            _empController.loggedInEmployee?.designation ?? '',
                            style: GoogleFonts.poppins(
                              textStyle: textStyle12Normalblack,
                            ),
                          ),
                          Visibility(
                            visible: _empController.loggedInEmployee?.emails !=
                                null ||
                                _empController.loggedInEmployee?.emails != "",
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // ignore: prefer_const_constructors
                                Icon(
                                  Icons.email,
                                  size: 12,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),

                                Text(
                                  _empController.loggedInEmployee?.emails ?? '',
                                  style: GoogleFonts.poppins(
                                    textStyle: textStyle12Normalblack,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Visibility(
                            visible: //false,
                            _empController.loggedInEmployee?.telNo !=
                                null ||
                                _empController.loggedInEmployee?.telNo !=
                                    "",
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // ignore: prefer_const_constructors

                                const Icon(
                                  Icons.phone,
                                  size: 12,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                                const SizedBox(
                                  width: 1,
                                ),

                                Text(
                                  _empController.loggedInEmployee?.telNo ?? '',
                                  style: GoogleFonts.poppins(
                                    textStyle: textStyle12Normalblack,
                                  ),
                                ),
                              ],
                            ),
                          ),


                          _empController.loggedInEmployee?.mobileNo == null ||
                              _empController.loggedInEmployee?.mobileNo ==
                                  ""
                              ? Container()
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ignore: prefer_const_constructors

                              const Icon(
                                Icons.phone,
                                size: 12,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              const SizedBox(
                                width: 1,
                              ),
                              Text(
                                _empController
                                    .loggedInEmployee?.mobileNo ??
                                    '',
                                style: GoogleFonts.poppins(
                                  textStyle: textStyle12Normalblack,
                                ),
                              ),
                            ],
                          ),

                        ],
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(),

                    // physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // GestureDetector(
                      //   onTap:(){
                      //     Navigator.pop(context);
                      //     Get.to(EmpAttendanceScreen());
                      //   },
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Padding(
                      //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      //         child: Text(
                      //           kAttendance,
                      //           style: GoogleFonts.poppins(
                      //             textStyle: textStyle14Bold4,
                      //           ),
                      //         ),
                      //       ),
                      //       const Padding(
                      //         padding: EdgeInsets.symmetric(horizontal: 8.0),
                      //         child: Divider(thickness: 0.75, color: kBlackColor),
                      //       ),
                      //       const SizedBox(
                      //         height: 5,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(kProfileSettingsRoute);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                kSettings,
                                style: GoogleFonts.poppins(
                                  textStyle: textStyle14Bold4,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Divider(
                                  thickness: 0.75,
                                  color: colorController.kBlackColor),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Get.to(ProfileScreen());
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                kProfile,
                                style: GoogleFonts.poppins(
                                  textStyle: textStyle14Bold4,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Divider(
                                  thickness: 0.75,
                                  color: colorController.kBlackColor),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // ignore: prefer_const_constructors
                          Get.to(IDViewScreen());
                          // Get.toNamed(kProfileSettingsRoute);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                kIdView,
                                style: GoogleFonts.poppins(
                                  textStyle: textStyle14Bold4,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Divider(
                                  thickness: 0.75,
                                  color: colorController.kBlackColor),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pop(context);
                      //     Get.to(const DependentListScreen());
                      //   },
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Padding(
                      //         padding:
                      //             const EdgeInsets.symmetric(horizontal: 8.0),
                      //         child: Text(kDependentList,
                      //             style: GoogleFonts.poppins(
                      //               textStyle: textStyle14Bold4,
                      //             )),
                      //       ),
                      //       Padding(
                      //         padding:
                      //             const EdgeInsets.symmetric(horizontal: 8.0),
                      //         child: Divider(
                      //             thickness: 0.75,
                      //             color: colorController.kBlackColor),
                      //       ),
                      //       const SizedBox(
                      //         height: 5,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.pop(context);
                          _showGstInDetails(context);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(kGSTNO,
                                  style: GoogleFonts.poppins(
                                    textStyle: textStyle14Bold4,
                                  )),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Divider(
                                  thickness: 0.75,
                                  color: colorController.kBlackColor),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Get.to(const EmpWishesScreen());
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(kwishList,
                                  style: GoogleFonts.poppins(
                                    textStyle: textStyle14Bold4,
                                  )),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Divider(
                                  thickness: 0.75,
                                  color: colorController.kBlackColor),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(kConcent);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                kConcentForm,
                                style: GoogleFonts.poppins(
                                  textStyle: textStyle14Bold4,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Divider(
                                  thickness: 0.75,
                                  color: colorController.kBlackColor),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),

                      ///TODO: Health screen code
                      /* GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(kHealthMed);
                          // Get.toNamed(kOtpRoute);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(kHealth,
                                  style: GoogleFonts.poppins(
                                    textStyle: textStyle14Bold4,
                                  )),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Divider(
                                  thickness: 0.75,
                                  color: colorController.kBlackColor),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
*/
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // Get.toNamed(kDashboardRoute);
                          Get.toNamed(kOtpRoute);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(kDashboard,
                                  style: GoogleFonts.poppins(
                                    textStyle: textStyle14Bold4,
                                  )),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Divider(
                                  thickness: 0.75,
                                  color: colorController.kBlackColor),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),

                      /* GestureDetector(
                        onTap: () {
                          Get.toNamed(kInOutTime);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("In-Out Time",
                                  style: GoogleFonts.poppins(
                                    textStyle: textStyle14Bold4,
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Divider(
                                  thickness: 0.75,
                                  color: colorController.kBlackColor),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                        // Center(
                        //   child: Align(
                        //     alignment: Alignment.centerLeft,
                        //     child: Text(
                        //       "My Attendance",
                        //       style: textStyle14Bold,
                        //     ),
                        //   ),
                        // ),
                      ),*/
                      verticalSpace3,

                      ///TODO:: Notification screen
                      /* GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // Get.toNamed(kNotifyScreenRoute);
                          Get.to(NotificationListScreen());
                          // Get.toNamed(kOtpRoute);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text("Notifications",
                                  style: GoogleFonts.poppins(
                                    textStyle: textStyle14Bold4,
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Divider(
                                  thickness: 0.75,
                                  color: colorController.kBlackColor),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                      */
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  mainDashController.logout();
                                },
                                child: Text(kSignOut,
                                    style: GoogleFonts.poppins(
                                      textStyle: textStyle14Bold4,
                                    ))),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(
                                thickness: 0.75,
                                color: colorController.kBlackColor),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: RawGestureDetector(
                          gestures: {
                            SerialTapGestureRecognizer:
                            GestureRecognizerFactoryWithHandlers<
                                SerialTapGestureRecognizer>(
                                  () => SerialTapGestureRecognizer(),
                                  (SerialTapGestureRecognizer instance) {
                                instance.onSerialTapDown =
                                    (SerialTapDownDetails details) {
                                  if (details.count == 7) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return SimpleDialog(
                                          titlePadding:
                                          const EdgeInsets.all(24.0),
                                          backgroundColor:
                                          colorController.kPrimaryColor,
                                          title: Text(
                                            "",//SharedPrefs.to.notificationTokenId
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              letterSpacing: 0.55,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                };
                              },
                            ),
                          },
                          child:
                          // GetBuilder<AppVersionController>(
                          //     id: kAppVersion,
                          //     init: AppVersionController(),
                          //     builder: (_appVersionController) {
                          //       return
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Text(
                              '$kAppVersion - ${mainDashController.currentAppVersion ?? ''}',
                              style: textStyle12Normalblack,
                            ),
                            // Text("App Version - 2.0.32",
                            //     style: TextStyle(
                            //         fontSize: 10, color: colorController.kBlackColor)),
                          ),
                          // }),
                        ),
                      ),

                      /* ListTile(
                        contentPadding: _listTilePadding,
                        leading: const Icon(
                          Icons.settings,
                          color: colorController.kPrimaryColor,
                        ),
                        title: Transform.translate(
                          offset: Offset(-16, 0),
                          child: const Text(kProfileSettings,
                              style: textStyle16Bold),
                        ),
                        // title:
                        //     const Text(kProfileSettings, style: textStyle16Bold),
                        onTap: () {
                          // calling toggle animation method

                          Get.toNamed(kProfileSettingsRoute);
                        },
                      ),
                      const Divider(height: 1, color: kDarkGreyColor),


                      */ /*if (SharedPrefs.to.isAdmin) ...[
                        ListTile(
                          contentPadding: _listTilePadding,
                          title: const Text(kUtilization, style: textStyle16Normal),
                          onTap: () {
                            // calling toggle animation method
                            _toggleAnimation();

                            Get.toNamed(kUtilizationRoute);
                          },
                        ),
                        const Divider(height: 1, color: kDarkGreyColor),
                        ListTile(
                          contentPadding: _listTilePadding,
                          title: const Text(kEmpNotHavingApp, style: textStyle16Normal),
                          onTap: () {
                            // calling toggle animation method
                            _toggleAnimation();

                            Get.toNamed(kEmpNotHavingAppRoute);
                          },
                        ),
                        const Divider(height: 1, color: kDarkGreyColor),
                      ],*/ /*
                      ListTile(
                        leading: Icon(
                          Icons.access_time_sharp,
                          color: colorController.kPrimaryColor,
                        ),
                        contentPadding: _listTilePadding,
                        title: Transform.translate(
                          offset: Offset(-16, 0),
                          child: Text(
                              '$kLastSyncDate - ${SharedPrefs.to.lastSyncDate}',
                              style: textStyle16Bold),
                        ),
                      ),
                      const Divider(height: 1, color: kDarkGreyColor),
                      RawGestureDetector(
                        gestures: {
                          SerialTapGestureRecognizer:
                          GestureRecognizerFactoryWithHandlers<
                              SerialTapGestureRecognizer>(
                                () => SerialTapGestureRecognizer(),
                                (SerialTapGestureRecognizer instance) {
                              instance.onSerialTapDown =
                                  (SerialTapDownDetails details) {
                                if (details.count == 7) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return SimpleDialog(
                                        titlePadding: const EdgeInsets.all(24.0),
                                        backgroundColor: Colors.blue,
                                        title: Text(
                                          SharedPrefs.to.notificationTokenId,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            letterSpacing: 0.55,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              };
                            },
                          ),
                        },
                        child: GetBuilder<AppVersionController>(
                          id: kAppVersion,
                          init: AppVersionController(),
                          builder: (_appVersionController) =>
                              ListTile(
                                leading: Icon(
                                  Icons.numbers,
                                  color: colorController.kPrimaryColor,
                                ),
                                contentPadding: _listTilePadding,
                                title: Transform.translate(
                                  offset: Offset(-16, 0),
                                  child: Text(
                                    '$kAppVersion - ${_appVersionController
                                        .currentAppVersion ?? ''}',
                                    style: textStyle16Bold,
                                  ),
                                ),
                              ),
                        ),
                      ),
                      const Divider(height: 1, color: kDarkGreyColor),
                      verticalSpace24,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(EmpAttendanceScreen());
                              },
                              child: Container(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.05,
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    stops: [0.1, 0.7],
                                    end: Alignment.bottomLeft,
                                    begin: Alignment.topRight,
                                    colors: [
                                      // colorController.kPrimaryColor,
                                      // colorController.kPrimaryDarkColor
                                      Color.fromARGB(255, 186, 197, 235),
                                      Color.fromARGB(255, 188, 206, 242),
                                      // Color.fromARGB(255, 206, 206, 206),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(14),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(14),
                                  ),
                                ),
                                // height: ,
                                child: Center(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "My Attendance",
                                      style: textStyle14Bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            verticalSpace3
                          ],
                        ),
                      ),
                      GetBuilder<MainDashController>(
                        id: kDashboard,
                        init: MainDashController(),
                        builder: (_sideDrawerController) {
                          return Container(
                            // color: Colors.amber,
                            height: MediaQuery
                                .of(context)
                                .size
                                .height * 1 / 3,
                            child: ListView.builder(
                              itemCount:
                              _sideDrawerController.sideDrawerList.length,
                              padding: const EdgeInsets.only(
                                  left: 6, right: 6, bottom: 48),
                              itemBuilder: (context, _position) {
                                final SideDrawerElements _sideDrawerList =
                                _sideDrawerController
                                    .sideDrawerList[_position];
                                print("SCREEEEN" + _sideDrawerList.screen);
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(_sideDrawerList.screen);
                                      },
                                      child: Container(
                                        height:
                                        MediaQuery
                                            .of(context)
                                            .size
                                            .height *
                                            0.05,
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            stops: [0.1, 0.7],
                                            end: Alignment.bottomLeft,
                                            begin: Alignment.topRight,
                                            colors: [
                                              // colorController.kPrimaryColor,
                                              // kPrimaryDarkColor
                                              Color.fromARGB(255, 186, 197, 235),
                                              Color.fromARGB(255, 188, 206, 242),
                                              // Color.fromARGB(255, 206, 206, 206),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            topRight: Radius.circular(14),
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(14),
                                          ),
                                        ),
                                        // height: ,
                                        child: Center(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              _sideDrawerList.activity,
                                              style: textStyle14Bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    verticalSpace3
                                  ],
                                );
                              },
                            ),
                          );
                          // ListView.builder(
                          //   itemCount: 2,
                          //   // padding: const EdgeInsets.only(
                          //   //     left: 6, right: 6, bottom: 48),
                          //   itemBuilder: (context, _position) {
                          //     final SideDrawerElements _sideDrawerList =
                          //         _sideDrawerController.sideDrawerList[_position];
                          //     return Text("_sideDrawerList.activity");
                          //   },
                          // );
                          // return ListTile(
                          //   contentPadding: _listTilePadding,
                          //   title: Container(
                          //       padding: const EdgeInsets.all(8),
                          //       decoration: const BoxDecoration(
                          //         gradient: LinearGradient(
                          //           stops: [0.1, 0.7],
                          //           end: Alignment.bottomLeft,
                          //           begin: Alignment.topRight,
                          //           colors: [
                          //             Color.fromARGB(255, 228, 223, 208),
                          //             Color.fromARGB(255, 235, 217, 164),
                          //           ],
                          //         ),
                          //         borderRadius: BorderRadius.only(
                          //           topLeft: Radius.circular(0),
                          //           topRight: Radius.circular(0),
                          //           bottomLeft: Radius.circular(0),
                          //           bottomRight: Radius.circular(24),
                          //         ),
                          //       ),
                          //       // color: Color.fromARGB(255, 228, 223, 208),
                          //       child: ListView.builder(
                          //         itemCount:
                          //             _sideDrawerController.sideDrawerList.length,
                          //         padding: const EdgeInsets.only(
                          //             left: 6, right: 6, bottom: 48),
                          //         itemBuilder: (context, _position) {
                          //           final SideDrawerElements _sideDrawer =
                          //               _sideDrawerController
                          //                   .sideDrawerList[_position];

                          //           return Text(_sideDrawer.activity.toString());
                          //           // SlideAnimation(
                          //           //   position: _position,
                          //           //   itemCount: _bannerDetController.bannerDetailsList.length,
                          //           //   animationController: _bannerDetController.animationController,
                          //           //   child: Stack(
                          //           //     children: [
                          //           //       NetworkImageWidget(width: double.infinity, imageUrl: _bannerDetails.image!),
                          //           //       Positioned(
                          //           //         right: 6,
                          //           //         bottom: 0,
                          //           //         child: Container(
                          //           //           padding: const EdgeInsets.all(6),
                          //           //           decoration: const BoxDecoration(
                          //           //             color: Colors.black12,
                          //           //             borderRadius: BorderRadius.only(
                          //           //               topLeft: Radius.circular(6),
                          //           //               topRight: Radius.circular(6),
                          //           //               bottomLeft: Radius.circular(6),
                          //           //               bottomRight: Radius.circular(12),
                          //           //             ),
                          //           //           ),
                          //           //           child: InkWell(
                          //           //             // calling download and share image method
                          //           //             onTap: () => _bannerDetController.downloadAndShareImage(
                          //           //               imageUrl: _bannerDetails.image!,
                          //           //               title: _bannerDetController.screenTitle!,
                          //           //             ),
                          //           //             borderRadius: const BorderRadius.all(Radius.circular(100)),
                          //           //             child: const Icon(MaterialCommunityIcons.share, size: 36),
                          //           //           ),
                          //           //         ),
                          //           //       ),
                          //           //     ],
                          //           //   ),
                          //           // );
                          //         },
                          //       )
                          //       // Text(
                          //       //   '$kAppVersion - ${_appVersionController.currentAppVersion ?? ''}',
                          //       //   style: textStyle16Bold,
                          //       // ),
                          //       ),
                          // );
                        },
                      ),*/
                    ],
                  ),
                ),
              ),
              /*   const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // GetBuilder<AppVersionController>(
                  //   id: kAppVersion,
                  //   init: AppVersionController(),
                  //   builder: (_appVersionController) => ListTile(
                  //     contentPadding: _listTilePadding,
                  //     title: Text(
                  //       '$kAppVersion - ${_appVersionController.currentAppVersion ?? ''}',
                  //       style: textStyle16Normal,
                  //     ),
                  //   ),
                  // ),
                  RawGestureDetector(
                    gestures: {
                      SerialTapGestureRecognizer:
                          GestureRecognizerFactoryWithHandlers<
                              SerialTapGestureRecognizer>(
                        () => SerialTapGestureRecognizer(),
                        (SerialTapGestureRecognizer instance) {
                          instance.onSerialTapDown =
                              (SerialTapDownDetails details) {
                            if (details.count == 7) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                    titlePadding: const EdgeInsets.all(24.0),
                                    backgroundColor:
                                        colorController.kPrimaryColor,
                                    title: Text(
                                      SharedPrefs.to.notificationTokenId,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        letterSpacing: 0.55,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          };
                        },
                      ),
                    },
                    child:
                        // GetBuilder<AppVersionController>(
                        //     id: kAppVersion,
                        //     init: AppVersionController(),
                        //     builder: (_appVersionController) {
                        //       return
                        Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        '$kAppVersion - ${mainDashController.currentAppVersion ?? ''}',
                        style: textStyle12Normalblack,
                      ),
                      // Text("App Version - 2.0.32",
                      //     style: TextStyle(
                      //         fontSize: 10, color: colorController.kBlackColor)),
                    ),
                    // }),
                  ),

                  const SizedBox(
                    height: 5,
                  )
                ],
              )*/
            ],
          ),
        ),
      ),
    );
  }

}
