// Created By Amit Jangid 25/08/21

import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:gail_connect/ui/widgets/marquee.dart';
import 'package:get/get.dart';
import 'package:gail_connect/config/routes.dart';
import 'package:multiutillib/multiutillib_flutter.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/side_drawer.dart';

import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/main_dash_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import '../../core/controllers/app_version_controller.dart';
import '../styles/color_controller.dart';

class MainDashScreen extends StatefulWidget {
  const MainDashScreen({Key? key}) : super(key: key);

  @override
  _MainDashScreenState createState() => _MainDashScreenState();
}

class _MainDashScreenState extends State<MainDashScreen>
    with TickerProviderStateMixin {
  late Animation<double> _carouselAnimation;
  late AnimationController _carouselAnimationController,
      _sideDrawerAnimationController;

  final ScrollController _scrollController = ScrollController();
  // ColorController colorController = Get.put(ColorController());

  @override
  void initState() {
    super.initState();

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
    // ColorController colorController = Get.put(ColorController());
    /*for getting check updated dialog*/
    AppVersionController versionController = Get.put(AppVersionController());
    /*for getting check updated dialog end here*/
    return WillPopScope(
      onWillPop: () {
        if (_sideDrawerAnimationController.isDismissed) {
          return Future.value(true);
        } else {
          _sideDrawerAnimationController.reverse();
          return Future.value(false);
        }
      },
      child: GetBuilder<MainDashController>(
          id: kDashboard,
          builder: (_mainDashController) {
            return GetBuilder<ColorController>(
                id: kDashboard,
                builder: (colorController) {
                  return Scaffold(
                    backgroundColor: colorController.kHomeBgColor,
                    extendBodyBehindAppBar: true,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      titleSpacing: 0.0,
                      iconTheme:
                          IconThemeData(color: colorController.kBlackColor),
                      title: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: FittedBox(
                          child: Text(
                            // "Welcome Amit Welcome ",
                            "Welcome ${_mainDashController.loggedInEmployee == null ? "" : _mainDashController.loggedInEmployee!.empName!.toTitleCase()}",
                            maxLines: 1,
                            style:
                                TextStyle(color: colorController.kBlackColor),
                            textAlign: TextAlign.start,
                            textScaleFactor: 1,
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        // ignore: avoid_unnecessary_containers
                        Container(
                          child: Image.asset(
                            "assets/icons/gail_logo.png",
                            scale: 4,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                    drawer: SideDrawer(),
                    body: Stack(
                      children: [
                        Container(
                          color: colorController.kHomeBgColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [Image.asset(colorController.img)],
                          ),
                        ),
                        Column(
                          children: [
                            Expanded(
                              child: SafeArea(
                                  bottom: false,
                                  child: _mainDashController
                                      .pages[_mainDashController.pageIndex]),
                            ),
                            Container(
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context)
                                                .devicePixelRatio >=
                                            3.0
                                        ? 11.h
                                        : MediaQuery.of(context)
                                                    .devicePixelRatio >=
                                                2.6
                                            ? 10.h
                                            : 8.h,
                                    decoration: BoxDecoration(
                                      color: colorController.kCircleBgColor,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        topLeft: Radius.circular(30),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: BottomNavigationBar(
                            backgroundColor: Colors.transparent,
                            type: BottomNavigationBarType.fixed,
                            currentIndex: _mainDashController.pageIndex,
                            showSelectedLabels: true,
                            showUnselectedLabels: true,
                            elevation: 0.0,
                            selectedItemColor: colorController.kSelectedColor,
                            unselectedItemColor:
                                colorController.kUnselectedColor,
                            selectedLabelStyle: TextStyle(
                                fontSize: 12,
                                color: colorController.kSelectedColor,
                                fontWeight: FontWeight.bold),
                            unselectedLabelStyle: TextStyle(
                                fontSize: 12,
                                color: colorController.kUnselectedColor,
                                fontWeight: FontWeight.bold),
                            onTap: (index) {
                              _mainDashController.changeTab(index);
                            },
                            items: [
                              BottomNavigationBarItem(
                                icon: bottomButtonDesign(
                                    0,
                                    50,
                                    50,
                                    "assets/icons/apps_icon.png",
                                    "assets/icons/apps_icon.png",
                                    colorController.kUnselectedColor,
                                    colorController.kSelectedColor,
                                    1.3,
                                    _mainDashController),
                                label: 'Apps',
                              ),
                              BottomNavigationBarItem(
                                  icon: bottomButtonDesign(
                                      1,
                                      50,
                                      50,
                                      "assets/icons/employee_icon.png",
                                      "assets/icons/employee_icon.png",
                                      colorController.kUnselectedColor,
                                      colorController.kSelectedColor,
                                      1.3,
                                      _mainDashController),
                                  label: 'Employee'),
                              BottomNavigationBarItem(
                                  icon: bottomButtonDesign(
                                      2,
                                      70,
                                      70,
                                      "assets/icons/home_icon.png",
                                      "assets/icons/home_icon.png",
                                      colorController.kUnselectedColor,
                                      colorController.kSelectedColor,
                                      0.75,
                                      _mainDashController),
                                  label: ''),
                              BottomNavigationBarItem(
                                  icon: bottomButtonDesign(
                                      3,
                                      50,
                                      50,
                                      "assets/icons/group.png",
                                      "assets/icons/group.png",
                                      colorController.kUnselectedColor,
                                      colorController.kSelectedColor,
                                      1,
                                      _mainDashController),
                                  label: 'Medicine'),
                              BottomNavigationBarItem(
                                  icon: bottomButtonDesign(
                                      4,
                                      50,
                                      50,
                                      "assets/icons/more_icon.png",
                                      "assets/icons/more_icon.png",
                                      colorController.kUnselectedColor,
                                      colorController.kSelectedColor,
                                      1,
                                      _mainDashController),
                                  label: 'More'),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                });
          }),
    );
  }

  Widget bottomButtonDesign(
      int index,
      double width,
      double height,
      String firstImage,
      String secondImage,
      Color iconColor1,
      Color iconColor2,
      double scale,
      MainDashController mainDashController) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: mainDashController.pageIndex == index ? iconColor2 : iconColor1,
        borderRadius: BorderRadius.all(
          Radius.circular(height / 2),
        ),
      ),
      child: firstImage.contains(".svg")
          ? SvgPicture.asset(
              mainDashController.pageIndex == index ? firstImage : secondImage,
              height: 18,
              width: 18,
              // scale: scale,
              color: Colors.white)
          : Image.asset(
              mainDashController.pageIndex == index ? firstImage : secondImage,
              height: 18,
              width: 18,
              scale: scale,
              color: Colors.white),
    );
  }

  @override
  void dispose() {
    _carouselAnimationController.dispose();
    _sideDrawerAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  whatsNewWidget(_mainDashController, _height) {
    return Visibility(
      visible: //false,
          _mainDashController.isSnackbarActive,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    // Color.fromARGB(118, 255, 243, 163),
                    // Color.fromARGB(135, 255, 220, 194),
                    Color.fromARGB(255, 255, 194, 204),
                    Color.fromARGB(118, 98, 39, 236),
                  ],
                ),
              ),
              width: double.infinity,
              height: _height * 0.05,
              child: Center(
                child: Row(
                  children: [
                    horizontalSpace3,
                    const Icon(
                      Icons.announcement_outlined,
                      color: Color.fromARGB(255, 255, 249, 185),
                    ),
                    horizontalSpace3,
                    Expanded(
                      child: FittedBox(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 249, 185),
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              // const TextSpan(text: 'By clicking Sign Up, you agree to our '),
                              TextSpan(
                                text:
                                    'Tap here to see what\'s new in this release',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(kWhtsnewRoute);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            verticalSpace12,
          ],
        ),
      ),
    );
  }

  openLink({String? title, String? link}) async {
    await launch(link!);

    GailConnectServices.to.hitCountApi(activity: title!);
  }

  Widget activeNewsWidget(
      MainDashController _mainDashController, BuildContext context) {
    return Container(
      // key: key,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.050,
      // margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 224, 231, 251), //kGailYellowColor,
      ),
      // height: 12,
      // padding:EdgeInsets.only(),
      padding: const EdgeInsets.only(
        top: 6,
        left: 8,
        right: 8,
        bottom: 6,
      ),
      child: //IntroStepBuilder(

          MarqueeWidget(
        animationDuration: Duration(
            milliseconds: _mainDashController.activeNewsLength! < 130
                ? 6000
                : _mainDashController.activeNewsLength! > 130 &&
                        _mainDashController.activeNewsLength! < 230
                    ? 15000
                    : _mainDashController.activeNewsLength! > 230 &&
                            _mainDashController.activeNewsLength! < 330
                        ? 25000
                        : _mainDashController.activeNewsLength! > 330 &&
                                _mainDashController.activeNewsLength! < 430
                            ? 35000
                            : _mainDashController.activeNewsLength! > 430 &&
                                    _mainDashController.activeNewsLength! < 530
                                ? 45000
                                : _mainDashController.activeNewsLength! > 530 &&
                                        _mainDashController.activeNewsLength! <
                                            630
                                    ? 55000
                                    : _mainDashController.activeNewsLength! >
                                                630 &&
                                            _mainDashController
                                                    .activeNewsLength! <
                                                730
                                        ? 65000
                                        : 130000),
        backDuration: const Duration(milliseconds: 10),
        pauseDuration: const Duration(milliseconds: 5000),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: _mainDashController.activeNewsList.length,
          itemBuilder: (context, index) {
            String _url = Uri.encodeFull(
                "https://gailebank.gail.co.in/GAIL_Connect_News_all/UploadedPDF/" +
                    _mainDashController.activeNewsList[index].file.toString());
            // print("HELLO:" + url);
            return Center(
              child: GestureDetector(
                onTap: () => openLink(
                  title: _mainDashController.activeNewsList[index].title
                      .toString(),
                  link: _url,
                ),
                child: Text(
                  // "No matching configuration of project :flutter_sms was found. The consumer was configured to find an API of a component, as well as attribute 'com.android.build.api.attributes.BuildTypeAttr' with value 'release' but:"
                  _mainDashController.activeNewsList.length == 1
                      ? _mainDashController.activeNewsList[index].title
                          .toString()
                      : _mainDashController.activeNewsList[index].title
                              .toString() +
                          "    |    ",
                  style: textStyle16Bold,
                ),
              ),
            );
          },
        ),
      ),
      // ),
    );
  }
}
