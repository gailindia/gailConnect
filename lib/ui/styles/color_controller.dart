/*
   * -----------------!! Created by Himanshu Shukla !!-----------------------
   *  ---------------- All Rights reserved for Gail India--------------------
   */

import 'dart:ui';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';

import '../../utils/constants/app_constants.dart';

class ColorController extends GetxController {
  var kPrimaryColor = Color(0xFFB68571);
  var kPrimaryDarkColor = Color(0xFF8C5040);
  var kPrimaryLightColor = Color(0xFFd8ab99);
  var kIconBGColor = Color(0xffCEBBB0);

  var kColorshadow = Color(0x40000000);
//const kColor8 = Color(0xFFd49977);
  var kCircleBgColor = Color(0xfffffefe);
  var kHomeBgColor = Color(0xffDDD2C6);
  var kUnselectedColor = Color(0xff883A3A);
  var kSelectedColor = Color(0xFF46181D);

  var kBgColor = Color(0xFFDDD2C6);
  var kBgPopupColor = Color(0xFFCEBBB0);
  var kDarkGreyColor = Color(0xFF707070);

  var kBlackColor = Color(0xFF16161D);
  var kBlackShadeColor = Color(0xFF555555);
  var kchartcloseColor = Color(0xff883A3A);
  String img = 'assets/icons/appbar_bg.png';

  var kObesity = Color(0xFF8A0101);
  var kInterMediate = Color(0xFFBC2020);
  var kNormal = Color(0xFFD38888);
  var kUnderWeight = Color(0xFFE4B3B3);

  switchTheme() async {
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    bool? theme = (await pref.getBool("isSwitch"));

    if (theme ?? false) {
      kPrimaryColor = Color(0xFF8F85BB);
      kPrimaryDarkColor = Color(0xFF7F79B9);
      kPrimaryLightColor = Color(0xFFBFA8C0);

      kColorshadow = Color(0xFF000000);
//const kColor8 = Color(0xFFd49977);
      kCircleBgColor = Color(0xFFF1F0FC);
      kHomeBgColor = Color(0xFFffffff);
      kUnselectedColor = Color(0xFF383466);
      kSelectedColor = Color(0xFF09053B);
      kIconBGColor = Color(0xFFBFA8C0);

      // kBgColor = Color(0xFF383466);
      kBgColor = Color(0xFF8F85BB);
      kBgPopupColor = Color(0xFFC4C3D3);
      kDarkGreyColor = Color(0xFF000000);

      kBlackColor = Color(0xFF000000);
      kBlackShadeColor = Color(0xFF000000);
      kchartcloseColor = Color(0xff62559C);
      img = 'assets/icons/appbar_bg_blue.png';

      kObesity = Color(0xFF5315bf);
      kInterMediate = Color(0xFF7a52bf);
      kNormal = Color(0xFFa483de);
      kUnderWeight = Color(0xFFd4c1f5);

      update(["color"]);
      update([kEmpDash]);
      update([kDashboard]);
      update([kProfileSettings]);
      update([kDispensary]);
      update([kDispensaryHistory]);
    } else {
      kPrimaryColor = Color(0xFFB68571);
      kPrimaryDarkColor = Color(0xFF8C5040);
      kPrimaryLightColor = Color(0xFFd8ab99);

      kIconBGColor = Color(0xffCEBBB0);
      kColorshadow = Color(0x40000000);
//const kColor8 = Color(0xFFd49977);
      kCircleBgColor = Color(0xfffffefe);
      kHomeBgColor = Color(0xffDDD2C6);
      kUnselectedColor = Color(0xff883A3A);
      kSelectedColor = Color(0xFF46181D);

      kBgColor = Color(0xFFDDD2C6);
      kBgPopupColor = Color(0xFFCEBBB0);
      kDarkGreyColor = Color(0xFF707070);

      kBlackColor = Color(0xFF16161D);
      kBlackShadeColor = Color(0xFF555555);
      kchartcloseColor = Color(0xff883A3A);
      img = 'assets/icons/appbar_bg.png';

      kObesity = Color(0xFF8A0101);
      kInterMediate = Color(0xFFBC2020);
      kNormal = Color(0xFFD38888);
      kUnderWeight = Color(0xFFE4B3B3);

      update(["color"]);
      update([kEmpDash]);
      update([kDashboard]);
      update([kProfileSettings]);
      update([kDispensary]);
      update([kDispensaryHistory]);
      update([kEmployees]);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    switchTheme();
    cacheManger();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void cacheManger() async {
    final DefaultCacheManager _defaultCacheManager = DefaultCacheManager();
    await _defaultCacheManager.emptyCache();
  }

  // var  kPrimaryColor1 =  Color(0xFFB68571);

  /*const kPrimaryDarkColor = Color(0xFF8C5040);
  const kPrimaryLightColor = Color(0xFFd8ab99);


  const kColorshadow = Color(0x40000000);
//const kColor8 = Color(0xFFd49977);
  const kCircleBgColor = Color(0xfffffefe);
  const kUnselectedColor = Color(0xff883A3A);
  const kSelectedColor = Color(0xFF46181D);

  const kBgColor = Color(0xFFDDD2C6);
  const kBgPopupColor = Color(0xFFCEBBB0);
  const kDarkGreyColor = Color(0xFF707070);

  const kBlackColor = Color(0xFF16161D);
  const kBlackShadeColor = Color(0xFF555555);*/
}
