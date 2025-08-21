import 'package:flutter/material.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:gail_connect/core/controllers/useful_links_controllers/fresher_category_controller.dart';

import 'package:gail_connect/ui/widgets/icon_widget_banner3.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

import 'package:get/get.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:multiutillib/multiutillib.dart';

import '../../../styles/color_controller.dart';

class FresherCategoryScreen extends StatelessWidget {
  const FresherCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    return Scaffold(
      backgroundColor: colorController.kBgPopupColor,
      appBar: CustomAppBar(title: kWelcomeTrainees),
      body: SingleChildScrollView(
        child: GetBuilder<FresherCategoryController>(
          init: FresherCategoryController(),
          builder: (_fresherCategoryController) {
            int count = 1;
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 12, left: 12),
                  // color: Color.fromARGB(255, 210, 210, 210),
                  child: MaterialCard(
                    borderRadius: 12,
                    margin: const EdgeInsets.only(
                        right: 4, left: 4, top: 10, bottom: 4),
                    padding: const EdgeInsets.only(right: 0, left: 0, top: 0),
                    child: GestureDetector(
                      onTap: () => //Get.toNamed(kFreshersGuidebookRoute),
                          Get.toNamed(kFreshersGuidebookRoute, arguments: [
                        "type",
                        "search", "Search",
                        // toStringAsFixed(0)
                      ]),
                      child: TextField(
                        // controller: _fGbController.searchTextController,
                        keyboardType: null, //TextInputType.text,
                        enabled: false,
                        // enableInteractiveSelection:
                        //     false, // will disable paste operation
                        // focusNode: new AlwaysDisabledFocusNode(),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          // border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              // _fGbController.clearFZ();
                            },
                            child: Icon(
                              Icons.clear,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          // _fGbController.searchFZ(value);
                        },
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    // Text("data"),
                    // Text("Hello"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // IconWidget(
                        //   title: kGailApps,
                        //   icon: AntDesign.appstore1,
                        //   iconColor: kGreenColor,
                        //   scale: _carouselAnimation,
                        //   onTap: () =>
                        //       Get.toNamed(kAppsRoute),
                        // ),
                        IconWidgetBanner3(
                          ///////////////////////////////////////////////
                          title: "Employee Services",
                          icon: Icon(
                            Icons.people_sharp,
                            color: colorController.kPrimaryDarkColor,
                            size: 42,
                          ),
                          iconColor: colorController.kPrimaryColor,
                          // icon: const Icon(
                          //   Icons.currency_rupee,
                          //   color: Colors.limeAccent,
                          //   size: 42,
                          // ),
                          // iconColor: kPurpleColor,
                          onTap: () => //Get.toNamed(kFreshersGuidebookRoute),
                              Get.toNamed(kFreshersGuidebookRoute, arguments: [
                            "type",
                            "services",
                            "Employee Services"
                            // toStringAsFixed(0)
                          ]),
                        ),
                        // _ItemCard(
                        //     title: kOffices,
                        //     icon: kOfficeIcon,
                        //     iconColor: kFacebookBlueColor,
                        //     onTap: () => Get.toNamed(kOfficeDashRoute)),
                        IconWidgetBanner3(
                          title: "Claims",
                          icon: Icon(
                            Icons.currency_rupee,
                            color: colorController.kPrimaryDarkColor,
                            size: 42,
                          ),
                          iconColor: colorController.kPrimaryColor,
                          // icon: const Icon(
                          //   Icons.plagiarism_outlined,
                          //   color: Colors.green,
                          //   size: 42,
                          // ),
                          // iconColor: kTwitterBlueColor,
                          onTap: () => Get.toNamed(
                            kFreshersGuidebookRoute,
                            arguments: [
                              "type",
                              "claim",
                              "Claims"
                              // toStringAsFixed(0)
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // IconWidget(
                        //   title: kGailApps,
                        //   icon: AntDesign.appstore1,
                        //   iconColor: kGreenColor,
                        //   scale: _carouselAnimation,
                        //   onTap: () =>
                        //       Get.toNamed(kAppsRoute),
                        // ),
                        IconWidgetBanner3(
                          title: "Medical",
                          icon: Icon(
                            Icons.medical_services,
                            color: colorController.kPrimaryDarkColor,
                            size: 42,
                          ),
                          iconColor: colorController.kPrimaryColor,
                          onTap: () => //Get.toNamed(kFreshersGuidebookRoute),
                              Get.toNamed(kFreshersGuidebookRoute, arguments: [
                            "type",
                            "medical",
                            "Medical"
                            // toStringAsFixed(0)
                          ]),
                        ),
                        // _ItemCard(
                        //     title: kOffices,
                        //     icon: kOfficeIcon,
                        //     iconColor: kFacebookBlueColor,
                        //     onTap: () => Get.toNamed(kOfficeDashRoute)),
                        IconWidgetBanner3(
                          title: "Allowances",
                          icon: Icon(
                            Icons.currency_rupee,
                            color: colorController.kPrimaryDarkColor,
                            size: 42,
                          ),
                          iconColor: colorController.kPrimaryColor,
                          // icon: const Icon(
                          //   Icons.content_paste_go_sharp,
                          //   color: Colors.red,
                          //   size: 42,
                          // ),
                          // iconColor: kYellowColor, //kPurpleColor,
                          onTap: () => Get.toNamed(
                            kFreshersGuidebookRoute,
                            arguments: [
                              "type",
                              "allowance",
                              "Allowances"
                              // toStringAsFixed(0)
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // IconWidget(
                        //   title: kGailApps,
                        //   icon: AntDesign.appstore1,
                        //   iconColor: kGreenColor,
                        //   scale: _carouselAnimation,
                        //   onTap: () =>
                        //       Get.toNamed(kAppsRoute),
                        // ),
                        IconWidgetBanner3(
                          title: "Advances",
                          icon: Icon(
                            Icons.currency_rupee,
                            color: colorController.kPrimaryDarkColor,
                            size: 42,
                          ),
                          iconColor: colorController.kPrimaryColor,
                          onTap: () => //Get.toNamed(kFreshersGuidebookRoute),
                              Get.toNamed(kFreshersGuidebookRoute, arguments: [
                            "type",
                            "advance",
                            "Advances"
                            // toStringAsFixed(0)
                          ]),
                        ),
                        // _ItemCard(
                        //     title: kOffices,
                        //     icon: kOfficeIcon,
                        //     iconColor: kFacebookBlueColor,
                        //     onTap: () => Get.toNamed(kOfficeDashRoute)),
                        IconWidgetBanner3(
                          title: "Policy Documents",
                          icon: Icon(
                            Icons.plagiarism_outlined,
                            color: colorController.kPrimaryDarkColor,
                            size: 42,
                          ),
                          iconColor: colorController.kPrimaryLightColor,
                          onTap: () => Get.toNamed(
                            kFreshersGuidebookRoute,
                            arguments: [
                              "type",
                              "policy",
                              "Policy Documents"
                              // toStringAsFixed(0)
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconWidgetBanner3(
                          title: "Miscellaneous",
                          icon: Icon(
                            Icons.auto_awesome_mosaic_outlined,
                            color: colorController.kPrimaryDarkColor,
                            size: 42,
                          ),
                          iconColor: colorController.kPrimaryColor,
                          onTap: () =>
                              Get.toNamed(kFreshersGuidebookRoute, arguments: [
                            "type",
                            "miscellaneous",
                            "Miscellaneous"
                            // toStringAsFixed(0)
                          ]),
                        ),
                        // _ItemCard(
                        //     title: kOffices,
                        //     icon: kOfficeIcon,
                        //     iconColor: kFacebookBlueColor,
                        //     onTap: () => Get.toNamed(kOfficeDashRoute)),
                        // IconWidgetBanner3(
                        //     title: kVehicleSearch,
                        //     icon: kVehicle,
                        //     iconColor: kTwitterBlueColor,
                        //     onTap: () => Get.toNamed(kVehicleSearchRoute)),
                      ],
                    ),
                  ],
                ),
                // Container(
                //   // color: Colors.blue,
                //   child: ListView.builder(
                //     itemCount: count,
                //     itemBuilder: (context, _position) {
                //       return Container(
                //         // color: Colors.amber,
                //         child:
                //       );
                //     },
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
