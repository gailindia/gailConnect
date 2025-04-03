// Created By Amit Jangid 02/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gail_connect/models/news_category.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/utils/constants/http_constants.dart';
import 'package:gail_connect/core/controllers/news_controllers/news_controller.dart';

class NewsCatController extends GetxController {
  bool isLoading = true;
  bool isConnected = true;
  late NewsCategory selectedNewsCategory = newsCategoryList[0];

  List<NewsCategory> newsCategoryList = [];
  final FixedExtentScrollController fixedExtentScrollController =
      FixedExtentScrollController();

  @override
  void onInit() {
    super.onInit();

    // calling news category method
    getNewsCategory();
  }

  /*@override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: 'News Category Screen');
  }*/

  getNewsCategory() async {
    // calling check connectivity method
    isConnected = await checkConnectivity();
    update([kNewsCategory]);

    if (isConnected) {
      isLoading = true;

      // calling get news by category api method
      newsCategoryList = await GailConnectServices.to.getNewsByCategoryApi(
        newsCategory: NewsController.to.newsCategory,
      );

      isLoading = false;
      update([kNewsCategory]);
    }
  }

  openNews({required String newsLink}) async {
    debugPrint('date of news link is: $newsLink');
    String newsLink1 = newsLink.replaceAll(RegExp(' +'), '%20');
    debugPrint(kNewsPdfApi + newsLink1);
    await launch('$kNewsPdfApi$newsLink1');
  }
}
