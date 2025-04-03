// Created By Amit Jangid 20/10/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class WhatsNewModel {
  String? content, periodFrom, periodTo, image, title;
  double? id;

  // "ID": 2.0,
  //     "CONTENT": "gfdb",
  //     "PERIOD_FROM": "2023-01-18T20:00:00",
  //     "PERIOD_TO": "2023-01-20T19:00:00",
  //     "IMAGE": "fd",
  //     "TITLE": "ghg"

  WhatsNewModel(
      {required this.id,
      required this.content,
      required this.periodFrom,
      required this.periodTo,
      required this.image,
      required this.title});

  factory WhatsNewModel.fromJson(Map<String, dynamic> _bannerDetailsJson) =>
      WhatsNewModel(
          id: _bannerDetailsJson["ID"],
          title: _bannerDetailsJson["TITLE"],
          image: _bannerDetailsJson[kJsonImage],
          content: _bannerDetailsJson["CONTENT"],
          periodFrom: _bannerDetailsJson[kJsonWPeriodFrom],
          periodTo: _bannerDetailsJson[kJsonWPEriodTo]);
}
