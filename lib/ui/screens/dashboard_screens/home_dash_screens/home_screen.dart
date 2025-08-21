/*
   * -----------------!! Created by Himanshu Shukla !!-----------------------
   *  ---------------- All Rights reserved for Gail India--------------------
   */
import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gail_connect/main.dart';

import 'package:gail_connect/ui/screens/pdfviewer.dart';
import 'package:gail_connect/ui/screens/search.dart';
import 'package:gail_connect/ui/widgets/text_widget.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../../config/routes.dart';
import '../../../../core/controllers/main_dash_controller.dart';
import '../../../../core/controllers/step_controller.dart';
import '../../../../models/active_news.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../styles/color_controller.dart';
import '../../../styles/text_styles.dart';
import '../../../widgets/carousel_widget.dart';

import '../../../widgets/network_image_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with WidgetsBindingObserver {
  _searchBar(BuildContext context, MainDashController mainDashController) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: GestureDetector(
        onTap: () async {
          final searchText = await showSearch<String>(
            context: context,
            delegate: //CustomDelegate(),
                SearchWithSuggestionDelegate(
                    onSearchChanged: _getRecentSearchesLike,
                    mostUsedList: mainDashController.mostUsedListRevised),
            // await _saveToRecentSearches(searchText);
          );
          await _saveToRecentSearches(searchText);
          mainDashController.openScreen(searchText, context);
        },
        child: Container(
          // width: 333,s
          height: 32,
          decoration: ShapeDecoration(
            color: Color(0xFFE8DFDF),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.25, color: Color(0xFFE8DFDF)),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              Text(
                "Search",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<String>> _getRecentSearchesLike(String query) async {
    final pref = await SharedPreferences.getInstance();
    final allSearches = pref.getStringList("recentSearches");
    return allSearches!.where((search) => search.startsWith(query)).toList();
  }

  Future<void> _saveToRecentSearches(String? searchText) async {
    if (searchText == null) return; //Should not be null
    final pref = await SharedPreferences.getInstance();

    //Use `Set` to avoid duplication of recentSearches
    //Use `Set` to avoid duplication of recentSearches
    List<String>? s = (await pref.getStringList("recentSearches"));
    Set<String> allSearches = s?.toSet() ?? {};

    //Place it at first in the set
    allSearches = {searchText, ...allSearches};
    pref.setStringList("recentSearches", allSearches.toList());
  }

  late final WebViewController _controller;
  late final WebViewController _controllerAssets;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (Platform.isAndroid) {
        checkPermissionStatus();
      }
    }
  }

  @override
  void initState() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    print("INIT STATE");

    controller
      ?..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          // onWebResourceError: (WebResourceError error) {
          //
          // },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/') ||
                request.url.contains(".nic")) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {},
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {},
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));

    // #docregion platform_features

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(true);
    }

    // #enddocregion platform_features

    _controller = controller;
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void checkPermissionStatus() async {
    var statusNoti = await Permission.notification.status;
    var statusActvity = await Permission.activityRecognition.status;
    if (statusNoti != PermissionStatus.granted &&
        statusActvity != PermissionStatus.granted) {
      // await initializeService();
    } else {
      // await initializeService();
    }
  }

  @override
  Widget build(BuildContext context) {
    // ColorController colorController = Get.put(ColorController());
    StepController stepController = Get.put(StepController());

    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: GetBuilder<MainDashController>(
          id: kDashboard,
          builder: (_mainDashController) {
            log("msg banner img ${_mainDashController.image}");
            return GetBuilder<ColorController>(
                id: kDashboard,
                builder: (colorController) {
                  return SingleChildScrollView(
                    controller: _mainDashController.scrollController,
                    child: Column(
                      children: [
                        _searchBar(context, _mainDashController),
                        _mainDashController.bannersList.isEmpty
                            ? Container()
                            : _mainDashController.bannersList.length > 1
                                ? Container(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 0, left: 8, right: 8),
                                    margin: const EdgeInsets.all(0),
                                    height: _height * .25,
                                    width: double.infinity,
                                    child: CarouselSlider(
                                      options: CarouselOptions(
                                        viewportFraction: 1,
                                        autoPlay: true,
                                        autoPlayInterval:
                                            const Duration(seconds: 3),
                                      ),
                                      items:
                                          _mainDashController.bannersList.map(
                                        (i) {
                                          return Builder(
                                            builder: (BuildContext context) {
                                              return NetworkImageWidget(
                                                fit: BoxFit.fill,
                                                //fitWidth,
                                                width: double.infinity,

                                                imageUrl:
                                                    "https://gailebank.gail.co.in/Webservices/GAIl_EMP/BannerImages/" +
                                                        i.image.toString(),
                                                // imageUrl: 'https://gailebank.gail.co.in/Webservices/GAIl_EMP/BannerImages/Diwali.JPG',
                                                onTap: () => i.image
                                                        .toString()
                                                        .contains("heic")
                                                    ? () {}
                                                    : i.linkType == "FEST"
                                                        ? Get.toNamed(
                                                            kBannerDetailsRoute,
                                                            arguments: {
                                                              kTitle: i
                                                                  .bannerTitle
                                                                  .toString(),
                                                              kSerialNo:
                                                                  i.serialNo
                                                            },
                                                          )
                                                        : i.linkType == "HEIC"
                                                            ? () {}
                                                            : _mainDashController
                                                                .openBanner(i
                                                                    .linkURL
                                                                    .toString()),
                                              );
                                            },
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  )
                                : Container(
                                    // color: Colors.amber,
                                    padding: const EdgeInsets.only(
                                        top: 0, left: 8, right: 8, bottom: 0),
                                    margin: const EdgeInsets.all(0),
                                    height: _height * .25,
                                    width: double.infinity,
                                    child: NetworkImageWidget(
                                      fit: BoxFit.fill,
                                      //fitWidth,
                                      width: double.infinity,
                                      imageUrl:
                                          "https://gailebank.gail.co.in/Webservices/GAIl_EMP/BannerImages/" +
                                              _mainDashController.image,
                                      // imageUrl: 'https://gailebank.gail.co.in/Webservices/GAIl_EMP/BannerImages/Diwali.JPG',
                                      onTap: () => _mainDashController
                                              .bannersList[0].image
                                              .toString()
                                              .contains("heic")
                                          ? () {}
                                          : _mainDashController.bannersList[0]
                                                      .linkType ==
                                                  // i.linkType ==
                                                  "FEST"
                                              ? Get.toNamed(
                                                  kBannerDetailsRoute,
                                                  arguments: {
                                                    kTitle: _mainDashController
                                                        .bannersList[0]
                                                        .bannerTitle
                                                        .toString(),
                                                    kSerialNo:
                                                        _mainDashController
                                                            .bannersList[0]
                                                            .serialNo
                                                  },
                                                )
                                              : _mainDashController
                                                          .bannersList[0]
                                                          .linkType ==
                                                      "HEIC"
                                                  ? () {}
                                                  : _mainDashController
                                                      .openBanner(
                                                          _mainDashController
                                                              .bannersList[0]
                                                              .linkURL
                                                              .toString()),
                                    ),
                                  ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20, top: 20, bottom: 10),
                            child: GridView.count(
                              crossAxisCount: 4,
                              // crossAxisSpacing: MediaQuery.of(context).size.width/60,
                              mainAxisSpacing:
                                  MediaQuery.of(context).size.height / 52,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: List.generate(
                                _mainDashController.gridList.length,
                                (index) {
                                  return Column(
                                    // mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.toNamed(_mainDashController
                                                .widgets[index]);
                                          },
                                          child: Container(
                                            // color: Colors.red,
                                            decoration: BoxDecoration(
                                              color: colorController
                                                  .kCircleBgColor,
                                              borderRadius: BorderRadius.all(
                                                const Radius.circular(40.0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: index == 1
                                                  ? Image.asset(
                                                      _mainDashController
                                                          .gridList[index],
                                                      color: colorController
                                                          .kUnselectedColor,
                                                      height: MediaQuery.of(
                                                                      context)
                                                                  .devicePixelRatio >=
                                                              3.0
                                                          ? 5.h
                                                          : MediaQuery.of(context)
                                                                      .devicePixelRatio >=
                                                                  2.6
                                                              ? 3.h
                                                              : 3.h,
                                                      width: MediaQuery.of(
                                                                      context)
                                                                  .devicePixelRatio >=
                                                              3.0
                                                          ? 5.h
                                                          : MediaQuery.of(context)
                                                                      .devicePixelRatio >=
                                                                  2.6
                                                              ? 3.h
                                                              : 3.h,
                                                    )
                                                  : Image.asset(
                                                      _mainDashController
                                                          .gridList[index],
                                                      color: colorController
                                                          .kUnselectedColor,
                                                      height: MediaQuery.of(
                                                                      context)
                                                                  .devicePixelRatio >=
                                                              3.0
                                                          ? 5.h
                                                          : MediaQuery.of(context)
                                                                      .devicePixelRatio >=
                                                                  2.6
                                                              ? 3.h
                                                              : 3.h,
                                                      width: MediaQuery.of(
                                                                      context)
                                                                  .devicePixelRatio >=
                                                              3.0
                                                          ? 5.h
                                                          : MediaQuery.of(context)
                                                                      .devicePixelRatio >=
                                                                  2.6
                                                              ? 3.h
                                                              : 3.h,
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // ignore: avoid_unnecessary_containers
                                      Container(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            _mainDashController
                                                .gridListname[index],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                fontSize: 10,
                                                letterSpacing: 0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                            // GoogleFonts.poppins(
                                            //   textStyle: textStyle10black,
                                            // ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        // /// TODO New Joiners STARTS HERE//
                        Visibility(
                          visible: _mainDashController
                              .newEmployeesJoinesList.isNotEmpty,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 50, right: 50, bottom: 5, top: 0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(kNewJoinedEmployeesRoute);
                                },
                                child: Row(
                                  children: [
                                    TextWidget(
                                      status: "NEW JOINERS",
                                      fontSize: 16,
                                      letterSpacing: 0.55,
                                      color: colorController.kUnselectedColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    const Spacer(),
                                    Text(
                                      "See All",
                                      style: GoogleFonts.poppins(
                                        textStyle: textStyle10blackweight,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Image.asset(
                                          'assets/icons/right_arrow.png'),
                                    )
                                  ],
                                ),
                              )),
                        ),

                        Visibility(
                          visible: _mainDashController
                              .newEmployeesJoinesList.isNotEmpty,
                          child: Padding(
                            padding: EdgeInsets.only(left: 0, right: 0),
                            child: CarouselWidget(s: "newjoiners"),
                          ),
                        ),

                        // ///TODO New Joiners END HERE //

                        Visibility(
                          visible: _mainDashController
                              .employeesBirthDayList.isNotEmpty,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 50, right: 50, bottom: 5, top: 0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(kEmployeesBirthdayRoute);
                                },
                                child: Row(
                                  children: [
                                    TextWidget(
                                      status: "BIRTHDAY",
                                      fontSize: 16,
                                      letterSpacing: 0.55,
                                      color: colorController.kUnselectedColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    const Spacer(),
                                    Text(
                                      "See All",
                                      style: GoogleFonts.poppins(
                                        textStyle: textStyle10blackweight,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Image.asset(
                                          'assets/icons/right_arrow.png'),
                                    )
                                  ],
                                ),
                              )),
                        ),
                        Visibility(
                          visible: _mainDashController
                              .employeesBirthDayList.isNotEmpty,
                          child: Padding(
                            padding: EdgeInsets.only(left: 0, right: 0),
                            child: CarouselWidget(s: "birthday"),
                          ),
                        ),

                        Visibility(
                          visible: _mainDashController
                              .superannuationmodel.isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, bottom: 5, top: 20),
                            child: Row(
                              children: [
                                TextWidget(
                                  status: "SUPERANNUATION",
                                  fontSize: 16,
                                  letterSpacing: 0.55,
                                  color: colorController.kUnselectedColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(kEmployeesAnnuationRoute);
                                  },
                                  child: Text(
                                    "See All",
                                    style: GoogleFonts.poppins(
                                      textStyle: textStyle10blackweight,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Image.asset(
                                      'assets/icons/right_arrow.png'),
                                )
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _mainDashController
                              .superannuationmodel.isNotEmpty,
                          child: Padding(
                            padding: EdgeInsets.only(left: 0, right: 0),
                            child: CarouselWidget(s: "annuation"),
                          ),
                        ),

                        Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, bottom: 5, top: 20),
                            child: Row(
                              children: [
                                TextWidget(
                                  status: "GAIL NEWS",
                                  fontSize: 16,
                                  letterSpacing: 0.55,
                                  color: colorController.kUnselectedColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(kNewsRoute);
                                  },
                                  child: Text("See All",
                                      style: GoogleFonts.poppins(
                                        textStyle: textStyle10blackweight,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Image.asset(
                                      'assets/icons/right_arrow.png'),
                                )
                              ],
                            )),

                        _mainDashController.newsCategoryList.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: MaterialCard(
                                  borderRadius: 12,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      color: Colors.white,
                                      child: Center(
                                        child:
                                            const Text("No Records found !!"),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : CarouselSlider(
                                options: CarouselOptions(
                                  enableInfiniteScroll: false,
                                  // enlargeCenterPage: false,
                                  disableCenter: true,
                                  viewportFraction: 0.75,
                                  // aspectRatio: 2.0,
                                  initialPage: 1,
                                  aspectRatio: 2,
                                  enlargeCenterPage: true,
                                ),
                                items: _mainDashController.activeNewsList.map(
                                  (ActiveNews _newsCategory) {
                                    final _eventDateArr = _newsCategory.date
                                        .toString()
                                        .split(' ');

                                    return MaterialCard(
                                      borderRadius: 12,
                                      padding: const EdgeInsets.only(),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 2),
                                      // calling open news method
                                      onTap: () async {
                                        final DefaultCacheManager
                                            _defaultCacheManager =
                                            DefaultCacheManager();
                                        await _defaultCacheManager.emptyCache();
                                        Get.to(PdfViewer(
                                          pdfurl:
                                              // pfile.path,
                                              '${kNewsPDFURL}${_newsCategory.file}',
                                          title: "GAIL NEWS",
                                          type: 'pdf',
                                        ));
                                      },
                                      child: LayoutBuilder(
                                        builder: (context, constraint) =>
                                            Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  // shape: BoxShape
                                                  //     .circle,
                                                  color: colorController
                                                      .kPrimaryDarkColor),
                                              child: Center(
                                                child: Text(
                                                    _newsCategory.date
                                                        .toString()
                                                        .trim(),
                                                    style: textStyle18Bold
                                                        .copyWith(
                                                            color:
                                                                Colors.white)),
                                              ),
                                            ),
                                            Flexible(
                                                child: _newsCategory.image
                                                            .toString() !=
                                                        "null"
                                                    ? Image.network(
                                                        kNewsImageURL +
                                                            _newsCategory.image
                                                                .toString()
                                                                .trim(),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            4,
                                                        width: 600,
                                                      )
                                                    : Image.asset(
                                                        "assets/icons/gail_logo.png",
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            4,
                                                        width: 600,
                                                      )
                                                //
                                                ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),

                        Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, bottom: 5, top: 20),
                            child: Row(
                              children: [
                                TextWidget(
                                  status: "INDUSTRY NEWS",
                                  fontSize: 16,
                                  letterSpacing: 0.55,
                                  color: colorController.kUnselectedColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                // Text(
                                //   "GAIL NEWS",
                                //   style: GoogleFonts.inter(
                                //     textStyle: textStyle18brown16,
                                //   ),
                                // ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(kNewsRoute);
                                  },
                                  child: Text("See All",
                                      style: GoogleFonts.poppins(
                                        textStyle: textStyle10blackweight,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Image.asset(
                                      'assets/icons/right_arrow.png'),
                                )
                              ],
                            )),

                        _mainDashController.newsCategoryListind.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: MaterialCard(
                                  borderRadius: 12,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 100,
                                      color: Colors.white,
                                      child: Center(
                                        child:
                                            const Text("No Records found !!"),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : CarouselSlider(
                                options: CarouselOptions(
                                  enableInfiniteScroll: false,
                                  // enlargeCenterPage: false,
                                  disableCenter: true,
                                  viewportFraction: 0.75,
                                  // aspectRatio: 2.0,
                                  initialPage: 1,
                                  aspectRatio: 2,
                                  enlargeCenterPage: true,
                                  // height: _height *
                                  //     (_height < 600
                                  //         ? .18
                                  //         : (_height > 601 && _height < 900)
                                  //             ? .300
                                  //             : .11),
                                  // autoPlay: true,
                                  // aspectRatio: 1.0,
                                  // initialPage: 0,
                                  // viewportFraction: 0.9,
                                  // // enlargeCenterPage: true,
                                  // enableInfiniteScroll: false,
                                ),
                                items: _mainDashController.activeNewsListIn.map(
                                  (ActiveNews _newsCategory) {
                                    final _eventDateArr = _newsCategory.date
                                        .toString()
                                        .split(' ');

                                    return MaterialCard(
                                      borderRadius: 12,
                                      padding: const EdgeInsets.only(),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 2),
                                      // calling open news method
                                      onTap: () async {
                                        final DefaultCacheManager
                                            _defaultCacheManager =
                                            DefaultCacheManager();
                                        await _defaultCacheManager.emptyCache();
                                        Get.to(PdfViewer(
                                          pdfurl:
                                              // pfile.path,
                                              '${kNewsPDFURLIND}${_newsCategory.file}',
                                          title: "INDUSTRY NEWS",
                                          type: 'pdf',
                                        ));
                                      },
                                      child: LayoutBuilder(
                                        builder: (context, constraint) =>
                                            Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  // shape: BoxShape
                                                  //     .circle,
                                                  color: colorController
                                                      .kPrimaryDarkColor),
                                              child: Center(
                                                child: Text(
                                                    _newsCategory.date
                                                        .toString()
                                                        .trim(),
                                                    style: textStyle18Bold
                                                        .copyWith(
                                                            color:
                                                                Colors.white)),
                                              ),
                                            ),

                                            //"https://gailebank.gail.co.in/GAIL_Connect_News_all/UploadedImage/230906112006logo (1).png"
                                            Flexible(
                                                child: _newsCategory.image
                                                            .toString() !=
                                                        "null"
                                                    ? Image.network(
                                                        kNewsImageURLIND +
                                                            _newsCategory.image
                                                                .toString()
                                                                .trim(),
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            4,
                                                        width: 600,
                                                      )
                                                    : Image.asset(
                                                        "assets/icons/gail_logo.png",
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            4,
                                                        width: 600,
                                                      )
                                                //
                                                ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                        //LIVE EVENTS //
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 20, bottom: 10, top: 20),
                            child: Row(
                              children: [
                                TextWidget(
                                  status: "LIVE EVENTS",
                                  fontSize: 16,
                                  letterSpacing: 0.55,
                                  color: colorController.kUnselectedColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 0, right: 0, bottom: 20),
                          child: Container(
                            height: 200,
                            // width: 200,
                            decoration: BoxDecoration(
                                // color: kColor9,
                                // color: Colors.black,
                                borderRadius: BorderRadius.circular(40)),
                            // ignore: prefer_const_constructors
                            child: CarouselSlider(
                              options: CarouselOptions(
                                // autoPlay: true,
                                enableInfiniteScroll: false,
                                // enlargeCenterPage: false,
                                disableCenter: true,
                                viewportFraction: 0.75,
                                // aspectRatio: 2.0,
                                initialPage: 1,
                                aspectRatio: 1.5,
                                enlargeCenterPage: true,
                                height: _height *
                                    (_height < 600
                                        ? .13
                                        : (_height > 601 && _height < 900)
                                            ? .300
                                            : .11),
                              ),
                              items: _mainDashController.gailEventBanner
                                  // ignore: avoid_unnecessary_containers
                                  .map((item) => Stack(
                                        children: [
                                          Container(
                                            child: Container(
                                              // margin: const EdgeInsets.all(5.0),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          const Radius.circular(
                                                              12.0)),
                                                  child: Stack(
                                                    children: <Widget>[
                                                      if (item
                                                              .toString()
                                                              .contains(
                                                                  "youtube") ||
                                                          item
                                                              .toString()
                                                              .contains(
                                                                  "nic")) ...[
                                                        //      Platform.isAndroid?
                                                        // WebViewWidget(controller: _controller..loadRequest(Uri.parse('https://www.youtube.com/embed/@GAILIndiaLimited'))):
                                                        ///TODO :: inappwebview
                                                        InAppWebView(
                                                          initialUrlRequest:
                                                              URLRequest(
                                                                  url: WebUri(
                                                                      item)),
                                                        ),
                                                      ] else ...[
                                                        WebViewWidget(
                                                            controller:
                                                                WebViewController()
                                                                  ..setJavaScriptMode(
                                                                      JavaScriptMode
                                                                          .unrestricted)
                                                                  ..loadFlutterAsset(
                                                                      item))
                                                      ],
                                                      Positioned(
                                                        bottom: 0.0,
                                                        left: 0.0,
                                                        right: 0.0,
                                                        child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                Color.fromARGB(
                                                                    200,
                                                                    0,
                                                                    0,
                                                                    0),
                                                                Color.fromARGB(
                                                                    0, 0, 0, 0)
                                                              ],
                                                              begin: Alignment
                                                                  .bottomCenter,
                                                              end: Alignment
                                                                  .topCenter,
                                                            ),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      10.0,
                                                                  horizontal:
                                                                      20.0),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                          Container(
                                            child: GestureDetector(
                                              onTap: () {
                                                print("sdfghj");
                                                print(item);
                                                // launh("https://pmindiawebcast.nic.in/")
                                                Get.to(PdfViewer(
                                                  pdfurl: item,
                                                  title: "GAIL Events",
                                                  type: "url",
                                                ));
                                              },
                                            ),
                                          )
                                        ],
                                      ))
                                  .toList(),
                            ),

                            // WebView(
                            //   initialUrl:
                            //       "https://twitter.com/gailindia?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor",
                            //   javascriptMode: JavascriptMode.unrestricted,
                            //   // onPageStarted: (_url) => _browserController.onPageFinished(loading: true),
                            //   // onPageFinished: (_url) => _browserController.onPageFinished(loading: false),
                            // ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
