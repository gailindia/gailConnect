// Created By Amit Jangid 24/08/21

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:secure_shared_preferences/secure_shared_pref.dart';

import '../styles/color_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<Offset> animation;
  late AnimationController animationController;
  late Animation<double> animation2;
  late AnimationController animationController2;
  bool? theme;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*late AnimationController animationController =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: false);
    late Animation<double> animation =
    CurvedAnimation(parent: animationController, curve: Curves.easeIn);*/
    getTheme();
    animationController =
        AnimationController(duration: Duration(seconds: 4), vsync: this);
    animation = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0, -1.2))
        .animate(animationController);
    animationController.forward();

    animationController2 =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    animation2 = CurvedAnimation(
        parent: animationController2, curve: Curves.fastOutSlowIn);
  }

  getTheme() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    theme = await pref.getBool("isSwitch");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    animationController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    // final SharedPrefs sharedPrefs = SharedPrefs.to;
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return
          //   ScaleTransition(
          //     alignment: Alignment.bottomCenter,
          //     scale: animation2,
          //     child: const LogoWidget()
          // );
          Container(
        color: colorController.kPrimaryColor,
        width: double.infinity,
        height: double.infinity,
        child: theme ?? false
            ? Image.asset(
                "assets/animation_splash_purple.gif",
                fit: BoxFit.fitHeight,
              )
            : Image.asset(
                "assets/animation_splash.gif",
                fit: BoxFit.fitHeight,
              ),
      );
    });
  }
}
