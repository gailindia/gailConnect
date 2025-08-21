import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/useful_links_controllers/useful_links_controller.dart';

import 'package:gail_connect/ui/widgets/initial_text_container.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/routes.dart';
import '../screens/pdfviewer.dart';
import '../screens/useful_links_screens/e_notesheet_video.dart';
import '../screens/useful_links_screens/holiday_list_screen.dart';
import '../styles/color_controller.dart';
import '../styles/text_styles.dart';
import 'custom_app_bar.dart';
import 'custom_dialogs/show_e-notes_dialog.dart';

class TabBarViewWidget extends StatefulWidget {
  bool isSearch;
  TabBarViewWidget({Key? key, required this.isSearch}) : super(key: key);

  @override
  _OrderHistoryViewState createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<TabBarViewWidget> {
  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    UsefulLinksController usefulLinksController =
        Get.put(UsefulLinksController());
    return widget.isSearch
        ? DefaultTabController(
            length: 1,
            child: Scaffold(
              backgroundColor: colorController.kHomeBgColor,
              appBar: CustomAppBar(title: "Useful Links"),
              body: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 48),
                child: GetBuilder<ColorController>(
                  id: 'color',
                  init: ColorController(),
                  builder: (colorController) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ItemCard(
                                title: kEOffices,
                                icon: kEofficescircle,
                                iconColor: colorController.kPrimaryDarkColor,
                                onTap: () => showENotesDialogBox(
                                  context,
                                  FAQ: 'FAQ',
                                  userManual: 'User Manual',
                                  onPositivePressed: () {
                                    Navigator.pop(context);
                                    Get.to(PdfViewer(
                                      pdfurl:
                                          // 'https://gailebank.gail.co.in/common_api_jai/pdf/E_File_FAQ.pdf',
                                          'https://gailebank.gail.co.in/GAIL_APIs/pdf/E_File_FAQ.pdf',
                                      title: "FAQ",
                                      type: "pdf",
                                    ));
                                  },
                                  onNegativePressed: () {
                                    Navigator.pop(context);
                                    Get.to(PdfViewer(
                                      pdfurl:
                                          // "https://gailebank.gail.co.in/common_api_jai/pdf/E_File_User_Manual.pdf",
                                          "https://gailebank.gail.co.in/GAIL_APIs/pdf/E_File_User_Manual.pdf",
                                      title: "User Manual",
                                      type: "pdf",
                                    ));
                                  },
                                  onVideoPressed: () {
                                    Navigator.pop(context);
                                    Get.to(ENoteSheetVideoListScreen());
                                  },
                                ),
                                // Get.toNamed(kOfficeDashRoute)
                              ),
                              ItemCard(
                                  title: kFresherZone,
                                  icon: knewzone,
                                  iconColor: colorController.kPrimaryDarkColor,
                                  onTap: () =>
                                      Get.toNamed(kFreshersCategoryRoute)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ItemCard(
                                  title: kMMTCODE,
                                  icon: kmmtnew,
                                  iconColor: colorController.kPrimaryDarkColor,
                                  onTap: () {
                                    Get.to(PdfViewer(
                                      pdfurl: kMMTCodeUrl,
                                      title: kMMTCODE,
                                      type: "pdf",
                                    ));
                                  }
                                  // =>
                                  // usefulLinksController.openMMTCODE(),
                                  ),
                              ItemCard(
                                  title: kHindiShabdavali,
                                  icon: kDictionarynew,
                                  iconColor: colorController.kPrimaryDarkColor,
                                  onTap: () {
                                    Get.to(PdfViewer(
                                      pdfurl: kHindiShabdavaliUrl,
                                      title: kHindiShabdavali,
                                      type: "pdf",
                                    ));
                                  }
                                  // => usefulLinksController
                                  //     .openHindiShabdavali()
                                  ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // _ItemCard(
                              //     title: kHindiShabdavali,
                              //     onTap: () => _usefulLinksController
                              //         .openHindiShabdavali()),
                              ItemCard(
                                  title: kGailPrashashanikShabadKosh,
                                  icon: kVoacabulorynew,
                                  iconColor: colorController.kPrimaryDarkColor,
                                  onTap: () {
                                    // kGailPrashashanikShabadKoshUrl
                                    Get.to(PdfViewer(
                                      pdfurl: kGailPrashashanikShabadKoshUrl,
                                      title: kGailPrashashanikShabadKosh,
                                      type: "pdf",
                                    ));
                                  }
                                  //  => usefulLinksController
                                  //     .openGailPrashashanikShabadKosh(),
                                  ),
                              ItemCard(
                                  title: kHolidayList,
                                  icon: kholidaynew,
                                  iconColor: colorController.kPrimaryDarkColor,
                                  onTap: () =>
                                      Get.to(const HolidyListScreen())),
                            ],
                          ),

                          /*Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ItemCard(
                              title: kENoteSheet,
                              icon: kVoacabulory,
                              iconColor: colorController.kPrimaryColor,
                              onTap: () => showENotesDialogBox(
                                context,
                                FAQ: 'FAQ',
                                userManual: 'UserManual',
                                onPositivePressed: () {
                                  Navigator.pop(context);
                                  Get.to(PdfViewer(
                                    pdfurl:
                                        'https://gailebank.gail.co.in/common_api_jai/pdf/E_File_FAQ.pdf',
                                    title: "FAQ",
                                    type: "pdf",
                                  ));
                                },
                                onNegativePressed: () {
                                  Navigator.pop(context);
                                  Get.to(PdfViewer(
                                    pdfurl:
                                        "https://gailebank.gail.co.in/common_api_jai/pdf/E_File_User_Manual.pdf",
                                    title: "User Manual",
                                    type: "pdf",
                                  ));
                                },
                              ),
                            ),
                            // _ItemCard(
                            //     title: kHindiShabdavali,
                            //     onTap: () => _usefulLinksController
                            //         .openHindiShabdavali()),
                            */ /* ItemCard(
                              title: kGailPrashashanikShabadKosh,
                              icon: kDictionary,
                              iconColor: colorController.kPrimaryColor,
                              onTap: () => _usefulLinksController
                                  .openGailPrashashanikShabadKosh(),
                            ),*/ /*
                            // ItemCard(
                            //   title: kMMTCODE,
                            //   icon: kDictionary,
                            //   iconColor: kTwitterBlueColor,
                            //   onTap: () => _usefulLinksController.openMMTCODE(),
                            // ),
                          ],
                        ),*/
                          // _ItemCard(
                          //     title: kHolidayList,
                          //     onTap: () =>
                          //         _usefulLinksController.openHolidayList()),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     _ItemCard(
                          //         title: kBISHelpdesk,
                          //         onTap: () =>
                          //             Get.toNamed(kBISHelpdeskCallsRoute)),
                          //     _ItemCard(
                          //         title: kCalculator,
                          //         onTap: () => Get.toNamed(kCalculatorRoute)),
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     _ItemCard(
                          //         title: kGailWfh,
                          //         onTap: () =>
                          //             _usefulLinksController.openGailWfh()),
                          //     // _ItemCard(
                          //     //     title: kGuestHouses,
                          //     //     onTap: () => Get.toNamed(kGuestHouseRoute)),
                          //   ],
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     // _ItemCard(
                          //     //     title: kDispensary,
                          //     //     onTap: () => Get.toNamed(kDispensaryDashRoute)),

                          //   ],
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : DefaultTabController(
            length: 1,
            child: Scaffold(
              backgroundColor: Colors.transparent,

              /* appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            // padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            height: 100,
            color: colorController.kPrimaryColor,
            child: SafeArea(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,

                mainAxisAlignment: MainAxisAlignment.end,
                children: const <Widget>[
                  TabBar(
                    // indicatorPadding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    tabs: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.0),
                        child: Center(
                            child: Text(kUsefulLinks,
                                style: textStyle20Bold2,
                                textAlign: TextAlign.center)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.0),
                        child: Text(kUsefulDocuments,
                            style: textStyle20Bold2,
                            textAlign: TextAlign.center),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),*/
              body: TabBarView(
                children: <Widget>[
                  SingleChildScrollView(
                    padding:
                        const EdgeInsets.only(left: 12, right: 12, bottom: 48),
                    child: GetBuilder<ColorController>(
                      init: ColorController(),
                      id: 'color',
                      builder: (colorController) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ItemCard(
                                    title: kEOffices,
                                    icon: kEofficescircle,
                                    iconColor:
                                        colorController.kPrimaryDarkColor,
                                    onTap: () => showENotesDialogBox(
                                      context,
                                      FAQ: 'FAQ',
                                      userManual: 'User Manual',
                                      onPositivePressed: () {
                                        Navigator.pop(context);
                                        Get.to(PdfViewer(
                                          pdfurl:
                                              // 'https://gailebank.gail.co.in/common_api_jai/pdf/E_File_FAQ.pdf',
                                              'https://gailebank.gail.co.in/GAIL_APIs/pdf/E_File_FAQ.pdf',
                                          title: "FAQ",
                                          type: "pdf",
                                        ));
                                      },
                                      onNegativePressed: () {
                                        Navigator.pop(context);
                                        Get.to(PdfViewer(
                                          pdfurl:
                                              // "https://gailebank.gail.co.in/common_api_jai/pdf/E_File_User_Manual.pdf",
                                              "https://gailebank.gail.co.in/GAIL_APIs/pdf/E_File_User_Manual.pdf",
                                          title: "User Manual",
                                          type: "pdf",
                                        ));
                                      },
                                      onVideoPressed: () {
                                        Navigator.pop(context);
                                        Get.to(ENoteSheetVideoListScreen());
                                      },
                                    ),

                                    // Get.toNamed(kOfficeDashRoute)
                                  ),
                                  ItemCard(
                                      title: kFresherZone,
                                      icon: knewzone,
                                      iconColor:
                                          colorController.kPrimaryDarkColor,
                                      onTap: () =>
                                          Get.toNamed(kFreshersCategoryRoute)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ItemCard(
                                      title: kMMTCODE,
                                      icon: kmmtnew,
                                      iconColor:
                                          colorController.kPrimaryDarkColor,
                                      onTap: () {
                                        Get.to(PdfViewer(
                                          pdfurl: kMMTCodeUrl,
                                          title: kMMTCODE,
                                          type: "pdf",
                                        ));
                                      }
                                      // =>
                                      //     usefulLinksController.openMMTCODE(),
                                      ),
                                  ItemCard(
                                      title: kHindiShabdavali,
                                      icon: kDictionarynew,
                                      iconColor:
                                          colorController.kPrimaryDarkColor,
                                      onTap: () {
                                        Get.to(PdfViewer(
                                          pdfurl: kHindiShabdavaliUrl,
                                          title: kHindiShabdavali,
                                          type: "pdf",
                                        ));
                                      }
                                      // => usefulLinksController
                                      // .openHindiShabdavali()),
                                      )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // _ItemCard(
                                  //     title: kHindiShabdavali,
                                  //     onTap: () => _usefulLinksController
                                  //         .openHindiShabdavali()),
                                  ItemCard(
                                      title: kGailPrashashanikShabadKosh,
                                      icon: kVoacabulorynew,
                                      iconColor:
                                          colorController.kPrimaryDarkColor,
                                      onTap: () {
                                        Get.to(PdfViewer(
                                          pdfurl:
                                              kGailPrashashanikShabadKoshUrl,
                                          title: kGailPrashashanikShabadKosh,
                                          type: "pdf",
                                        ));
                                      }
                                      // => usefulLinksController
                                      //     .openGailPrashashanikShabadKosh(),
                                      ),
                                  ItemCard(
                                      title: kHolidayList,
                                      icon: kholidaynew,
                                      iconColor:
                                          colorController.kPrimaryDarkColor,
                                      onTap: () =>
                                          Get.to(const HolidyListScreen())),
                                ],
                              ),
                              /*Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ItemCard(
                              title: kENoteSheet,
                              icon: kVoacabulory,
                              iconColor: kPrimaryColor,
                              onTap: () => showENotesDialogBox(
                                context,
                                FAQ: 'FAQ',
                                userManual: 'UserManual',
                                onPositivePressed: () {
                                  Navigator.pop(context);
                                  Get.to(PdfViewer(
                                    pdfurl:
                                        'https://gailebank.gail.co.in/common_api_jai/pdf/E_File_FAQ.pdf',
                                    title: "FAQ",
                                    type: "pdf",
                                  ));
                                },
                                onNegativePressed: () {
                                  Navigator.pop(context);
                                  Get.to(PdfViewer(
                                    pdfurl:
                                        "https://gailebank.gail.co.in/common_api_jai/pdf/E_File_User_Manual.pdf",
                                    title: "User Manual",
                                    type: "pdf",
                                  ));
                                },
                              ),
                            ),
                            // _ItemCard(
                            //     title: kHindiShabdavali,
                            //     onTap: () => _usefulLinksController
                            //         .openHindiShabdavali()),
                            */ /* ItemCard(
                              title: kGailPrashashanikShabadKosh,
                              icon: kDictionary,
                              iconColor: kPrimaryColor,
                              onTap: () => _usefulLinksController
                                  .openGailPrashashanikShabadKosh(),
                            ),*/ /*
                            // ItemCard(
                            //   title: kMMTCODE,
                            //   icon: kDictionary,
                            //   iconColor: kTwitterBlueColor,
                            //   onTap: () => _usefulLinksController.openMMTCODE(),
                            // ),
                          ],
                        ),*/
                              // _ItemCard(
                              //     title: kHolidayList,
                              //     onTap: () =>
                              //         _usefulLinksController.openHolidayList()),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //   children: [
                              //     _ItemCard(
                              //         title: kBISHelpdesk,
                              //         onTap: () =>
                              //             Get.toNamed(kBISHelpdeskCallsRoute)),
                              //     _ItemCard(
                              //         title: kCalculator,
                              //         onTap: () => Get.toNamed(kCalculatorRoute)),
                              //   ],
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //   children: [
                              //     _ItemCard(
                              //         title: kGailWfh,
                              //         onTap: () =>
                              //             _usefulLinksController.openGailWfh()),
                              //     // _ItemCard(
                              //     //     title: kGuestHouses,
                              //     //     onTap: () => Get.toNamed(kGuestHouseRoute)),
                              //   ],
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     // _ItemCard(
                              //     //     title: kDispensary,
                              //     //     onTap: () => Get.toNamed(kDispensaryDashRoute)),

                              //   ],
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  /*     SingleChildScrollView(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 48),
              child: GetBuilder<UsefulLinksController>(
                init: UsefulLinksController(),
                builder: (_usefulLinksController) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ItemCard(
                                title: kHindiShabdavali,
                                icon: kVoacabulory,
                                iconColor: colorController.kPrimaryColor,
                                onTap: () => _usefulLinksController
                                    .openHindiShabdavali()),
                            // _ItemCard(
                            //     title: kHindiShabdavali,
                            //     onTap: () => _usefulLinksController
                            //         .openHindiShabdavali()),
                            ItemCard(
                              title: kGailPrashashanikShabadKosh,
                              icon: kDictionary,
                              iconColor: colorController.kPrimaryColor,
                              onTap: () => _usefulLinksController
                                  .openGailPrashashanikShabadKosh(),
                            ),
                            // ItemCard(
                            //   title: kMMTCODE,
                            //   icon: kDictionary,
                            //   iconColor: kTwitterBlueColor,
                            //   onTap: () => _usefulLinksController.openMMTCODE(),
                            // ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          // padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                          width: MediaQuery.of(context).size.width * 0.9,
                          child:
                          // _ItemCard(
                          //   title: kGailATCalender,
                          //   onTap: () => _usefulLinksController.openGailATC(),
                          // ),
                          ItemCard(
                            title: kMMTCODE,
                            icon: kDictionary,
                            iconColor: colorController.kPrimaryColor,
                            onTap: () => _usefulLinksController.openMMTCODE(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),*/
                ],
              ),
            ),
          );
  }

  // _showGstInDetails(BuildContext context) {
  //   final SharedPrefs _sharedPrefs = SharedPrefs.to;
  //
  //   final String _baName = _sharedPrefs.baName;
  //   final String _state = _sharedPrefs.gstLocation;
  //   final String _gstIn = _sharedPrefs.gstInNumber;
  //
  //   // calling show custom general dialog box method
  //   showCustomGeneralDialogBox(
  //     context: context,
  //     title: kMyGst,
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         RichTextWidget(
  //           caption: kState,
  //           description: _state,
  //           captionStyle: textStyle14Bold,
  //           descriptionStyle: textStyle14Normal,
  //         ),
  //         verticalSpace12,
  //         RichTextWidget(
  //           description: _baName,
  //           caption: kBusinessArea,
  //           captionStyle: textStyle14Bold,
  //           descriptionStyle: textStyle14Normal,
  //         ),
  //         verticalSpace12,
  //         RichTextWidget(
  //           caption: kGstIn,
  //           description: _gstIn,
  //           captionStyle: textStyle14Bold,
  //           descriptionStyle: textStyle14Normal,
  //         ),
  //       ],
  //     ),
  //   );
  //
  //   /*showCustomDialogBox(
  //     context,
  //     title: kMyGst,
  //     content: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         RichTextWidget(
  //           caption: kState,
  //           description: _state,
  //           captionStyle: textStyle14Bold,
  //           descriptionStyle: textStyle14Normal,
  //         ),
  //         verticalSpace12,
  //         RichTextWidget(
  //           description: _baName,
  //           caption: kBusinessArea,
  //           captionStyle: textStyle14Bold,
  //           descriptionStyle: textStyle14Normal,
  //         ),
  //         verticalSpace12,
  //         RichTextWidget(
  //           caption: kGstIn,
  //           description: _gstIn,
  //           captionStyle: textStyle14Bold,
  //           descriptionStyle: textStyle14Normal,
  //         ),
  //       ],
  //     ),
  //   );*/
  // }

  openLink({String? title, String? link}) async {
    await launch(link!);

    // GailConnectServices.to.hitCountApi(activity: title!);
  }
}

class _ItemCard extends StatelessWidget {
  final String title;
  final GestureTapCallback? onTap;

  const _ItemCard({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      height: _height * 0.23,
      width: _width * 0.45,
      child: MaterialCard(
        // padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        onTap: onTap,
        elevation: 10,
        borderRadius: 30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InitialTextContainer(
              text: title,
              height: 65,
              width: 65,
            ),
            // horizontalSpace12,
            verticalSpace18,
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                title,
                style: textStyle18Bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String title;
  final String icon;
  final Color iconColor;
  final GestureTapCallback? onTap;

  const ItemCard(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.icon,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("ICON: " + icon.toString());
    const _borderRadius = BorderRadius.all(Radius.circular(12)); //12
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      height: _height * 0.23,
      width: _width * 0.45,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          // padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: _width * 0.3,
                height: _height * 0.125,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  shape: BoxShape.circle,
                  color: colorController.kCircleBgColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 30, //12
                      spreadRadius: 100,
                      color: iconColor.withOpacity(0.05),
                    ) //0.2
                  ],
                ),
                // decoration: BoxDecoration(
                //   // color: Colors.black12,
                //   shape: BoxShape.circle,
                //   borderRadius: _borderRadius,
                //   boxShadow: [
                //     BoxShadow(
                //       blurRadius: 30, //12
                //       spreadRadius: 0,
                //       color: iconColor.withOpacity(0.4),
                //     ) //0.2
                //   ],
                // ),
                child: Transform.scale(
                  scale: icon.toString().contains("wfh")
                      ? 1.7
                      : icon.toString().contains("tender")
                          ? 1.3
                          : icon.toString().contains("gstin")
                              ? 1.8
                              : icon.toString().contains("holiday")
                                  ? 1.3
                                  : 1,
                  child: Image(
                    color: iconColor,
                    image: AssetImage(icon),
                  ),
                ),
                // Image(height: 40, color: iconColor, image: AssetImage(icon)),
              ),

              /*InitialTextContainer(
                text: title,
                height: 65,
                width: 65,
              ),*/
              // horizontalSpace12,
              SizedBox(height: 11),
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(title,
                      style: TextStyle(
                        fontSize: 14,
                        // fontSize: Platform.isAndroid ? 0.24.dp : 0.21.dp,
                        // fontSize: MediaQuery.of(context).devicePixelRatio >= 3.0
                        //     ? 0.28.dp
                        //     : MediaQuery.of(context).devicePixelRatio >= 2.6
                        //         ? 0.24.dp
                        //         : 0.22.dp,
                        color: colorController.kBlackColor,
                        letterSpacing: 0.55,
                        fontWeight: FontWeight.w600,
                      ).apply(fontSizeFactor: 0.95),
                      textAlign: TextAlign.center)
                  // Text(
                  //   title,
                  //   style: textStyle18Bold,
                  // ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
