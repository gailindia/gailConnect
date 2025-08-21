import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/app_store_controller.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';

import 'package:gail_connect/ui/widgets/custom_app_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AppStoreScreen extends StatelessWidget {
  const AppStoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kHomeBgColor,
      appBar: CustomAppBar(title: 'App Store'),
      body: GetBuilder<AppStoreController>(
          init: AppStoreController(),
          id: 'appStore',
          builder: (_appStoreController) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: _appStoreController.appStoreList.length,
                shrinkWrap: true,
                // padding:
                //     const EdgeInsets.only(left: 12, right: 12, bottom: 36),
                itemBuilder: (context, _position) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Row(children: [
                          Text(
                            _appStoreController.appStoreList[_position].name
                                .toString(),
                            style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 14,
                              // letterSpacing: 2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () async {
                              String url;
                              if (Platform.isAndroid) {
                                url = _appStoreController
                                    .appStoreList[_position].android
                                    .toString();
                              } else {
                                url = _appStoreController
                                    .appStoreList[_position].ios
                                    .toString();
                              }
                              print(url);
                              await launchUrl(Uri.parse(url));
                              // if (url.contains('manifest')) {
                              //   showCustomDialogAcknowledge(context,
                              //       title: kWarning,
                              //       description:
                              //           'Not a valid link. \n Kindly contact BIS Team',
                              //       onNegativePressed: () {},
                              //       onPositivePressed: () {
                              //     Navigator.pop(context);
                              //   });
                              //   print('not valid url');
                              // } else {
                              //   await launch(url);
                              // }
                            },
                            child: const Icon(
                              Icons.cloud_download,
                              color: Colors.black54,
                            ),
                          ),
                        ]),
                      ),
                      Divider(
                          height: 2, color: colorController.kPrimaryDarkColor),
                    ],
                  );
                },
              ),
            );
          }),
    );
  }
}
