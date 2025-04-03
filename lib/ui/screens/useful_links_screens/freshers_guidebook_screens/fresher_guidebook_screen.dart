// Created By Amit Jangid 14/09/21

// ignore_for_file: prefer_const_constructors

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/useful_links_controllers/fresher_zone_controller.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:get/get.dart';
import 'package:gail_connect/ui/styles/colors.dart';
import 'package:multiutillib/multiutillib_flutter.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../styles/color_controller.dart';

class FresherGuideBookScreen extends StatelessWidget {
  String type, title;
  FresherGuideBookScreen({Key? key, required this.type, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: colorController.kBgPopupColor,
        appBar: CustomAppBar(title: kWelcomeTrainees),
        body: GetBuilder<FresherZoneController>(
          id: kFresherGuidebook,
          init: FresherZoneController(),
          builder: (_fGbController) {
            return _fGbController.isLoading
                ? const LoadingWidget()
                : Container(
                    // color: Color.fromARGB(255, 210, 210, 210),
                    child: ExpandableTheme(
                      data: ExpandableThemeData(
                        iconPadding: EdgeInsets.only(
                            top: 12,
                            right: MediaQuery.of(context).size.width * 0.06),
                        iconColor: colorController.kPrimaryDarkColor,
                        useInkWell: true,
                        animationDuration: const Duration(milliseconds: 400),
                        // expandIcon: Icons.expand_circle_down_outlined,
                      ),
                      child: ListView(
                        children: [
                          MaterialCard(
                            borderRadius: 12,
                            margin: const EdgeInsets.all(4),
                            padding: const EdgeInsets.all(0),
                            child: TextField(
                              controller: _fGbController.searchTextController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                // border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _fGbController.clearFZ();
                                  },
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                _fGbController.searchFZ(value);
                              },
                            ),
                          ),
                          SizedBox(
                              height: _height * 0.79,
                              child: _fGbController.usersFiltered.isEmpty
                                  ? apiList(_fGbController)
                                  : filteredList(_fGbController))
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  Widget? apiList(FresherZoneController _fGbController) {
    ColorController colorController = Get.put(ColorController());
    return ListView.builder(
      itemCount: _fGbController.fresherzoneList.length,
      itemBuilder: (BuildContext context, int index) {
        return ExpandableNotifier(
          child: Padding(
            padding: EdgeInsets.only(right: 4, left: 4, bottom: 2),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.top,
                        tapBodyToCollapse: true,
                      ),
                      header: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _fGbController.fresherzoneList[index].module
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.apply(
                                            color: colorController
                                                .kPrimaryDarkColor,
                                            fontWeightDelta: 2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      collapsed: Visibility(
                        visible: !_fGbController
                            .fresherzoneList[index].pathToAccess.isNullOrEmpty,
                        child: Container(
                          // color: Colors.amber,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 6,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      // TextSpan(
                                      //   //Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                      //   text: "Path \n",
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .titleMedium
                                      //       ?.apply(
                                      //           // color:
                                      //           //     colorController.kPrimaryDarkColor,
                                      //           fontWeightDelta: 3),
                                      // ),
                                      TextSpan(
                                        //
                                        text: _fGbController
                                            .fresherzoneList[index]
                                            .pathToAccess,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.apply(
                                              // color:
                                              //     colorController.kPrimaryDarkColor,
                                              fontSizeFactor: 1.1,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   flex: 1,
                              //   child: VerticalDivider(
                              //     color: Colors.black,
                              //     thickness: 2,
                              //   ),
                              // ),
                              Expanded(
                                flex: 1,
                                child: Visibility(
                                  visible: !_fGbController
                                      .fresherzoneList[index]
                                      .link
                                      .isNullOrEmpty,
                                  child: Container(
                                    // padding: EdgeInsets.only(
                                    //     right:
                                    //         MediaQuery.of(context).size.width *
                                    //             0.0),
                                    child: InkWell(
                                      onTap: () async {
                                        await launch(_fGbController
                                            .fresherzoneList[index].link
                                            .toString());
                                      },
                                      child: Icon(Icons.info_outline,
                                          color:
                                              colorController.kPrimaryDarkColor,
                                          size: 32),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          for (var _ in Iterable.generate(1))
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Visibility(
                                          visible: !_fGbController
                                              .fresherzoneList[index]
                                              .desc
                                              .isNullOrEmpty,
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  //Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                                  text: "Description \n",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.apply(
                                                          // color:
                                                          //     colorController.kPrimaryDarkColor,
                                                          fontWeightDelta: 3),
                                                ),
                                                TextSpan(
                                                  //
                                                  text: _fGbController
                                                      .fresherzoneList[index]
                                                      .desc,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.apply(
                                                          // color:
                                                          //     colorController.kPrimaryDarkColor,
                                                          fontSizeFactor: 1.1),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        verticalSpace12,
                                        Visibility(
                                          visible: !_fGbController
                                              .fresherzoneList[index]
                                              .pathToAccess
                                              .isNullOrEmpty,
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  //Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                                  text: "Path \n",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium
                                                      ?.apply(
                                                          // color:
                                                          //     colorController.kPrimaryDarkColor,
                                                          fontWeightDelta: 3),
                                                ),
                                                TextSpan(
                                                  //
                                                  text: _fGbController
                                                      .fresherzoneList[index]
                                                      .pathToAccess,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.apply(
                                                          // color:
                                                          //     colorController.kPrimaryDarkColor,
                                                          fontSizeFactor: 1.1),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // verticalSpace12,
                                        // Visibility(
                                        //   visible: !_fGbController
                                        //       .fresherzoneList[index]
                                        //       .link
                                        //       .isNullOrEmpty,
                                        //   child: RichText(
                                        //     text: TextSpan(
                                        //       children: [
                                        //         TextSpan(
                                        //           //Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                        //           text: "Link \n",
                                        //           style: Theme.of(context)
                                        //               .textTheme
                                        //               .titleMedium
                                        //               ?.apply(
                                        //                   // color:
                                        //                   //     colorController.kPrimaryDarkColor,
                                        //                   fontWeightDelta: 3),
                                        //         ),
                                        //         TextSpan(
                                        //             //
                                        //             recognizer:
                                        //                 TapGestureRecognizer()
                                        //                   ..onTap = () async {
                                        //                     await launch(
                                        //                         _fGbController
                                        //                             .fresherzoneList[
                                        //                                 index]
                                        //                             .link
                                        //                             .toString());
                                        //                   },
                                        //             text: "Click Here",
                                        //             style: TextStyle(
                                        //                 color: Colors
                                        //                     .blueAccent)),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Visibility(
                                      visible: !_fGbController
                                          .fresherzoneList[index]
                                          .link
                                          .isNullOrEmpty,
                                      child: InkWell(
                                        onTap: () async {
                                          await launch(_fGbController
                                              .fresherzoneList[index].link
                                              .toString());
                                        },
                                        child: Icon(Icons.info_outline,
                                            color: colorController
                                                .kPrimaryDarkColor,
                                            size: 32),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget filteredList(FresherZoneController _fGbController) {
    ColorController colorController = Get.put(ColorController());
    return ListView.builder(
      itemCount: _fGbController.usersFiltered.length,
      itemBuilder: (BuildContext context, int index) {
        return ExpandableNotifier(
          child: Padding(
            padding: const EdgeInsets.only(right: 4, left: 4, bottom: 2),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.top,
                        tapBodyToCollapse: true,
                      ),
                      header: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: 10, left: 10, right: 10, bottom: 10),
                            // color: Colors.grey[350],
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    _fGbController.usersFiltered[index].module
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.apply(
                                            color: colorController
                                                .kPrimaryDarkColor,
                                            fontWeightDelta: 2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      collapsed: Visibility(
                        visible: !_fGbController
                            .usersFiltered[index].pathToAccess.isNullOrEmpty,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 4, left: 0, right: 0, bottom: 0),
                          // color: Colors.amber,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 6,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      // TextSpan(
                                      //   //Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                      //   text: "Path \n",
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .titleMedium
                                      //       ?.apply(
                                      //           // color:
                                      //           //     colorController.kPrimaryDarkColor,
                                      //           fontWeightDelta: 3),
                                      // ),
                                      TextSpan(
                                        //
                                        text: _fGbController
                                            .usersFiltered[index].pathToAccess,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.apply(
                                              // color:
                                              //     colorController.kPrimaryDarkColor,
                                              fontSizeFactor: 1.1,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Expanded(
                              //   flex: 1,
                              //   child: VerticalDivider(
                              //     color: Colors.black,
                              //     thickness: 2,
                              //   ),
                              // ),
                              Expanded(
                                flex: 1,
                                child: Visibility(
                                  visible: !_fGbController
                                      .usersFiltered[index].link.isNullOrEmpty,
                                  child: InkWell(
                                    onTap: () async {
                                      await launch(_fGbController
                                          .usersFiltered[index].link
                                          .toString());
                                    },
                                    child: Icon(Icons.info_outline,
                                        color:
                                            colorController.kPrimaryDarkColor,
                                        size: 32),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          for (var _ in Iterable.generate(1))
                            Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Visibility(
                                            visible: !_fGbController
                                                .usersFiltered[index]
                                                .desc
                                                .isNullOrEmpty,
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    //Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                                    text: "Description \n",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.apply(
                                                            // color:
                                                            //     colorController.kPrimaryDarkColor,
                                                            fontWeightDelta: 3),
                                                  ),
                                                  TextSpan(
                                                    //
                                                    text: _fGbController
                                                        .usersFiltered[index]
                                                        .desc,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.apply(
                                                            // color:
                                                            //     colorController.kPrimaryDarkColor,
                                                            fontSizeFactor:
                                                                1.1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          verticalSpace12,
                                          Visibility(
                                            visible: !_fGbController
                                                .usersFiltered[index]
                                                .pathToAccess
                                                .isNullOrEmpty,
                                            child: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    //Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                                    text: "Path \n",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium
                                                        ?.apply(
                                                            // color:
                                                            //     colorController.kPrimaryDarkColor,
                                                            fontWeightDelta: 3),
                                                  ),
                                                  TextSpan(
                                                    //
                                                    text: _fGbController
                                                        .usersFiltered[index]
                                                        .pathToAccess,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.apply(
                                                            // color:
                                                            //     colorController.kPrimaryDarkColor,
                                                            fontSizeFactor:
                                                                1.1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // verticalSpace12,
                                          // Visibility(
                                          //   visible: !_fGbController
                                          //       .usersFiltered[index]
                                          //       .link
                                          //       .isNullOrEmpty,
                                          //   child: RichText(
                                          //     text: TextSpan(
                                          //       children: [
                                          //         TextSpan(
                                          //           //Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                                          //           text: "Link \n",
                                          //           style: Theme.of(context)
                                          //               .textTheme
                                          //               .titleMedium
                                          //               ?.apply(
                                          //                   // color:
                                          //                   //     colorController.kPrimaryDarkColor,
                                          //                   fontWeightDelta: 3),
                                          //         ),
                                          //         TextSpan(
                                          //             //
                                          //             recognizer:
                                          //                 TapGestureRecognizer()
                                          //                   ..onTap = () async {
                                          //                     await launch(
                                          //                         _fGbController
                                          //                             .usersFiltered[
                                          //                                 index]
                                          //                             .link
                                          //                             .toString());
                                          //                   },
                                          //             text: "Click Here",
                                          //             style: TextStyle(
                                          //                 color: Colors
                                          //                     .blueAccent)),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Visibility(
                                        visible: !_fGbController
                                            .usersFiltered[index]
                                            .link
                                            .isNullOrEmpty,
                                        child: InkWell(
                                          onTap: () async {
                                            await launch(_fGbController
                                                .usersFiltered[index].link
                                                .toString());
                                          },
                                          child: Icon(Icons.info_outline,
                                              color: colorController
                                                  .kPrimaryDarkColor,
                                              size: 32),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                        ],
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    // return ListView.builder(
    //   itemCount: _fGbController.usersFiltered.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return ExpandableNotifier(
    //       child: Padding(
    //         padding: const EdgeInsets.all(3),
    //         child: Card(
    //           clipBehavior: Clip.antiAlias,
    //           child: Column(
    //             children: <Widget>[
    //               // SizedBox(
    //               //   height: _height * 0.15,
    //               //   child: Container(
    //               //     decoration: BoxDecoration(
    //               //       color: Colors.orange,
    //               //       shape: BoxShape.rectangle,
    //               //     ),
    //               //   ),
    //               // ),
    //               ScrollOnExpand(
    //                 scrollOnExpand: true,
    //                 scrollOnCollapse: false,
    //                 child: ExpandablePanel(
    //                   theme: const ExpandableThemeData(
    //                     headerAlignment: ExpandablePanelHeaderAlignment.top,
    //                     tapBodyToCollapse: true,
    //                   ),
    //                   header: Column(
    //                     children: [
    //                       Padding(
    //                         padding: EdgeInsets.all(10),
    //                         child: Column(
    //                           children: [
    //                             Align(
    //                               alignment: Alignment.centerLeft,
    //                               child: Text(
    //                                 _fGbController.usersFiltered[index].module
    //                                     .toString(),
    //                                 style: Theme.of(context)
    //                                     .textTheme
    //                                     .titleLarge
    //                                     ?.apply(
    //                                         color: colorController.kPrimaryDarkColor,
    //                                         fontWeightDelta: 2),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   collapsed: Visibility(
    //                     visible: !_fGbController
    //                         .usersFiltered[index].pathToAccess.isNullOrEmpty,
    //                     child: RichText(
    //                       text: TextSpan(
    //                         children: [
    //                           TextSpan(
    //                             //Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    //                             text: "Path \n",
    //                             style: Theme.of(context)
    //                                 .textTheme
    //                                 .titleMedium
    //                                 ?.apply(
    //                                     // color:
    //                                     //     colorController.kPrimaryDarkColor,
    //                                     fontWeightDelta: 3),
    //                           ),
    //                           TextSpan(
    //                             //
    //                             text: _fGbController
    //                                 .usersFiltered[index].pathToAccess,
    //                             style: Theme.of(context)
    //                                 .textTheme
    //                                 .bodyText1
    //                                 ?.apply(
    //                                     // color:
    //                                     //     kPrimaryDarkColor,
    //                                     fontSizeFactor: 1.1),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   // Text(
    //                   //   "Path:  " +
    //                   //       _fGbController
    //                   //           .fresherzoneList[index]
    //                   //           .pathToAccess
    //                   //           .toString(),
    //                   //   softWrap: true,
    //                   //   maxLines: 2,
    //                   //   overflow: TextOverflow.ellipsis,
    //                   // ),
    //                   expanded: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: <Widget>[
    //                       for (var _ in Iterable.generate(1))
    //                         Padding(
    //                             padding: EdgeInsets.only(bottom: 10),
    //                             child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 Visibility(
    //                                   visible: !_fGbController
    //                                       .usersFiltered[index]
    //                                       .desc
    //                                       .isNullOrEmpty,
    //                                   child: RichText(
    //                                     text: TextSpan(
    //                                       children: [
    //                                         TextSpan(
    //                                           //Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    //                                           text: "Description \n",
    //                                           style: Theme.of(context)
    //                                               .textTheme
    //                                               .titleMedium
    //                                               ?.apply(
    //                                                   // color:
    //                                                   //     kPrimaryDarkColor,
    //                                                   fontWeightDelta: 3),
    //                                         ),
    //                                         TextSpan(
    //                                           //
    //                                           text: _fGbController
    //                                               .usersFiltered[index].desc,
    //                                           style: Theme.of(context)
    //                                               .textTheme
    //                                               .bodyText1
    //                                               ?.apply(
    //                                                   // color:
    //                                                   //     kPrimaryDarkColor,
    //                                                   fontSizeFactor: 1.1),
    //                                         ),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ),
    //                                 verticalSpace12,
    //                                 Visibility(
    //                                   visible: !_fGbController
    //                                       .usersFiltered[index]
    //                                       .pathToAccess
    //                                       .isNullOrEmpty,
    //                                   child: RichText(
    //                                     text: TextSpan(
    //                                       children: [
    //                                         TextSpan(
    //                                           //Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    //                                           text: "Path \n",
    //                                           style: Theme.of(context)
    //                                               .textTheme
    //                                               .titleMedium
    //                                               ?.apply(
    //                                                   // color:
    //                                                   //     kPrimaryDarkColor,
    //                                                   fontWeightDelta: 3),
    //                                         ),
    //                                         TextSpan(
    //                                           //
    //                                           text: _fGbController
    //                                               .usersFiltered[index]
    //                                               .pathToAccess,
    //                                           style: Theme.of(context)
    //                                               .textTheme
    //                                               .bodyText1
    //                                               ?.apply(
    //                                                   // color:
    //                                                   //     kPrimaryDarkColor,
    //                                                   fontSizeFactor: 1.1),
    //                                         ),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ),
    //                                 verticalSpace12,
    //                                 Visibility(
    //                                   visible: !_fGbController
    //                                       .usersFiltered[index]
    //                                       .link
    //                                       .isNullOrEmpty,
    //                                   child: RichText(
    //                                     text: TextSpan(
    //                                       children: [
    //                                         TextSpan(
    //                                           //Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
    //                                           text: "Link \n",
    //                                           style: Theme.of(context)
    //                                               .textTheme
    //                                               .titleMedium
    //                                               ?.apply(
    //                                                   // color:
    //                                                   //     kPrimaryDarkColor,
    //                                                   fontWeightDelta: 3),
    //                                         ),
    //                                         TextSpan(
    //                                             //
    //                                             recognizer:
    //                                                 TapGestureRecognizer()
    //                                                   ..onTap = () async {
    //                                                     await launch(
    //                                                         _fGbController
    //                                                             .usersFiltered[
    //                                                                 index]
    //                                                             .link
    //                                                             .toString());
    //                                                   },
    //                                             text: "Click Here",
    //                                             style: TextStyle(
    //                                                 color: Colors.blueAccent)
    //                                             // Theme.of(
    //                                             //         context)
    //                                             //     .textTheme
    //                                             //     .bodyText1
    //                                             //     ?.apply(
    //                                             //         // color:
    //                                             //         //     kPrimaryDarkColor,
    //                                             //         fontSizeFactor:
    //                                             //             1.1),
    //                                             ),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ),
    //                                 // RichText(
    //                                 //   text: TextSpan(children: [
    //                                 //     TextSpan(
    //                                 //       style: TextStyle(
    //                                 //           color: _fGbController
    //                                 //                       .fresherzoneList[
    //                                 //                           index]
    //                                 //                       .link
    //                                 //                       .toString() ==
    //                                 //                   "null"
    //                                 //               ? Colors
    //                                 //                   .black87
    //                                 //               : Colors
    //                                 //                   .blue),
    //                                 //       text: _fGbController
    //                                 //                   .fresherzoneList[
    //                                 //                       index]
    //                                 //                   .link
    //                                 //                   .toString() ==
    //                                 //               "null"
    //                                 //           ? "na"
    //                                 //           : "Link",
    //                                 //       recognizer:
    //                                 //           TapGestureRecognizer()
    //                                 //             ..onTap = () {
    //                                 //               launch(
    //                                 //                 _fGbController
    //                                 //                     .fresherzoneList[
    //                                 //                         index]
    //                                 //                     .link
    //                                 //                     .toString(),
    //                                 //               );
    //                                 //             },
    //                                 //     ),
    //                                 //   ],),
    //                                 // ),
    //                                 // Text(
    //                                 //   "Lorem ",
    //                                 //   softWrap: true,
    //                                 //   overflow:
    //                                 //       TextOverflow.fade,
    //                                 // ),
    //                               ],
    //                             )),
    //                     ],
    //                   ),
    //                   builder: (_, collapsed, expanded) {
    //                     return Padding(
    //                       padding:
    //                           EdgeInsets.only(left: 10, right: 10, bottom: 10),
    //                       child: Expandable(
    //                         collapsed: collapsed,
    //                         expanded: expanded,
    //                         theme: const ExpandableThemeData(crossFadePoint: 0),
    //                       ),
    //                     );
    //                   },
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
