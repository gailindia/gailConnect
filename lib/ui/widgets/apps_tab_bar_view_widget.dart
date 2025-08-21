import 'package:flutter/material.dart';
import 'package:gail_connect/core/controllers/useful_links_controllers/useful_links_controller.dart';
import 'package:gail_connect/ui/screens/pdfviewer.dart';

import 'package:gail_connect/ui/widgets/icon_widget_banner2.dart';

import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';

import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/routes.dart';
import '../styles/color_controller.dart';
import '../styles/text_styles.dart';

class TabBarViewWidget extends StatefulWidget {
  const TabBarViewWidget({Key? key}) : super(key: key);

  @override
  _OrderHistoryViewState createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<TabBarViewWidget>
    with TickerProviderStateMixin {
  late Animation<double> _carouselAnimation;
  late AnimationController _carouselAnimationController,
      _sideDrawerAnimationController;

  @override
  void initState() {
    super.initState();

    // calling init animation controller method
    _initAnimationController();
  }

  _initAnimationController() {
    _sideDrawerAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));

    _carouselAnimationController = AnimationController(
        value: 0.1, vsync: this, duration: const Duration(milliseconds: 1000));

    _carouselAnimation = CurvedAnimation(
        parent: _carouselAnimationController, curve: Curves.easeIn);
  }

  _toggleAnimation() {
    _sideDrawerAnimationController.isDismissed
        ? _sideDrawerAnimationController.forward()
        : _sideDrawerAnimationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    UsefulLinksController usefulLinksController =
        Get.put(UsefulLinksController());
    // final ColorController colorController = Get.put(ColorController());//colorController.

    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 48),
      child: GetBuilder<ColorController>(
        id: "color",
        init: ColorController(),
        builder: (colorController) => Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconWidgetBanner2(
                        scale: _carouselAnimation,
                        title: kSugam,
                        icon: kSugamicon,
                        iconColor: colorController.kPrimaryDarkColor,
                        onTap: () async {
                          await launch(kSugamUrl);
                        },
                        // onTap: () => Get.to(PdfViewer(
                        //   pdfurl: kSugamUrl,
                        //   title: kSugam,
                        //   type: "sugamUrl",
                        // )),
                      ),
                      // IconWidget(
                      //   title: kGailApps,
                      //   icon: AntDesign.appstore1,
                      //   iconColor: kGreenColor,
                      //   scale: _carouselAnimation,
                      //   onTap: () =>
                      //       Get.toNamed(kAppsRoute),
                      // ),
                      IconWidgetBanner2(
                        scale: _carouselAnimation,
                        title: kGailWebsite,
                        icon: kWebsite,
                        iconColor: colorController.kPrimaryDarkColor,
                        onTap: () => Get.to(PdfViewer(
                          pdfurl: kGailWebsiteUrl,
                          title: kGailWebsite,
                          type: "sugamUrl",
                        )),

                        // usefulLinksController.openGailWebsite(),
                      ),
                      // _ItemCard(
                      //     title: kOffices,
                      //     icon: kOfficeIcon,
                      //     iconColor: kFacebookBlueColor,
                      //     onTap: () => Get.toNamed(kOfficeDashRoute)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconWidgetBanner2(
                          scale: _carouselAnimation,
                          title: kMyLibrary,
                          icon: kLibrary,
                          iconColor: colorController.kPrimaryDarkColor,
                          // onTap: () =>
                          // print(
                          //     '$kMyLibraryUrl${trimLeadingZeros(SharedPrefs.to.cpfNumber)}')

                          //     Get.to(PdfViewer(
                          //   pdfurl:
                          //       '$kMyLibraryUrl${trimLeadingZeros(SharedPrefs.to.cpfNumber)}',
                          //   title: kMyLibrary,
                          //   type: "sugamUrl",
                          // )),
                          onTap: () => usefulLinksController
                              .openMyLibrary()), //kBISHelpdeskCallsRoute)),
                      IconWidgetBanner2(
                          scale: _carouselAnimation,
                          title: kGailVoice,
                          icon: kgailvoice,
                          iconColor: colorController.kPrimaryDarkColor,
                          onTap: () {
                            Get.to(PdfViewer(
                              pdfurl: 'https://gailvoice.com/',
                              title: kGAilVoice,
                              type: "sugamUrl",
                            ));
                          }
                          // => Get.toNamed(kGuestHouseRoute)https://gailvoice.com/
                          ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconWidgetBanner2(
                        scale: _carouselAnimation,
                        title: kGailIntranet,
                        icon: kIntranet,
                        iconColor: colorController.kPrimaryDarkColor,
                        // onTap: () {
                        //   Get.to(PdfViewer(
                        //     pdfurl: kGailIntranetUrl,
                        //     title: kGailIntranet,
                        //     type: "sugamUrl",
                        //   ));
                        // }
                        onTap: () => usefulLinksController
                            .openGailIntranet(), //kOtpRoute),kDashboardRoute
                      ),
                      IconWidgetBanner2(
                          scale: _carouselAnimation,
                          title: kGailTenders,
                          icon: kTenders,
                          iconColor: colorController.kPrimaryDarkColor,
                          onTap: () => Get.to(PdfViewer(
                                pdfurl: kGailTendersUrl,
                                title: kGailTenders,
                                type: "sugamUrl",
                              ))
                          // usefulLinksController.openGailTenders()
                          ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width * 0.9,
                      // child:

                     /* IconWidgetBanner2(
                          scale: _carouselAnimation,
                          title: 'Calculator',
                          icon: kCalculatorIcon,
                          iconColor: colorController.kPrimaryDarkColor,
                          onTap: () => Get.toNamed(kCalculatorRoute)),*/
                      IconWidgetBanner2(
                          scale: _carouselAnimation,
                          title: kAppStorename,
                          icon: kAppStoreImage,
                          iconColor: colorController.kPrimaryDarkColor,
                          onTap: () => Get.toNamed(kAppStore)),



                      // const Spacer(),
                    ],
                  ),

                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width * 0.9,
                      // child:
                      IconWidgetBanner2(
                          scale: _carouselAnimation,
                          title: "My Notes",
                          icon: kFeedbackIcon,
                          iconColor: kPrimaryDarkColor,
                          onTap: () => Get.toNamed(kMyNotesRoute)),
                     // kFreshersCategoryRoute, kFreshersGuidebookRoute
                      // onTap: () => Get.toNamed(kFreshersGuidebookRoute)),
                      // _ItemCard(
                      //     title: kFresherZone,
                      //     icon: kFreshManIcon,
                      //     iconColor: kFacebookBlueColor,
                      //     onTap: () => Get.toNamed(kFresherZoneRoute)),

                      // const Spacer(),
                    ],
                  ),*/
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Container(
                  //       width: MediaQuery.of(context).size.width * 0.9,
                  //       child: _ItemCard(
                  //           title: kCalculator,
                  //           onTap: () => Get.toNamed(kCalculatorRoute)),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     _ItemCard(
                  //         title: kDispensary,
                  //         onTap: () => Get.toNamed(kDispensaryDashRoute)),
                  //   ],
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     appBar: PreferredSize(
    //       preferredSize: const Size.fromHeight(kToolbarHeight),
    //       child: Container(
    //         // padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
    //         height: 100,
    //         color: colorController.kPrimaryColor,
    //         child: SafeArea(
    //           child: Column(
    //             // crossAxisAlignment: CrossAxisAlignment.center,

    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: const <Widget>[
    //               TabBar(
    //                 // indicatorPadding: EdgeInsets.fromLTRB(0, 15, 0, 0),
    //                 tabs: [
    //                   Padding(
    //                     padding: EdgeInsets.only(bottom: 1.0),
    //                     child: Center(
    //                         child: Text(kUsefulLinks,
    //                             style: textStyle20Bold2,
    //                             textAlign: TextAlign.center)),
    //                   ),
    //                   Padding(
    //                     padding: EdgeInsets.only(bottom: 1.0),
    //                     child: Text(kUsefulDocuments,
    //                         style: textStyle20Bold2,
    //                         textAlign: TextAlign.center),
    //                   )
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //     body:
    //     TabBarView(
    //       children:
    //       <Widget>[

    // SingleChildScrollView(
    //   padding: const EdgeInsets.only(left: 12, right: 12, bottom: 48),
    //   child: GetBuilder<UsefulLinksController>(
    //     init: UsefulLinksController(),
    //     builder: (_usefulLinksController) => Column(
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
    //               children: [
    //                 _ItemCard(
    //                     title: kHindiShabdavali,
    //                     onTap: () => _usefulLinksController
    //                         .openHindiShabdavali()),
    //                 _ItemCard(
    //                   title: kGailPrashashanikShabadKosh,
    //                   onTap: () => _usefulLinksController
    //                       .openGailPrashashanikShabadKosh(),
    //                 ),
    //               ],
    //             ),
    //             // _ItemCard(
    //             //     title: kDispensary,
    //             //     onTap: () => Get.toNamed(kCalculatorRoute)),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // ),
    //       ],
    //     ),
    //   ),
    // );
  }

  // _showGstInDetails(BuildContext context) {
  //   // final SharedPrefs _sharedPrefs = SharedPrefs.to;
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
  final String icon;
  final Color iconColor;
  final GestureTapCallback? onTap;

  const _ItemCard(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.icon,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      height: _height * 0.22,
      width: title.toString().contains("Zone") ? _width * 0.9 : _width * 0.45,
      // height: _height * 0.22,
      // width: _width * 0.45,
      child: MaterialCard(
        // padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
        onTap: onTap,
        elevation: 8,
        borderRadius: 30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                width: _width * 0.3,
                height: _height * 0.125,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconColor.withOpacity(0.3),
                ),
                // child: FittedBox(
                //   fit: BoxFit.scaleDown,

                child: Transform.scale(
                  scale: icon.toString().contains("freshman")
                      ? 0.5
                      : icon.toString().contains("cashless")
                          ? 1.3
                          : icon.toString().contains("vehicle")
                              ? 1.3
                              : 1,
                  child: Image(
                    color: iconColor,
                    image: AssetImage(icon),
                  ),
                ),
                // ),
              ),
            ),
            /*InitialTextContainer(
              text: title,
              height: 65,
              width: 65,
            ),*/
            verticalSpace12,
            // SizedBox(height: 11),
            // FittedBox(
            //   fit: BoxFit.scaleDown,
            //   child: Container(
            //     width: _width,
            //     height: _height * 0.05,
            //     color: Colors.amber,
            //     child: Center(
            //       child: Text(
            //         title,
            //         style: TextStyle(
            //           // fontSize: Platform.isAndroid ? 0.24.dp : 0.21.dp,
            //           fontSize: MediaQuery.of(context).devicePixelRatio >= 3.0
            //               ? 0.40.dp
            //               : MediaQuery.of(context).devicePixelRatio >= 2.6
            //                   ? 0.24.dp
            //                   : 0.22.dp,
            //           color: kBlackColor,
            //           letterSpacing: 0.55,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  color: Colors.amber,
                  child: Text(title,
                      style: TextStyle(
                        fontSize: 16,
                        // fontSize: Platform.isAndroid ? 0.24.dp : 0.21.dp,
                        // fontSize: MediaQuery.of(context).devicePixelRatio >= 3.0
                        //     ? 0.28.dp
                        //     : MediaQuery.of(context).devicePixelRatio >= 2.6
                        //         ? 0.24.dp
                        //         : 0.22.dp,
                        color: colorController.kBlackColor,
                        letterSpacing: 0.55,
                        fontWeight: FontWeight.w600,
                      ).apply(fontSizeFactor: 1.2),
                      textAlign: TextAlign.center),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
