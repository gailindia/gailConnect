// Created By Amit Jangid 07/09/21

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:gail_connect/utils/utils.dart';
import 'package:get/get.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UsefulLinksController extends GetxController {
  String holidayListPdf = '';
  String _empGroupAdminCheck = '';
  WebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    // calling get holiday list method
    getHolidayList();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    GailConnectServices.to.hitCountApi(
        activity: kUsefulLinksScreen, activityScreen: "/usefulLinks");
  }

  getHolidayList() async {
    // calling get holiday list api method
    holidayListPdf = await GailConnectServices.to.getHolidayListApi();
    final DefaultCacheManager _defaultCacheManager = DefaultCacheManager();
    await _defaultCacheManager.emptyCache();
  }

  getEmpGroupAdminCheckApi() async {
    // calling get holiday list api method
    _empGroupAdminCheck =
        await GailConnectServices.to.getEmpGroupAdminCheckApi();
  }

  openSugamWebsite() {
    _openLink(title: kSugam, link: kSugamUrl);

    // calling hit count api method
    GailConnectServices.to.hitCountApi(activity: kSugam);
  }

  openGailTenders() {
    _openLink(title: kGailTenders, link: kGailTendersUrl);

    // calling hit count api method
    GailConnectServices.to.hitCountApi(activity: 'GAIL Tenders');
  }

  openGailWebsite() {
    _openLink(title: kGailWebsite, link: kGailWebsiteUrl);

    // calling hit count api method
    GailConnectServices.to.hitCountApi(activity: 'GAIL Website');
  }

  openGailIntranet() {
    _openLink(title: kGailIntranet, link: kGailIntranetUrl);

    // calling hit count api method
    GailConnectServices.to.hitCountApi(activity: 'GAIL Intranet');
  }

  openHolidayList() {
    _openLink(title: kHolidayListEnglish, link: '$kFileUrl$holidayListPdf');

    // calling hit count api method
    GailConnectServices.to.hitCountApi(activity: 'Holiday List');
  }

  openMyLibrary() async{
    SecureSharedPref pref = await SecureSharedPref.getInstance();
    final String cpfNumber = (await  pref.getString("cpfNumber",isEncrypted: true))!;

    _openLink(
        title: kMyLibrary,
        link: '$kMyLibraryUrl${trimLeadingZeros(cpfNumber)}');

    // calling hit count api method
    GailConnectServices.to.hitCountApi(activity: 'My Library');
  }

  openHindiShabdavali() {
    _openLink(title: kHindiShabdavali, link: kHindiShabdavaliUrl);

    // calling hit count api method
    GailConnectServices.to.hitCountApi(activity: 'Hindi Shabdavali');
  }

  openMMTCODE() {
    _openLink(title: kMMTCODE, link: kMMTCodeUrl);

    // calling hit count api method
    GailConnectServices.to.hitCountApi(activity: 'Hindi Shabdavali');
  }

  openGailPrashashanikShabadKosh() {
    _openLink(
        title: kGailPrashashanikShabadKosh,
        link: kGailPrashashanikShabadKoshUrl);

    // calling hit count api method
    GailConnectServices.to
        .hitCountApi(activity: 'GAIL Prashashanik Shabd Kosh');
  }

  openGailATC() {
    _openLink(title: kGailATCalender, link: kGailATCalenderURL);

    // calling hit count api method
    GailConnectServices.to
        .hitCountApi(activity: 'GAIL Prashashanik Shabd Kosh');
  }

  openGailWfh() {
    _openLink(title: kGailWfh, link: kGailWfhUrl);

    // calling hit count api method
    GailConnectServices.to.hitCountApi(activity: 'GAIL WFH');
  }

  _openLink({required String title, required String link}) async {


    await launch(link+title);
  }

  loadHtmlFromAssets(String path) async {
    String fileHtmlContents = await rootBundle.loadString(path);
    webViewController?.loadRequest(Uri.dataFromString(fileHtmlContents,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8')));
  }
}
